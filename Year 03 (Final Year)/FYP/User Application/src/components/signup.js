import React from 'react';
import '../css/form.css';
import { Link } from 'react-router-dom';
import logo from '../images/logo.png';
import loadingIcon from '../images/loading-icon.gif';
import Alert from './alert.js';

class Signup extends React.Component {

    state = {
        firstName: "",
        lastName: "",
        username: "",
        email: "",
        password: "",
        confirmPassword: "",
        auth: true,
        alertText: "",
        loading: false
    };

    render() {
        return (
            <div>
                <Alert alertText={this.state.alertText}/>
                <div id="page">
                    <div className="form-page-wrapper" id="form-page-wrapper-id">
                        <div className="form-heading-text"> Signup</div>
                        <div className="form-wrapper">
                            <form className="signup-form" onSubmit={this.handleSignup}>
                                <img src={logo} width={100} height={100} alt="FruGe Logo" />

                                <div className="detail">
                                    <label className="labels">
                                        First Name:
                                        <div className="input-text-area">
                                            <input type="text" required value={this.state.firstName} onChange={this.handleInputChange} name="firstName" className="inputText" placeholder="Enter your username" />
                                        </div>
                                    </label>
                                </div>

                                <div className="detail">
                                    <label className="labels">
                                        Last Name:
                                        <div className="input-text-area">
                                            <input type="text" required value={this.state.lastName} onChange={this.handleInputChange} name="lastName" className="inputText" placeholder="Enter your username" />
                                        </div>
                                    </label>
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
                                        Email:
                                        <div className="input-text-area">
                                            <input type="email" required value={this.state.email} onChange={this.handleInputChange} name="email" className="inputText" placeholder="Enter your username" />
                                        </div>
                                    </label>
                                </div>

                                <div className="detail">
                                    <label className="labels">
                                        Password:
                                        <div className="input-text-area">
                                            <input type="password" required value={this.state.password} onChange={this.handleInputChange} name="password" className="inputText" placeholder="Enter your username" />
                                        </div>
                                    </label>
                                </div>

                                <div className="detail">
                                    <label className="labels">
                                        Confirm Password:
                                        <div className="input-text-area">
                                            <input type="password" required value={this.state.confirmPassword} onChange={this.handleInputChange} name="confirmPassword" className="inputText" placeholder="Enter your password" />
                                        </div>
                                    </label>
                                </div>
            
                                {this.state.loading ?
                                    <div className="loading-icon"> Please Wait.. <img src={loadingIcon} width={20} height={20} alt="Loading icon" /></div>
                                    : <div />}

                                <div className="submit-button-wrapper">
                                    <button type="submit" className="submit-button">Create Account</button>
                                </div>

                                <Link to="/login" className="navigate-login-text">Already have an account?</Link>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    // ---------------------------- User signup function ------------------------------

    handleSignup = (event) => {

        if(this.state.password == this.state.confirmPassword){

            this.setState({
                loading: true
            });
    
            let status = 0;
    
            const payload = {
                firstName: this.state.firstName,
                lastName: this.state.lastName,
                userName: this.state.username,
                email: this.state.email,
                password: this.state.password,
            }

            const privateURL = "http://localhost:4000/userAuth/signup"
            const publicURL = ""

            fetch(privateURL, {

                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-type': 'application/json'
                },
                body: JSON.stringify(payload)
            })
            .then(res => res.json(
                status = res.status
            ))
            .then((data) => {
                if (status == 201) {
                    this.setState({
                        alertText: "Signup successful! You will be redirected to Login Page.."
                    })
                    this.displayAlert()
                    setTimeout(() => {this.props.history.push("/login")}, 3000)
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
        }
        else{
            this.setState({
                alertText: "Password mismatch!"
            })
            this.displayAlert()
        }
        event.preventDefault();
    };

    // ----------------------- Handling input changes ---------------------------

    handleInputChange = (event) => {
        const target = event.target
        const name = target.name;
        const value = target.value;

        this.setState({
            [name]: value
        });
    };

    // --------------- Display Alert ------------------

    displayAlert(){
        // document.getElementById("alert-container-id").style.display = "block"
        document.getElementById("page").style.opacity = "0.5"
        document.getElementById("alert-container-id").style.visibility = "visible"
        document.getElementById("alert-container-id").style.opacity = "1"
    };
}

export default Signup;