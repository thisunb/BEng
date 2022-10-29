import React from 'react'
import '../css/vegetables.css'
import Item from './item';

class vegetables extends React.Component {

    state = {
        priceData: false,
        selectedDate: "today",
        dateText: "date",
        appendDateText: "Today",

        clickedStyle1: "date-button-inner-clicked",
        clickedStyle2: "date-button-inner",
        clickedStyle3: "date-button-inner",
    }

    render() {

        const priceData = this.state.priceData
        console.log(priceData)

        const selectedDate = this.state.selectedDate
        const dateText = this.state.dateText
        const appendDateText = this.state.appendDateText

        const clickedStyle1 = this.state.clickedStyle1
        const clickedStyle2 = this.state.clickedStyle2
        const clickedStyle3 = this.state.clickedStyle3

        return (
            <div>
                <div className="vegetables-heading-text"> Vegetables</div>

                {
                    priceData ?
                        <div className="vegetables-description"> Predicted prices for {appendDateText} ({priceData[0][dateText]})</div>

                        : <p />
                }

                <div className="date-button-container">
                    <div className="date-buttton-wrapper"><button className={clickedStyle1} onClick={() => this.handleDateInput('today', 'date')}> Today </button> </div>
                    <div className="date-buttton-wrapper"><button className={clickedStyle2} onClick={() => this.handleDateInput('tomorrow', 'tomorrowDate')}> Tomorrow </button></div>
                    <div className="date-buttton-wrapper"><button className={clickedStyle3} onClick={() => this.handleDateInput('nextWeek', 'nextWeekDate')}> Next Week </button></div>
                </div>

                {
                    priceData ?

                        <div className="item-list">
                            <div className="item"><Item itemName="Beans" itemPrice={"Rs. " + priceData[0][selectedDate]} imageUrl={"./items/beans.png"} /></div>
                            <div className="item"><Item itemName="Carrot" itemPrice={"Rs. " + priceData[1][selectedDate]} imageUrl={"./items/carrot.png"} /></div>
                            <div className="item"><Item itemName="Leeks" itemPrice={"Rs. " + priceData[2][selectedDate]} imageUrl={"./items/leeks.png"} /></div>
                            <div className="item"><Item itemName="Knolkhol" itemPrice={"Rs. " + priceData[4][selectedDate]} imageUrl={"./items/knolkhol.jpg"} /></div>
                            <div className="item"><Item itemName="Cabbage" itemPrice={"Rs. " + priceData[5][selectedDate]} imageUrl={"./items/cabbage.png"} /></div>
                            <div className="item"><Item itemName="Tomato" itemPrice={"Rs. " + priceData[6][selectedDate]} imageUrl={"./items/tomato.png"} /></div>
                            <div className="item"><Item itemName="Ladies Fingers" itemPrice={"Rs. " + priceData[7][selectedDate]} imageUrl={"./items/ladiesfingers.png"} /></div>
                            <div className="item"><Item itemName="Brinjals" itemPrice={"Rs. " + priceData[8][selectedDate]} imageUrl={"./items/brinjals.png"} /></div>
                            <div className="item"><Item itemName="Pumpkin" itemPrice={"Rs. " + priceData[9][selectedDate]} imageUrl={"./items/pumpkin.png"} /></div>
                            <div className="item"><Item itemName="Cucumber" itemPrice={"Rs. " + priceData[10][selectedDate]} imageUrl={"./items/cucumber.png"} /></div>
                            <div className="item"><Item itemName="Bitter Gourd" itemPrice={"Rs. " + priceData[11][selectedDate]} imageUrl={"./items/bittergourd.png"} /></div>
                            <div className="item"><Item itemName="Green Chiilies" itemPrice={"Rs. " + priceData[12][selectedDate]} imageUrl={"./items/greenchilies.jpg"} /></div>
                            <div className="item"><Item itemName="Beet Root" itemPrice={"Rs. " + priceData[3][selectedDate]} imageUrl={"./items/beetroot.png"} /></div>
                            <div className="item"><Item itemName="Potato" itemPrice={"Rs. " + priceData[14][selectedDate]} imageUrl={"./items/potato.png"} /></div>
                        </div>

                        : <p className="loadingText"> Loading... </p>
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

    handleDateInput(date, dateText) {

        if (dateText == "date") {
            this.appendDateText = "Today"
            this.clickedStyle1 = "date-button-inner-clicked"
            this.clickedStyle2 = "date-button-inner"
            this.clickedStyle3 = "date-button-inner"

        }
        else if (dateText == "tomorrowDate") {
            this.appendDateText = "Tomorrow"
            this.clickedStyle2 = "date-button-inner-clicked"
            this.clickedStyle1 = "date-button-inner"
            this.clickedStyle3 = "date-button-inner"
        }
        else {
            this.appendDateText = "Next Week"
            this.clickedStyle3 = "date-button-inner-clicked"
            this.clickedStyle1 = "date-button-inner"
            this.clickedStyle2 = "date-button-inner"
        }

        this.setState({
            selectedDate: date,
            dateText: dateText,
            appendDateText: this.appendDateText,

            clickedStyle1: this.clickedStyle1,
            clickedStyle2: this.clickedStyle2,
            clickedStyle3: this.clickedStyle3,
        })
    }
}

export default vegetables;