import React from 'react';
import '../css/commodityPages.css';
import Chart from './chart';
import loadingIcon from '../images/loading-icon.gif';
import Alert from '../components/alert.js';
import WelcomeMessage from '../components/welcomeMessage.js';

class Dashboard extends React.Component {

    state = {
        priceData: [],
        dataRetrieved: false,
        loadingForecasts: false,
        alertText: ""
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
                <WelcomeMessage welcomeText={this.state.welcomeText}/>
                <div id = "page">
                    <div className='dashboard-body-wrapper'>
                        <div className='dashboard-body'>
                            <div className="dashboard-heading-text"> Dashboard</div>
                            {
                                this.state.loadingForecasts ?
                                    <div className='dashboard-loading-icon'><img src={loadingIcon} style={{marginBottom:"50px"}} width={50} height={50} alt="Loading icon" /></div>
                                
                                :this.state.dataRetrieved ?
                                    <div>
                                        <div className="dashboard-sub-heading-text"> Daily Price Forecast - Next 90 days starting from {priceData[0]["forecast_data"][0]["date"]} </div>
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

            setTimeout(() => {this.displayWelcomeMessage()}, 2000)

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

    displayWelcomeMessage(){
        document.getElementById("page").style.opacity = "0.5"
        document.getElementById("welcome-container-id").style.visibility = "visible"
        document.getElementById("welcome-container-id").style.opacity = "1"
    };
}

export default Dashboard;