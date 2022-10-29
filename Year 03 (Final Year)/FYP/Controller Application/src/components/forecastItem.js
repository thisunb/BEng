import React from 'react';
import '../css/forecastItem.css';

class ForecastItem extends React.Component {

    constructor(props){
        super(props);
    }

    render() {
        return (
            <div style={this.props.styles} id={this.props.id} onClick={this.props.clickEvent} className='forecast-item'>{this.props.item_name}</div>
        );
    }
}

export default ForecastItem;