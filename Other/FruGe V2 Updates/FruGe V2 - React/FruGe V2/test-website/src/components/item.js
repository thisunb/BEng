import React from 'react';
import '../css/item.css';

class Item extends React.Component {

    constructor(props){
        super(props);
    }

    state = {
        imageUrl:"",
        itemName:"",
        itemPrice:""
    }

    render() {
        return (
            <div className="item-container">
                <img src={this.props.imageUrl} className="item-image"/>
                <div className="item-name"> {this.props.itemName} </div>
                <div className="item-price"> {this.props.itemPrice} </div>
            </div>
        );
    }
}

export default Item;