import React from 'react';
import '../css/dashboard.css';
import Item from './item';

class dashboard extends React.Component {

    state = {
        priceData: false,
        dateText: "date"
    }

    render() {

        const priceData = this.state.priceData
        const dateText = this.state.dateText

        console.log(priceData)

        return (
            <div>
                <div className="dashboard-heading-text"> Dashboard</div>

                {
                    priceData ?
                        <div className="dashboard-description"> Predicted prices for Today ({priceData[0][dateText]})</div>
                        : <p />
                }

                {
                    priceData ?
                        <div className="item-list">
                            <div className="item"><Item itemName="Beans" itemPrice={"Rs. " + priceData[0].today} imageUrl={"./items/beans.png"} /></div>
                            <div className="item"><Item itemName="Carrot" itemPrice={"Rs. " + priceData[1].today} imageUrl={"./items/carrot.png"} /></div>
                            <div className="item"><Item itemName="Leeks" itemPrice={"Rs. " + priceData[2].today} imageUrl={"./items/leeks.png"} /></div>
                            <div className="item"><Item itemName="Banana" itemPrice={"Rs. " + priceData[15].today} imageUrl={"./items/banana.jpg"} /></div>
                            <div className="item"><Item itemName="Knolkhol" itemPrice={"Rs. " + priceData[4].today} imageUrl={"./items/knolkhol.jpg"} /></div>
                            <div className="item"><Item itemName="Cabbage" itemPrice={"Rs. " + priceData[5].today} imageUrl={"./items/cabbage.png"} /></div>
                            <div className="item"><Item itemName="Tomato" itemPrice={"Rs. " + priceData[6].today} imageUrl={"./items/tomato.png"} /></div>
                            <div className="item"><Item itemName="Ladies Fingers" itemPrice={"Rs. " + priceData[7].today} imageUrl={"./items/ladiesfingers.png"} /></div>
                            <div className="item"><Item itemName="Brinjals" itemPrice={"Rs. " + priceData[8].today} imageUrl={"./items/brinjals.png"} /></div>
                            <div className="item"><Item itemName="Pumpkin" itemPrice={"Rs. " + priceData[9].today} imageUrl={"./items/pumpkin.png"} /></div>
                            <div className="item"><Item itemName="Cucumber" itemPrice={"Rs. " + priceData[10].today} imageUrl={"./items/cucumber.png"} /></div>
                            <div className="item"><Item itemName="Bitter Gourd" itemPrice={"Rs. " + priceData[11].today} imageUrl={"./items/bittergourd.png"} /></div>
                            <div className="item"><Item itemName="Green Chiilies" itemPrice={"Rs. " + priceData[12].today} imageUrl={"./items/greenchilies.jpg"} /></div>
                            <div className="item"><Item itemName="Beet Root" itemPrice={"Rs. " + priceData[3].today} imageUrl={"./items/beetroot.png"} /></div>
                            <div className="item"><Item itemName="Potato" itemPrice={"Rs. " + priceData[14].today} imageUrl={"./items/potato.png"} /></div>
                            <div className="item"><Item itemName="Lime" itemPrice={"Rs. " + priceData[13].today} imageUrl={"./items/lime.jpg"} /></div>
                            <div className="item"><Item itemName="Papaya" itemPrice={"Rs. " + priceData[16].today} imageUrl={"./items/papaya.png"} /></div>
                            <div className="item"><Item itemName="Pineapple" itemPrice={"Rs. " + priceData[17].today} imageUrl={"./items/pineapple.jpg"} /></div>
                            <div className="item"><Item itemName="Mango" itemPrice={"Rs. " + priceData[18].today} imageUrl={"./items/mango.jpg"} /></div>
                            <div className="item"><Item itemName="Avocado" itemPrice={"Rs. " + priceData[19].today} imageUrl={"./items/avocado.jpg"} /></div>
                        </div>
                        : <p className="loadingText"> Loading...</p>
                }
            </div>
        );
    }

    componentDidMount() {

        var publicURL = "https://1upfqc4cxh.execute-api.ap-south-1.amazonaws.com/dev/priceData"
        var privateURL = "http://localhost:3001/priceData"

        fetch(publicURL, {

            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        }).then((result) => {

            result.json().then((resp) => {

                this.setState({ priceData: resp })
            })
        })
    }
}

export default dashboard;