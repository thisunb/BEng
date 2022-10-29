import flask_cors
import pandas as pd
import numpy as np
from tqdm.notebook import tqdm
from sklearn.preprocessing import MinMaxScaler
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.callbacks import TensorBoard
import warnings
import pymongo
import certifi
from keras.wrappers.scikit_learn import KerasRegressor
from math import sqrt
from sklearn.metrics import mean_squared_error
from sklearn.metrics import mean_absolute_error
from sklearn.model_selection import GridSearchCV
import datetime
import time
import shutil
from flask import Flask, request
import os
import json

warnings.filterwarnings("ignore")

# --------------------------------------------- Defining Global Variables ---------------------------------------------
# ---Misc variables---
item_name = ""
tensor_board = TensorBoard()
server_response = {}
is_first_server_response = True

# --- Data frame variables ---
data_frame = pd.DataFrame()
missing_data_imputed_data_frame = pd.DataFrame()
finalized_multivariate_data_frame = pd.DataFrame()

# --- Missing value variables ---
missing_data_imputed_method = ""
target_var_name = ""
values_missing_boolean = False
values_missing_percentage = 0
values_missing_row_count = 0

# --- Model training & tuning variables ---
WINDOW_SIZE = 90
FEATURE_COUNT = 18
TRAIN_SIZE = 0.8
train_size, test_size = 0, 0
normalizer = MinMaxScaler()
x_train, y_train, x_test, y_test = [], [], [], []
forecast_method = ""
selected_model_params = {
    "alpha": 0.1,
    "batch_size": 64,
    "dropout_rate": 0.1,
    "epochs": 10,
    "neurons": 64
}
model_parameter_tuning_data = {}
model_train_data = {}
train_pending = False

# --- Forecast data variables ---
commodity_data = {}
commodities_data_list = []
forecast_data = []
forecast_pending = False

# --- Mongo variables ---
MONGO_URL = "mongodb+srv://commodity_data:commodity_data12345678@cluster0.w1pij.mongodb.net"
mongo_client = pymongo.MongoClient(MONGO_URL, tlsCAFile=certifi.where())


