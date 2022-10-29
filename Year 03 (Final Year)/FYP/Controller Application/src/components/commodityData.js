import React from 'react';
import ParameterItem from './parameterItem.js'
import TrainItem from './trainItem.js'
import '../css/commodityData.css'
import loadingIcon from '../images/loading-icon.gif';

class CommodityData extends React.Component {

    state = {
        parameterData: false,
        trainData: false,
        loading: true
    }

    render(){
        const parameterData = this.state.parameterData
        const trainData = this.state.trainData
        var rows = [];
        var rows2 = [];
        for (var i = 0; i < parameterData.length; i++) {
            rows.push(<ParameterItem     
                item_name={(parameterData[i].item_name).charAt(0).toUpperCase() + parameterData[i].item_name.slice(1)}
                // best_score = {(parameterData[i].best_score * 100).toFixed(2) + " %"}
                alpha = {parameterData[i].best_params.alpha}
                batch_size = {parameterData[i].best_params.batch_size}
                dropout_rate = {parameterData[i].best_params.dropout_rate}
                epochs = {parameterData[i].best_params.epochs}
                neurons = {parameterData[i].best_params.neurons}
                // time_taken = {(parameterData[i]["time_taken(s)"]).toFixed(2)}
                // last_updated = {parameterData[i].last_updated}
                key={i}
            />);
        }

        for (var i = 0; i < trainData.length; i++) {
            rows2.push(<TrainItem  
                item_name={(trainData[i].item_name).charAt(0).toUpperCase() + trainData[i].item_name.slice(1)}
                values_missing_count = {trainData[i].missing_value_imputation.values_missing_count}
                values_missing_percentage = {trainData[i].missing_value_imputation.values_missing_percentage + " %"}
                missing_value_imputed_method = {trainData[i].missing_value_imputation.missing_value_imputed_method}
                feature_count = {trainData[i].model_train_data === undefined ? "N/A" : trainData[i].model_train_data.data_prep.feature_count}
                window_size = {trainData[i].model_train_data === undefined ? "N/A" : trainData[i].model_train_data.data_prep.window_size}
                train_size = {trainData[i].model_train_data === undefined ? "N/A" : trainData[i].model_train_data.data_prep.train_size}
                test_size = {trainData[i].model_train_data === undefined ? "N/A" : trainData[i].model_train_data.data_prep.test_size}
                forecast_method = {trainData[i].model_train_data === undefined ? "N/A" : trainData[i].model_train_data.forecast_method }
                root_mean_squared_error = {trainData[i].model_train_data === undefined ? "N/A" : (trainData[i].model_train_data.model_train_data.root_mean_squared_error).toFixed(2)}
                mean_absolute_error = {trainData[i].model_train_data === undefined ? "N/A" : (trainData[i].model_train_data.model_train_data.mean_absolute_error).toFixed(2)}
                // last_model_trained = {trainData[i].model_train_data === undefined ? "N/A" : trainData[i].model_train_data.last_model_trained}
                key={i}
            />);
        }

        return(
            <div>
                {
                    this.state.loading ?
                        <div className="no-display-text"><img src={loadingIcon} width={100} height={100} alt="Loading icon" /></div>
                    :parameterData && trainData ?
                        <div className='commodity_container'> 
                            <div className='top-image'></div>   
                            <div className='item-description-heading-container'><h3 className='item-description-heading'>Model Hyper Parameter Data</h3></div>                                                              
                            <tbody style={{display:"flex", flexWrap:"wrap", justifyContent:"center"}}>{rows}</tbody>
                            <div className='item-description-heading-container'><h3 className='item-description-heading'>Model Train Data</h3></div>
                            <tbody style={{display:"flex", flexWrap:"wrap", justifyContent:"center"}}>{rows2}</tbody>
                        </div>
                    :<div className='no-display-text'> No commodity data to display!</div>
                }
            </div>
        )
    }

    componentDidMount() {
        var publicURL = ""
        var privateURL = "http://localhost:4000/dataModel/parameterData"
        var privateURL2 = "http://localhost:4000/dataModel/modelTrainData"

        Promise.all([
            fetch(privateURL).then(res => res.json()),
            fetch(privateURL2).then(res => res.json())
        ]).then(([resp1, resp2]) => {
            this.setState({
                parameterData: resp1,
                trainData: resp2,
                loading: false
            })
        }).catch((err) => {
            console.log(err)
            if(this.state.parameterData == false){
                this.setState({
                    loading: false
                })
            }
        })
    }
}

export default CommodityData;