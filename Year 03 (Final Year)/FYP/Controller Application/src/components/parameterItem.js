import React from 'react';
import '../css/item.css';

class ParameterItem extends React.Component {

    constructor(props){
        super(props);
    }

    render() {
        return (
            <div className="item-container">
                <div className="item-name">{this.props.item_name} </div>
                <div className="item-parameter-description">
                    {/* Best score : <span className='value-span'>{this.props.best_score} </span> <br/> */}
                    Best parameters :  <br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        I. Alpha : <span className='value-span'>{this.props.alpha}</span> <br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        II. Batch size : <span className='value-span'>{this.props.batch_size}</span> <br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        III. Dropout Rate : <span className='value-span'>{this.props.dropout_rate} </span><br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        IV. Epochs : <span className='value-span'>{this.props.epochs} </span> <br/> &nbsp;&nbsp;&nbsp;&nbsp;
                        V. Neurons : <span className='value-span'>{this.props.neurons}</span> <br/>
                    {/* Time taken (s) : <span className='value-span'>{this.props.time_taken}</span> <br/> */}
                    {/* Last model tuned : <span className='value-span'>{new Date(this.props.last_updated).toDateString()}</span> */}
                </div>
            </div>
        );
    }
}

export default ParameterItem;