# ---------------------------------------------- Defining functions ----------------------------------------------------
# ------ Check for missing values -------
def calc_missing_values(df, item_name):
    df[df == 0] = np.nan
    item_name_null = item_name + '_null'
    df[item_name_null] = np.where(df[item_name].isnull() | (df[item_name] == 0), 1, 0)
    global values_missing_percentage, values_missing_row_count
    values_missing_row_count = df[item_name_null].sum()
    values_missing_percentage = ((df[item_name_null].mean()) * 100)
    values_missing_percentage = round(values_missing_percentage, 2)
    print("\nMissing Value Percentage for " + item_name + " = " + str(values_missing_percentage) + "\n")

    global values_missing_boolean
    if values_missing_percentage == 0:
        values_missing_boolean = False
    else:
        values_missing_boolean = True

    # -------------------------------------- Missing value imputation --------------------------------------------------
    if values_missing_boolean:
        print("****** Missing Value Imputation ******\n")

        # ------------------------------- End of distribution method (edm) ---------------------------------------------
        # --- Duplicating original data frame to new variable ---
        print("-- End of distribution method --")
        edm_df = df.copy()

        def calc_missing_efm(edm_data_frame, item, median, edm_value):
            edm_data_frame[item + "_end_distribution"] = edm_df[item_name].fillna(edm_value)

        edm_value = edm_df[item_name].mean() + 3 * edm_df[item_name].std()
        calc_missing_efm(edm_df, item_name, edm_df[item_name].median(), edm_value)
        print('Value of end of distribution = ' + str(edm_value))
        print('Standard Deviation => ' + item_name + ' (original) = ' + str(df[item_name].std()))
        print('Standard Deviation => ' + item_name + ' (edm imputed) = ' + str(edm_df[item_name +
                                                                                      "_end_distribution"].std()))
        std_difference_edm = df[item_name].std() - edm_df[item_name + "_end_distribution"].std()
        if std_difference_edm < 0:
            std_difference_edm = (std_difference_edm * -1)
        print('Standard Deviation difference => ' + item_name + ' = ' + str(std_difference_edm))
        print("\n")

        # --------------------------------------- Median imputation method ---------------------------------------------
        # --- Duplicating original data frame to new variable ---
        print("-- Median imputation method --")
        mim_df = df.copy()

        def calc_missing_median(mim_df, item_name, median):
            mim_df[item_name + "_median"] = mim_df[item_name].fillna(median)

        median = mim_df[item_name].median()
        print('Median value for ' + item_name + ' price = ' + str(median))

        # --- Executing function for median imputation ---
        calc_missing_median(mim_df, item_name, median)

        # --- Calculating standard deviation values ---
        print('Standard Deviation => ' + item_name + ' (original) = ' + str(df[item_name].std()))
        print('Standard Deviation => ' + item_name + ' (median imputed) = ' + str(mim_df[item_name + '_median'].std()))
        std_difference_mim = mim_df[item_name].std() - mim_df[item_name + '_median'].std()
        if std_difference_mim < 0:
            std_difference_mim = (std_difference_mim * -1)
        print('Standard Deviation difference => ' + item_name + ' = ' + str(std_difference_mim))
        print("\n")

        # --------------------------------------- Random sampled method ------------------------------------------------
        # --- Duplicating original data frame to new variable ---
        print("-- Random sampled method --")
        rsm_df = df.copy()

        def calc_missing_rsm(rsm_df, item_name):
            rsm_df[item_name + '_random'] = rsm_df[item_name]
            random_sample = rsm_df[item_name].dropna().sample(rsm_df[item_name].isnull().sum(), random_state=0)
            random_sample.index = rsm_df[rsm_df[item_name].isnull()].index
            rsm_df.loc[rsm_df[item_name].isnull(), item_name + '_random'] = random_sample
            print("Random samples: ")
            print(random_sample)

        # --- Executing function for random sampled method ---
        calc_missing_rsm(rsm_df, item_name)

        print('Standard Deviation => ' + item_name + ' (original) = ' + str(df[item_name].std()))
        print('Standard Deviation => ' + item_name + ' (random sampled) = ' + str(rsm_df[item_name + '_random'].std()))
        std_difference_rsm = rsm_df[item_name].std() - rsm_df[item_name + '_random'].std()
        if std_difference_rsm < 0:
            std_difference_rsm = (std_difference_rsm * -1)
        print('Standard Deviation difference => ' + item_name + ' = ' + str(std_difference_rsm))
        print("\n")

        # --- Comparing imputation methods ---
        print("-- Comparing imputation methods --")
        print('Standard Deviation difference => ' + item_name + ' (end of distribution method) = ' +
              str(std_difference_edm))
        print('Standard Deviation difference => ' + item_name + ' (median imputation method) = ' +
              str(std_difference_mim))
        print(
            'Standard Deviation difference => ' + item_name + ' (random sampling method) = ' + str(std_difference_rsm))

        min_diff_value = min(std_difference_edm, std_difference_mim, std_difference_rsm)

        # --- Output final data frame ---
        global missing_data_imputed_data_frame, missing_data_imputed_method, target_var_name

        if min_diff_value == std_difference_edm:
            missing_data_imputed_data_frame = edm_df.copy()
            missing_data_imputed_method = "End of Distribution"
            target_var_name = item_name + "_end_distribution"
        elif min_diff_value == std_difference_mim:
            missing_data_imputed_data_frame = mim_df.copy()
            missing_data_imputed_method = "Median Imputation"
            target_var_name = "_median"
        else:
            missing_data_imputed_data_frame = rsm_df.copy()
            missing_data_imputed_method = "Random sampled Method"
            target_var_name = "_random"
        print("\nMissing Value imputed Data Frame: \n")
        print(missing_data_imputed_data_frame)
        print("\nSelected method for missing value imputation -  " + missing_data_imputed_method)
    else:
        print("No missing values found in the data frame")
        missing_data_imputed_data_frame = df.copy()


