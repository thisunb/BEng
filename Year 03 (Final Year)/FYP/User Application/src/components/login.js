import React from 'react';
import '../css/form.css'
import logo from '../images/logo.png';
import loadingIcon from '../images/loading-icon.gif';
import { Link } from 'react-router-dom';
import Alert from '../components/alert.js';

class login extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            username: '',
            password: '',
            auth: true,
            alertText: "",
            loading: false
        };
        this.handleInputChange = this.handleInputChange.bind(this);
        this.handleLogin = this.handleLogin.bind(this);
    }

    render() {
        return (
            <div>
                <Alert alertText={this.state.alertText}/>
                <div id="page">
                    <div className="form-page-wrapper">
                        <div className="form-heading-text"> Login</div>
                        <div className="form-wrapper">
                            <form className="login-form" onSubmit={this.handleLogin}>
                                <div>
                                    <img src={logo} width={100} height={100} alt="FruGe Logo" />
                                </div>

                                <div className="detail">
                                    <label className="labels">
                                        Username:
                                        <div className="input-text-area">
                                            <input type="text" required value={this.state.username} onChange={this.handleInputChange} name="username" className="inputText" placeholder="Enter your username" />
                                        </div>
                                    </label>
                                </div>

                                <div className="detail">
                                    <label className="labels">
                                        Password:
                                        <div className="input-text-area">
                                            <input type="password" required value={this.state.password} onChange={this.handleInputChange} name="password" className="inputText" placeholder="Enter your password" />
                                        </div>
                                    </label>
                                </div>

                                {this.state.loading ?
                                    <div className="loading-icon"> Please Wait.. <img src={loadingIcon} width={20} height={20} alt="Loading icon" /></div>
                                    : <div />}

                                <div className="submit-button-wrapper">
                                    <button type="submit" className="submit-button">Login</button>
                                </div>

                                <Link to="/signup" className="create-account-text1">Do not have an account?</Link>

                                <div className="password-reset-text">
                                    Forgot password?
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    // ------------------------------------ User login function ----------------------------------

    handleLogin(event) {
        
        this.setState({
            loading: true
        });
        const payload = {
            userName: this.state.username,
            password: this.state.password
        }

        const privateURL = "http://localhost:4000/userAuth/login"
        const publicURL = ""

        fetch(privateURL, {

            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-type': 'application/json'
            },
            body: JSON.stringify(payload)
        })
            .then(res => res.json())
            .then((data) => {
                if (data.auth) {
                    this.setState({
                        alertText: "Login successfull!"
                    })
                    localStorage.setItem("isLogged", "true")
                    localStorage.setItem("userName", this.state.username)
                    localStorage.setItem("userText", this.state.username.charAt(0).toUpperCase())
                    this.displayAlert()
                    window.location = "/dashboard"
                    // setTimeout(() => {this.props.history.push('/dashboard')}, 3000)
                }
                else {
                    console.log(data.message)
                    this.setState({
                        auth: false,
                        alertText: data.message,
                        loading: false
                    })
                }
                this.displayAlert()
            });
        event.preventDefault();
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

    displayAlert(){
        // document.getElementById("alert-container-id").style.display = "block"
        document.getElementById("page").style.opacity = "0.5"
        document.getElementById("alert-container-id").style.visibility = "visible"
        document.getElementById("alert-container-id").style.opacity = "1"
    };
}

export default login;