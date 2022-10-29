import React from 'react';
import '../css/navbar.css'
import { Link } from 'react-router-dom'
import logo from '../images/logo.png';

class Navbar extends React.Component {

    state = {
        loginText: "Sign in",
        userName: "guest",
        userText: "G"
    }

    render() {
        return (
            <div>
                <div className="nav-bar-line">
                    <div className="nav-bar-logo-wrapper"><Link to="/dashboard"><img src={logo} width={50} height={50} alt="FruGe Logo" className="nav-bar-logo" /></Link></div>
                    <div className="nav-item-wrapper">
                        <Link to="/dashboard" className="nav-item">Dashboard</Link>
                        <Link to="/vegetables" className="nav-item">Vegetables</Link>
                        <Link to="/fruits" className="nav-item">Fruits</Link>
                        <Link to="/riceAndGrains" className="nav-item">Rice & Grains</Link>
                        <Link to="/login" className="nav-item">Login</Link>
                        <Link to="/signup" className="nav-item">Signup</Link>
                    </div>
                    <div className='user-info-wrapper'>
                        <button onClick={this.userLogin} className="log-status-btn"> {this.state.loginText} </button>
                        <Link to="/guest">
                            <div className="user-icon-wrapper"><p className="user-icon">{this.state.userText}</p>
                                <span class="tooltiptext">Currently logged in as {this.state.userName}</span>
                            </div>
                        </Link>
                    </div>
                </div>
            </div>
        );
    }

    componentDidMount(){
        let isLogged = localStorage.getItem("isLogged")
        let userName = localStorage.getItem("userName")
        let userText = localStorage.getItem("userText")

        if(isLogged == "true"){
            this.setState({
                loginText: "Signed in",
                userName: userName,
                userText: userText
            })
        }
        else{
            this.setState({
                loginText: "Sign in"
            })
        }
    }

    userLogin = () => {
        let isLogged = localStorage.getItem("isLogged")

        if(isLogged == "true"){
            this.setState({
                loginText: "Sign in"
            })
            localStorage.setItem("isLogged", "false")
            localStorage.removeItem("userName")
            localStorage.removeItem("userText")
            window.location = "/login"
        }
        else{
            window.location  = "/login"
        }
    }
}

export default Navbar;