# ------------------------------ Create multivariate data set with additional features ---------------------------------
def create_multivariate_data_set(missing_data_imputed_df):
    rows = []
    for _, row in tqdm(missing_data_imputed_df.iterrows(), total=missing_data_imputed_df.shape[0]):
        row_data = dict(year=row.date.year, month=row.date.month, day_of_week=row.date.dayofweek,
                        day_of_month=row.date.day, week_of_year=row.date.week)
        rows.append(row_data)
    dates_df = pd.DataFrame(rows)
    upf_df = pd.concat([pd.DataFrame(missing_data_imputed_df[[item_name + target_var_name]]),
                        pd.DataFrame(
                            missing_data_imputed_df[['cpi', 'oil', 'inflation', 'ppi', 'ex_rate', 'sale_tax_rate']]),
                        pd.DataFrame(dates_df[['day_of_week', 'day_of_month', 'week_of_year']])], axis=1)

    # --- Lag features ---
    upf_df['lag1'] = upf_df[item_name + target_var_name].shift(1)
    upf_df['lag2'] = upf_df[item_name + target_var_name].shift(2)
    upf_df['lag3'] = upf_df[item_name + target_var_name].shift(3)

    # --- Moving average features ---
    upf_df['MA3'] = upf_df[item_name + target_var_name].rolling(window=3).mean()
    upf_df['MA4'] = upf_df[item_name + target_var_name].rolling(window=4).mean()
    upf_df['MA5'] = upf_df[item_name + target_var_name].rolling(window=5).mean()

    # --- Rolling window features ---
    upf_df['Max_5'] = upf_df[item_name + target_var_name].rolling(window=5).max()
    upf_df['Min_5'] = upf_df[item_name + target_var_name].rolling(window=5).min()

    #  --- Drop top missing values ---
    upf_df = upf_df.dropna()
    global finalized_multivariate_data_frame
    finalized_multivariate_data_frame = upf_df.copy()
    print("Final multivariate data set created.")


# --------------------------------------- Scale data and train & test data split ---------------------------------------
def create_train_test_data():
    # --- Feature scaling ---
    upf_df_scaled = normalizer.fit_transform(np.array(finalized_multivariate_data_frame))

    #  --- Pre-process data for neural network input ---
    def pre_process_scaled_data(df, window_size):
        df_as_np = df
        X = []
        y = []
        for i in range(len(df_as_np) - window_size):
            row = [r for r in df_as_np[i:i + window_size]]
            X.append(row)
            label = df_as_np[i + window_size][0]
            y.append(label)
        return np.array(X), np.array(y)

    # --- Create X & Y Data ---
    x, y = pre_process_scaled_data(upf_df_scaled, WINDOW_SIZE)

    # --- Extracting train test sizes from data set
    global train_size, test_size
    train_size = round((x.shape[0]) * TRAIN_SIZE)
    test_size = round((x.shape[0]) - train_size)
    print('Training data size = ' + str(train_size))
    print('Test data size = ' + str(test_size))
    print('\n')

    # --- Creating train and test data ---
    global x_train, y_train, x_test, y_test
    x_train, y_train = x[:train_size], y[:train_size]
    x_test, y_test = x[train_size:], y[train_size:]
    print('Train & Test Data shapes')
    print(x_train.shape, y_train.shape, x_test.shape, y_test.shape)


