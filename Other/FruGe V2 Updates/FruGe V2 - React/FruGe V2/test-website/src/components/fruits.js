import React from 'react'
import '../css/fruits.css'
import Item from './item';

class fruits extends React.Component {

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
                <div className="fruits-heading-text"> Fruits</div>

                {
                    priceData ?
                        <div className="fruits-description"> Predicted prices for {appendDateText} ({priceData[0][dateText]})</div>
                    : <p/>
                }

                <div className="date-button-container">
                    <div className="date-buttton-wrapper"><button className={clickedStyle1} onClick={() => this.handleDateInput('today', 'date')}> Today </button> </div>
                    <div className="date-buttton-wrapper"><button className={clickedStyle2} onClick={() => this.handleDateInput('tomorrow', 'tomorrowDate')}> Tomorrow </button></div>
                    <div className="date-buttton-wrapper"><button className={clickedStyle3} onClick={() => this.handleDateInput('nextWeek', 'nextWeekDate')}> Next Week </button></div>
                </div>

                {
                    priceData ?

                        <div className="item-list">
                            <div className="item"><Item itemName="Banana" itemPrice={"Rs. " + priceData[15][selectedDate]} imageUrl={"./items/banana.jpg"} /></div>
                            <div className="item"><Item itemName="Lime" itemPrice={"Rs. " + priceData[13][selectedDate]} imageUrl={"./items/lime.jpg"} /></div>
                            <div className="item"><Item itemName="Papaya" itemPrice={"Rs. " + priceData[16][selectedDate]} imageUrl={"./items/papaya.png"} /></div>
                            <div className="item"><Item itemName="Pineapple" itemPrice={"Rs. " + priceData[17][selectedDate]} imageUrl={"./items/pineapple.jpg"} /></div>
                            <div className="item"><Item itemName="Mango" itemPrice={"Rs. " + priceData[18][selectedDate]} imageUrl={"./items/mango.jpg"} /></div>
                            <div className="item"><Item itemName="Avocado" itemPrice={"Rs. " + priceData[19][selectedDate]} imageUrl={"./items/avocado.jpg"} /></div>
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

export default fruits;