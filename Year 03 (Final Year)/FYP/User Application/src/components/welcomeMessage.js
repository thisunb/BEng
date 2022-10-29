import React from 'react';
import '../css/welcomeMessage.css';
import { Link } from 'react-router-dom'
import closeIconWhite from '../images/close-button-white.png';
import bulletIcon1 from '../images/bullet-image1.png';
import bulletIcon2 from '../images/bullet-image2.png';
import bulletIcon3 from '../images/bullet-image3.png';
import logo from '../images/logo.png';

class Welcome extends React.Component {

    constructor(props){
        super(props);
    }

    state = {
        isLogged: "",
        userName: ""
    }

    render() {
        return (    
            <div className="welcome-container" id="welcome-container-id">
                <div className='close-welcome-icon-wrapper'><img id="close-welcome-icon" src={closeIconWhite} width={30} height={30} alt="close white button icon" onClick={() => this.handleCloseClick()} /></div>

                {
                    this.state.isLogged == "true" ?
                        <div className='welcome-heading-wrapper'><p id='welcome-heading'>Welcome {this.state.userName} !</p></div>
                    :       
                    <div className='welcome-heading-wrapper'><p id='welcome-heading'>Welcome!</p></div>
                }
                
                <div className="welcome-logo-wrapper"><img src={logo} width={200} height={200} className="welcome-logo"/></div>
                <div className='welcome-text-wrapper'>
                    <div id='welcome-text'>
                        {
                            this.state.isLogged == "true" ?
                            <div>
                                <img src={bulletIcon1} width={40} height={40} alt="close button icon"/>Now you are in the Dashboard page which displays daily price forecasts of food commodities. <br/><br/>
                                <img src={bulletIcon2} width={40} height={40} alt="close button icon"/>You can navigate through <Link to="/vegetables"><span style={{color:"#2B8E18"}}>vegetables</span></Link>, <Link to="/fruits"><span style={{color:"#AB5033"}}>fruits</span></Link>, and <Link to="/riceAndGrains"><span style={{color:"#613EAC"}}>rice & grains</span></Link> pages for categorical view. <br/><br/>
                                <img src={bulletIcon3} width={40} height={40} alt="close button icon"/>Use important links section for seasonal view of the prices.
                            </div>
                        :       
                            <div>
                                <img src={bulletIcon1} width={40} height={40} alt="close button icon"/>This website displays the price forecasts for food commodities available in Sri Lankan market. <br/><br/>
                                <img src={bulletIcon2} width={40} height={40} alt="close button icon"/>You are landed in the guest page and you will only be able to view price forecast for limited number of commodities. <br/><br/>
                                <img src={bulletIcon3} width={40} height={40} alt="close button icon"/>Please <Link to="/signup"><span className='welcome-signup-link'>signup </span></Link> by creating an account to get full access for the service.
                            </div>
                        }
                    </div>
                </div>
            </div>    
        );
    }

    handleCloseClick=()=>{
        document.getElementById("page").style.opacity = "1"
        document.getElementById("welcome-container-id").style.visibility = "hidden"
        document.getElementById("welcome-container-id").style.opacity = "0"
        document.getElementById("welcome-container-id").style.transition = "1s"
    }

    componentDidMount(){
        const isLogged = localStorage.getItem("isLogged")
        const userName = localStorage.getItem("userName")

        if(isLogged == "true"){
            this.setState({
                isLogged: "true",
                userName: userName
            })
        }
    }
}

export default Welcome;