# ------------------------------------------ Stacked LSTM Hyper parameter Tuning ---------------------------------------
def multivariate_lstm_parameter_tuning():
    # --- Send server update ---
    save_server_updates("Model parameter tuning started...", True)

    global forecast_method
    forecast_method = "Multivariate LSTM"

    def define_model(neurons, alpha, dropout_rate):
        model = tf.keras.Sequential()
        model.add(tf.keras.layers.LSTM(neurons, input_shape=(WINDOW_SIZE, FEATURE_COUNT), return_sequences=True))
        model.add(tf.keras.layers.LeakyReLU(alpha=alpha))
        model.add(tf.keras.layers.LSTM(int(neurons/2), return_sequences=True))
        model.add(tf.keras.layers.LeakyReLU(alpha=alpha))
        model.add(tf.keras.layers.Dropout(dropout_rate))
        model.add(tf.keras.layers.LSTM(int(neurons/2), return_sequences=False))
        model.add(tf.keras.layers.Dropout(dropout_rate))
        model.add(tf.keras.layers.Dense(1))
        model.summary()
        model.compile(loss=tf.losses.MeanSquaredError(), optimizer=tf.optimizers.Adam(),
                      metrics=[tf.metrics.MeanAbsoluteError()])
        return model

    lstm_model = KerasRegressor(build_fn=define_model, verbose=1)

    # --- Defining parameter dictionary ---
    alpha = [0.1, 0.3]
    dropout_rate = [0.3, 0.5]
    neurons = [128, 256]
    batch_size = [32, 64]
    epochs = [50, 100]

    # --- Executing grid search ---
    param_grid = dict(alpha=alpha, dropout_rate=dropout_rate, neurons=neurons, batch_size=batch_size, epochs=epochs)
    grid = GridSearchCV(estimator=lstm_model, param_grid=param_grid, n_jobs=-1, cv=3, scoring='neg_mean_absolute_error')

    grid_result = grid.fit(x_train, y_train)
    print(grid_result.best_params_)

    # --- Creating dictionary for model parameter tuning data ---
    global model_parameter_tuning_data
    model_parameter_tuning_data = {
        "item_name": item_name,
        "best_params": grid.best_params_
    }
    # --- Converting parameter data to json objects ---
    json_model_data = json.dumps(model_parameter_tuning_data)
    model_parameter_tuning_data = json.loads(json_model_data)

    # --- Adding model parameter data to database ---
    print("Adding model parameter data to database...")
    model_data_database = mongo_client.get_database("model_data")
    model_data_collection = model_data_database[forecast_method + "_parameter_tuning"]
    model_data_commodity_name = model_parameter_tuning_data["item_name"]

    if model_data_collection.find({"item_name": model_data_commodity_name}).count() > 0:

        # --- Update model data only if new data has higher model score ---
        model_data_collection.update({"item_name": model_data_commodity_name}, model_parameter_tuning_data)
        print("* Document for " + model_data_commodity_name + " has been updated (model tuning data).")
    else:
        model_data_collection.insert_one(model_parameter_tuning_data)
        print("* New document for " + model_data_commodity_name + " has been created (model tuning data).")
    print("Added model parameter data to database.")

    # --- Send server update ---
    save_server_updates("Model parameter tuning completed.", True)


# --------------------------------------------- LSTM model training  ---------------------------------------------------
def multivariate_lstm_model_train():
    # --- Send server update ---
    save_server_updates("Model training started...", True)

    global forecast_method
    forecast_method = "Multivariate LSTM"

    model = tf.keras.Sequential()
    model.add(tf.keras.layers.LSTM(selected_model_params["neurons"], input_shape=(WINDOW_SIZE, FEATURE_COUNT),
                                   return_sequences=True))
    model.add(tf.keras.layers.LeakyReLU(selected_model_params["alpha"]))
    model.add(tf.keras.layers.LSTM(int((selected_model_params["neurons"]/2)), return_sequences=True))
    model.add(tf.keras.layers.LeakyReLU(selected_model_params["alpha"]))
    model.add(tf.keras.layers.Dropout(selected_model_params["dropout_rate"]))
    model.add(tf.keras.layers.LSTM(int((selected_model_params["neurons"]/2)), return_sequences=False))
    model.add(tf.keras.layers.Dropout(selected_model_params["dropout_rate"]))
    model.add(tf.keras.layers.Dense(1))
    model.summary()

    model.compile(loss=tf.losses.MeanSquaredError(), optimizer=tf.optimizers.Adam(),
                  metrics=[tf.metrics.MeanAbsoluteError()])
    model.fit(x_train, y_train, epochs=selected_model_params["epochs"], validation_data=(x_test, y_test),
              batch_size=selected_model_params["batch_size"], shuffle=False, callbacks=[tensor_board], verbose=2)

    # --- Model test & save model train data ---
    model_test(model)


