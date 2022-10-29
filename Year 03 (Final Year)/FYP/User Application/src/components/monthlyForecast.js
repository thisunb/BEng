import React from 'react';
import '../css/commodityPages.css';
import loadingIcon from '../images/loading-icon.gif';
import backToTopIcon from '../images/back-to-top-icon.jpg';
import Alert from '../components/alert.js';
import MonthlyChart from './monthlyChart';

class MonthlyForecast extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            priceData: [],
            dataRetrieved: false,
            loadingForecasts: false,
            rows: [],
            startMonthDate: "",
            alertText: "",
            searchText: ""        
        }
        this.handleInputChange = this.handleInputChange.bind(this);
    }
    
    render() {
        return (
            <div>
                <Alert alertText={this.state.alertText}/>
                <div id="page">
                    <div className='dashboard-body-wrapper'>
                        <div className='dashboard-body'>
                            <div className="dashboard-heading-text"> 
                                Monthly Forecast
                            </div>
                            <div className="searchArea">
                                <input type="text" required value={this.state.searchText} onChange={this.handleInputChange} name="searchText" className="searchText" placeholder="Search" />
                                <button onClick={this.search} className="search-btn"> Search </button>
                            </div>
                            {
                                this.state.loadingForecasts ?
                                    <div className='dashboard-loading-icon'><img src={loadingIcon} style={{marginBottom:"50px"}} width={50} height={50} alt="Loading icon" /></div>
                                
                                :this.state.dataRetrieved && this.state.startMonthDate != "" ?
                                    <div>
                                        <div className="dashboard-sub-heading-text" style={{textAlign: "left", paddingLeft: "20px"}}> Monthly Forecast - Next 3 months starting from {this.state.startMonthDate} </div>
                                        <tbody className='charts-container'>{this.state.rows}</tbody>
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
            var privateURL = "http://localhost:4000/forecastData/monthlyForecast"

            fetch(privateURL, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            }).then((result) => {
                result.json().then((resp) => {

                    for(var i = 0; i < resp.length; i++){
                        var singleCommodityData = resp[i]
                        var currentItem = singleCommodityData["item_name"]

                        this.state.rows.push(
                            <div style={{textTransform: "capitalize", borderRadius: "1px 35px 1px 35px", backgroundColor: "#060026", color:"white"}} className="dashboard-heading-text"> 
                                <img style={{float: "left", cursor: "pointer"}} onClick={this.backToTop} src={backToTopIcon}  width={40} height={40} alt="Back to icon" />
                                {currentItem.replace(/_/g, ' ')}
                                <img style={{float: "right", cursor: "pointer", transform: "rotate(180deg)"}} onClick={this.goToBottom} src={backToTopIcon}  width={40} height={40} alt="Back to icon" />
                            </div>
                        )
                        var forecast_data = singleCommodityData["forecast_data"]
        
                        for(var j = 0; j < forecast_data.length; j++){
                            var singleForecastData = forecast_data[j]
                            this.state.rows.push(<MonthlyChart item_name={currentItem.replace(/_/g, ' ')}  month={singleForecastData["month_category"]} data={singleForecastData["monthly_data"]}/>)

                            if(j == 0){
                                this.setState({
                                    startMonthDate: singleForecastData["monthly_data"][0]["date"]
                                })
                            }
                        }
                    }
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

export default MonthlyForecast;