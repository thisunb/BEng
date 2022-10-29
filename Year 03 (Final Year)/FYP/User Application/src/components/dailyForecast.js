import React from 'react';
import '../css/commodityPages.css';
import Chart from './chart';
import loadingIcon from '../images/loading-icon.gif';
import Alert from '../components/alert.js';

class DailyForecast extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            priceData: [],
            dataRetrieved: false,
            loadingForecasts: false,
            alertText: ""
        }
        this.handleInputChange = this.handleInputChange.bind(this);
    }
    
    render() {
        var rows = []
        const priceData = this.state.priceData
        for(var i = 0; i < priceData.length; i++){
            rows.push(<Chart item_name={priceData[i]["item_name"].replace(/_/g, ' ')} data={priceData[i]["forecast_data"]}/>)
        }

        return (
            <div>
                <Alert alertText={this.state.alertText}/>
                <div id="page">
                    <div className='dashboard-body-wrapper'>
                        <div className='dashboard-body'>
                            <div className="dashboard-heading-text"> 
                                Daily Forecast
                            </div>
                            <div className="searchArea">
                                <input type="text" required value={this.state.searchText} onChange={this.handleInputChange} name="searchText" className="searchText" placeholder="Search" />
                                <button onClick={this.search} className="search-btn"> Search </button>
                            </div>
                            {
                                this.state.loadingForecasts ?
                                    <div className='dashboard-loading-icon'><img src={loadingIcon} style={{marginBottom:"50px"}} width={50} height={50} alt="Loading icon" /></div>
                                
                                :this.state.dataRetrieved ?
                                    <div>
                                        <div className="dashboard-sub-heading-text" style={{textAlign: "left", paddingLeft: "20px"}}> Daily Forecast - Next 90 days starting from {priceData[0]["forecast_data"][0]["date"]} </div>
                                        <tbody className='charts-container'>{rows}</tbody>
                                    </div>
                                :<div className='no-added-message'>Price forecasts are not available!</div>
                            }
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    componentDidMount() {
        let isLogged = localStorage.getItem("isLogged")

        if(isLogged == "true"){

            this.setState({
                loadingForecasts: true
            })

            var publicURL = ""
            var privateURL = "http://localhost:4000/forecastData/dailyForecast"

            fetch(privateURL, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            }).then((result) => {
                result.json().then((resp) => {
                    this.setState({ 
                        priceData: resp,
                        dataRetrieved: true,
                        loadingForecasts: false
                    })
                })
            }).catch((err) =>{
                console.log(err)
                this.setState({
                    loadingForecasts: false,
                    dataRetrieved: false
                })
            })
        }
        else{
            this.setState({
                alertText: "Please sign in to access this page!"
            })
            this.displayAlert()
            setTimeout(() => {this.props.history.push("/login")}, 2000)
        }
    }

    displayAlert(){
        // document.getElementById("alert-container-id").style.display = "block"
        document.getElementById("page").style.opacity = "0.5"
        document.getElementById("alert-container-id").style.visibility = "visible"
        document.getElementById("alert-container-id").style.opacity = "1"
    };

    backToTop = () => {
        window.scrollTo({
            top: 0,
            left: 0,
            behavior: 'smooth'
        });
    }

    goToBottom = () => {
        window.scrollTo({
            top: document.body.scrollHeight,
            left: 0,
            behavior: 'smooth'
        });
    }

    search = () => {
        var name = this.state.searchText
        try {
            var topValue = document.evaluate("//*[text()[contains(., '" + name  + "')]][last()]" , document.body).iterateNext().getBoundingClientRect().top
            if(topValue > 0){
                window.scrollTo({
                    top: topValue,
                    left: 0,
                    behavior: 'smooth'
                });
            }
        }
        catch(err){
            this.setState({
                alertText: "No item found! Please enter different item."
            })
            this.displayAlert()
        }
    }

    // ----------------------- Handling input changes ---------------------------

    handleInputChange = (event) => {
        const target = event.target;
        const name = target.name;
        const value = target.value;

        this.setState({
            [name]: value
        });
    }
}

export default DailyForecast;