# ----------------------------------------- Model test & save train data -----------------------------------------------
def model_test(model):
    # --- Saving trained model ---
    save_model_location_string = "Trained_Models/" + item_name + ".h5"
    model.save(save_model_location_string)

    # --- Predict for test data ---
    test_predictions = model.predict(x_test)

    # --- Inverse transforming prediction results ---
    prediction_copies = np.repeat(test_predictions, FEATURE_COUNT, axis=-1)
    inv_prediction = normalizer.inverse_transform(prediction_copies)[:, 0]

    # --- Inverse transforming actual test data ---
    reshaped_y_test = y_test.reshape(-1, 1)
    actual_copies = np.repeat(reshaped_y_test, FEATURE_COUNT, axis=-1)
    inv_actual = normalizer.inverse_transform(actual_copies)[:, 0]
    test_results = pd.DataFrame(data={'Test_prediction': inv_prediction, 'Actual': inv_actual})

    # --- Calculating root mean squared error of test predictions ---
    mse_error = sqrt(mean_squared_error(test_results['Test_prediction'], test_results['Actual']))
    mae_error = mean_absolute_error(test_results['Test_prediction'], test_results['Actual'])
    print('Test results => Error (root mean squared error) = ' + str(mse_error))
    print('Test results => Error (mean absolute error) = ' + str(mae_error))

    # --- Creating dictionary to model train stats ---
    global model_train_data, train_size, test_size
    model_train_data = {
        'forecast_method': forecast_method,
        'data_prep': {
            'feature_count': FEATURE_COUNT,
            'window_size': WINDOW_SIZE,
            'train_size': train_size,
            'test_size': test_size
        },
        'model_train_params': selected_model_params,
        'model_train_data': {
            "root_mean_squared_error": mse_error,
            "mean_absolute_error": mae_error
        }
    }
    # --- Converting train data to json objects ---
    json_model_train_data = json.dumps(model_train_data)
    model_train_data = json.loads(json_model_train_data)

    # --- Send server update ---
    save_server_updates("Model training completed.", True)


# ------------------------------------ Executing model training operation ----------------------------------------------
def exec_model_train():
    global train_pending
    train_pending = True

    # --- Extracting model data from database ---
    model_data_database = mongo_client.get_database("model_data")
    model_data_collection = model_data_database["Multivariate LSTM_parameter_tuning"]

    if model_data_collection.find({"item_name": item_name}).count() > 0:
        existing_document = model_data_collection.find_one({"item_name": item_name})
        global selected_model_params
        selected_model_params = existing_document["best_params"]
        print("Best model params have been extracted from database.")
        print("Executing model training...")

        # --- Executing LSTM model training for selected commodity ---
        multivariate_lstm_model_train()
    else:
        # --- Send server update ---
        save_server_updates("No model parameter tuned data for " + item_name +
                            " found. Running model parameter tuning...", True)

        # --- Executing model parameter tuning for selected commodity ---
        multivariate_lstm_parameter_tuning()


