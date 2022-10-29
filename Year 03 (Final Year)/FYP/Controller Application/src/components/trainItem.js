import React from 'react';
import '../css/item.css';

class TrainItem extends React.Component {

    constructor(props){
        super(props);
    }

    render() {
        return (
            <div className="item-container">
                <div className="item-name">{this.props.item_name} </div>
                <div className="item-train-description">
                    Missing value imputation : <br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        I. Missing count : <span className='value-span'>{this.props.values_missing_count}</span> <br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        II. Missing percentage : <span className='value-span'>{this.props.values_missing_percentage}</span> <br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        III. Imputed method : <span className='value-span'>{this.props.missing_value_imputed_method}</span> <br/>
                    Data preparation : <br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        I. Feature count : <span className='value-span'>{this.props.feature_count}</span> <br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        II. Window size : <span className='value-span'>{this.props.window_size} </span><br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        III. Train size : <span className='value-span'>{this.props.train_size} </span><br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        IV. Test size : <span className='value-span'>{this.props.test_size}</span> <br/>
                    Model train / forecast :<br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        I. Forecast method : <span className='value-span'>{this.props.forecast_method} </span><br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        II. Error (MSE): <span className='value-span'>{this.props.root_mean_squared_error}</span> <br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        II. Error (MAE): <span className='value-span'>{this.props.mean_absolute_error}</span> <br/>
                        {/* III. Last model trained : <span className='value-span'>{this.props.last_model_trained=="N/A"?"N/A":new Date(this.props.last_model_trained).toDateString()}</span> */}
                </div>
            </div>
        );
    }
}

export default TrainItem;