# ------------------------------------ Executing price forecast operation ----------------------------------------------
def price_forecast():
    # --- Send server update ---
    save_server_updates("Price forecast started...", True)
    load_model_location_string = "Trained_Models/" + item_name + ".h5"
    try:
        loaded_model = keras.models.load_model(load_model_location_string)
        loaded_model.summary()

        x_input = x_test[363:]

        lst_output = []
        n_steps = 90
        i = 0
        while (i < 90):

            if (len(temp_input) > 90):
                # print(temp_input)
                x_input = np.array(temp_input[1:])
                print("{} day input {}".format(i, x_input))
                x_input = x_input.reshape(1, -1)
                x_input = x_input.reshape((1, n_steps, 18))
                # print(x_input)
                yhat = loaded_model.predict(x_input, verbose=0)
                print("{} day output {}".format(i, yhat))
                temp_input.extend(yhat[0].tolist())
                temp_input = temp_input[1:]
                # print(temp_input)
                lst_output.extend(yhat.tolist())
                i = i + 1
            else:
                x_input = x_input.reshape((1, n_steps, 1))
                yhat = loaded_model.predict(x_input, verbose=0)
                print(yhat[0])
                temp_input.extend(yhat[0].tolist())
                print(len(temp_input))
                lst_output.extend(yhat.tolist())
                i = i + 1
        # # import datetime
        # date_time_str = '2021-12-05 08:15:27.243860'
        # date = datetime.datetime.strptime(date_time_str, '%Y-%m-%d %H:%M:%S.%f')
        # date = date.date()
        #
        # print(date + datetime.timedelta(days=1))
        #
        # item = []
        # i = 0
        # while len(item) != 90:
        #     # if item_name == "carrot":
        #     #     item.append(carrot[i])
        #     # if item == "beans":
        #     #     item.append(beans[i])
        #     # if(item == "lime"):
        #     item.append(lime[i])
        #
        #     i = i + 1
        #     if (i == 19):
        #         i = 0
        #
        # for i in range(90):
        #     date = date + datetime.timedelta(days=1)
        #     forecast_data.append({"date": str(date), "Price": (item[i])})
        # print(forecast_data)
        #
        #
        # # date_now = datetime.datetime.now().date()
        # # print(date_now)
        # # for i in range(90):
        # #     date = date_now + datetime.timedelta(days=i)
        # #     forecast_data.append({"date": str(date), "Price": (i * 3)})

        # --- Send server update ---
        save_server_updates("Price forecast completed.", True)
    except OSError:
        print()
        # --- Send server update ---
        save_server_updates("No trained model for " + item_name + " found. Running model training...", True)
        global forecast_pending
        forecast_pending = True
        exec_model_train()


# ------------------------------------------ Execution of main operation -----------------------------------------------
# --- Setup flask server ---
app = Flask(__name__)


#  --- Setting route for flask server ---
@app.route('/executeTrainForecast', methods=['POST'])
def execute_main_operation():
    try:
        # --- Update data files in local directory ---
        update_files_directory()

        # --- Clear global variables ---
        refresh_all_global_variables()

        # --- Getting user request data ---
        request_data = request.get_json()
        commodity_list = request_data["commodityList"]
        print(commodity_list)

        for i in range(len(commodity_list)):
            global item_name, data_frame
            item_name = str(commodity_list[i])
            print("\n********************************* Start of " + item_name + " **********************************\n")
            save_server_updates("---------- Start of " + item_name + " ----------", True)

            # --- Initialising tensor board logs directory ---
            tensor_log_directory = 'logs/' + item_name.capitalize() + "_Model"
            try:
                shutil.rmtree(tensor_log_directory)
            except FileNotFoundError:
                print()
            finally:
                global tensor_board
                tensor_board = TensorBoard(log_dir='logs/' + item_name.capitalize() + "_Model")

            # --- Start timer for entire process (commodity) ---
            complete_start_time = time.time()

            # --- Read data from file ---
            save_server_updates("Reading data file for " + item_name, True)
            try:
                data_frame = pd.read_excel("Saved_Data_Files/" + item_name + '.xlsx', parse_dates=['date'])
                print("Original Input Data Frame:\n")
                print(data_frame)
            except FileNotFoundError:
                print()
                return json.dumps({"message": "Data file not found for " + item_name +
                                              ". Add required file & try again."})
            save_server_updates("Finished file read for " + item_name + ". Searching for missing values...", True)

            # --- Imputing missing values ---
            calc_missing_values(data_frame, item_name)
            save_server_updates("Missing values imputation completed. Started creating multivariate data set...", True)

            # --- Create multivariate data set ---
            create_multivariate_data_set(missing_data_imputed_data_frame)
            save_server_updates("Multivariate data set has been created. Started creating train test data...", True)

            # --- Create train test split data (pre-process data) ---
            create_train_test_data()
            save_server_updates("Train test data has been created.", True)

            # --- Model hyper parameter tuning ---
            if request_data["parameterTuning"]:
                multivariate_lstm_parameter_tuning()

            # --- Model training ---
            if request_data["modelTrain"]:
                exec_model_train()

            # --- Produce price forecast ---
            if request_data["priceForecast"]:
                price_forecast()
                if (request_data["modelTrain"] is False) & (train_pending is False):
                    retrieve_previous_model_train_data()

            # --- Initial model training ---
            if train_pending:
                exec_model_train()

            # --- Initial forecast ---
            if forecast_pending:
                price_forecast()

            # --- End timer for entire process (commodity) ---
            complete_end_time = time.time()
            time.sleep(1)
            complete_forecast_time = complete_end_time - complete_start_time

            # --- Creating dictionary to structure forecast & other data ---
            global commodity_data
            commodity_data = {
                "_id": "id_" + item_name,
                "item_name": item_name,
                "item_type": "fruit",
                "missing_value_imputation": {
                    'values_missing': values_missing_boolean,
                    'values_missing_count': int(values_missing_row_count),
                    'values_missing_percentage': float(values_missing_percentage),
                    'missing_value_imputed_method': missing_data_imputed_method
                },
                "model_train_data": model_train_data,
                "forecast_data": forecast_data,
                "forecast_time_taken(s)": complete_forecast_time,
                "last_forecast": str(datetime.datetime.now())
            }
            # --- Converting commodity data to json objects ---
            json_commodity_data = json.dumps(commodity_data)
            dict_commodity_data = json.loads(json_commodity_data)
            commodities_data_list.append(dict_commodity_data)

            save_server_updates("---------- End of " + item_name + " ----------", True)
            print("\n******************************** End of " + item_name + " *************************************\n")

            # --- Converting Commodities Data List to json objects ---
            json_commodities_data_list = json.dumps(commodities_data_list)
            dict_commodities_data_list = json.loads(json_commodities_data_list)
            print(dict_commodities_data_list)

            # --- Storing forecast data in Database ---
            save_server_updates("Storing forecast data to database...", True)
            print("Adding model train / forecast data to database...")
            forecast_data_database = mongo_client.get_database("commodity_data")
            forecast_data_collection = forecast_data_database["forecast_data"]

            for commodity_data in dict_commodities_data_list:
                commodity_id = commodity_data["_id"]
                commodity_name = commodity_data["item_name"]
                if forecast_data_collection.find({"_id": commodity_id}).count() > 0:
                    forecast_data_collection.update({"_id": commodity_id}, commodity_data)
                    print("* Existing document for " + commodity_name + " has been updated (model train data).")
                else:
                    forecast_data_collection.insert_one(commodity_data)
                    print("* New document for " + commodity_name + " has been created (model train data).")
            print("Added model train / forecast data to database.")
            save_server_updates("Forecast data saved in database.", False)

            # --- Refresh global array variables ---
            refresh_global_array_variables()
        return json.dumps({"message": "Price forecast completed for selected commodities."})
    except OSError:
        print()
        return json.dumps({"message": "Unknown error occurred! Please try again."})


# ----------------------------------------------------- Save server updates --------------------------------------------
def save_server_updates(update_string, is_updating):
    messages = []
    date = datetime.datetime.now()
    forecast_data_database = mongo_client.get_database("commodity_data")
    server_updates_collection = forecast_data_database["server_updates"]

    global is_first_server_response
    if is_first_server_response:
        if server_updates_collection.find({"_id": "message_id"}).count() > 0:
            server_updates_collection.remove({"_id": "message_id"}, {"_id": "message_id"})
            is_first_server_response = False

    if server_updates_collection.find({"_id": "message_id"}).count() > 0:
        messages = server_updates_collection.find_one()["messages"]
    messages.append(update_string)

    server_update_dict = {"_id": "message_id", "messages": messages, "updating": is_updating, "last_update": date}

    if server_updates_collection.find({"_id": "message_id"}).count() > 0:
        server_updates_collection.update({"_id": "message_id"}, server_update_dict)
        print("server updates saved.")
    else:
        server_updates_collection.insert_one(server_update_dict)
        print("server updates saved.")
    time.sleep(1)


# ------------------------------------------------------- Refresh server -----------------------------------------------
@app.route('/refreshServer', methods=['POST'])
def refresh_server():

    return json.dumps({"message": "Server refreshed!"})


# ----------------------------------------------------- Uploading data files -------------------------------------------
@app.route('/uploadFiles', methods=['POST'])
def upload_files():
    files = request.files.getlist("files")
    for file in files:
        file_name = file.filename
        print(file_name)
        try:
            input_data_frame = pd.read_excel(file)
            input_data_frame.to_excel("Saved_Data_Files/" + file_name)
        except OSError:
            print()
            return json.dumps({"message": ("Error occurred when uploading file ", file_name)})

    # --- Update data files in directory ---
    update_files_directory()
    return json.dumps({"message": "Uploaded files successfully."})


# ----------------------------------------- Retrieve precious model train data -----------------------------------------
def retrieve_previous_model_train_data():
    forecast_data_database = mongo_client.get_database("commodity_data")
    forecast_data_collection = forecast_data_database["forecast_data"]

    if forecast_data_collection.find({"_id": ("id_" + item_name)}).count() > 0:
        previous_model_trained_data = (forecast_data_collection.find_one(
            {"_id": ("id_" + item_name)}))["model_train_data"]
        print(previous_model_trained_data)
        global model_train_data
        model_train_data = previous_model_trained_data
        print("previous model trained data retrieved.")


# ------------------------------------------ Update data files in local directory --------------------------------------
def update_files_directory():
    currently_saved_files = os.listdir("Saved_Data_Files/")
    currently_saved_files_dict = {"_id": "upload_id", "files": currently_saved_files}
    forecast_data_database = mongo_client.get_database("commodity_data")
    saved_data_files_collection = forecast_data_database["saved_data_files"]

    if saved_data_files_collection.find({"_id": "upload_id"}).count() > 0:
        saved_data_files_collection.update({"_id": "upload_id"}, currently_saved_files_dict)
        print("data files information saved.")
    else:
        saved_data_files_collection.insert_one(currently_saved_files_dict)
        print("data files information saved.")


# ---------------------------------------------- Refresh all global variables ------------------------------------------
def refresh_all_global_variables():
    global is_first_server_response, values_missing_boolean
    is_first_server_response = True
    values_missing_boolean = False

    global x_train, y_train, x_test, y_test
    x_train, y_train, x_test, y_test = [], [], [], []

    global commodities_data_list, forecast_data
    commodities_data_list = []
    forecast_data = []

    global train_pending, forecast_pending
    train_pending, forecast_pending = False, False


# -------------------------------------------- Refresh global array variables only -------------------------------------
def refresh_global_array_variables():
    global x_train, y_train, x_test, y_test
    x_train, y_train, x_test, y_test = [], [], [], []

    global commodities_data_list, forecast_data
    commodities_data_list = []
    forecast_data = []


# ----------------------------------------------------- Start server ---------------------------------------------------
if __name__ == "__main__":
    app.run(port=5000)

flask_cors.CORS(app, expose_headers='Authorization')


# --------------------------------------------------- Code references --------------------------------------------------

# grid search - https://www.analyticsvidhya.com/blog/2021/06/tune-hyperparameters-with-gridsearchcv/

# https://stackoverflow.com/questions/34489706/create-json-object-with-variables-from-an-array/34489746

# https://www.mygreatlearning.com/blog/gridsearchcv/

# Connect flask python with node - https://www.geeksforgeeks.org/how-to-communicate-json-data-between-python-and-node-js/

# Multiple api requests at once  - https://www.pluralsight.com/guides/using-multiple-fetch-statements-with-componentwillmount-in-react

# Adding loop to display components - https://stackoverflow.com/questions/22876978/loop-inside-react-jsx

# Continuous fetch api - https://stackoverflow.com/questions/59015638/how-to-fetch-repeatedly-and-render-updated-api-data-in-reactjs

# socket io continuous fetch - https://www.youtube.com/watch?v=NU-HfZY3ATQ

# Upload file from react - https://surajsharma.net/blog/react-upload-file-using-axios

# upload multiple files https://nelsoncode.medium.com/how-to-upload-multiple-images-with-flask-ca3afd96a466
