import React from 'react';
import '../css/form.css';
import { Link } from 'react-router-dom';
import logo from '../images/logo.png';
import loadingIcon from '../images/loading-icon.gif';

class signup extends React.Component {

    state = {
        firstName: "",
        lastName: "",
        username: "",
        email: "",
        password: "",
        confirmPassword: "",
        auth: true,
        errorText: "",
        loading: false
    };

    render() {
        return (
            <div className="form-page-wrapper">
                <div className="form-heading-text"> Signup</div>

                <div class="form-wrapper">
                    <form onSubmit={this.handleSignup}>
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
                        {
                            this.state.auth ?
                                <div />
                                : <p className="errorText">{this.state.errorText}!!</p>
                        }

                        {
                            this.state.loading ?
                                <div className="loading-icon"> Please Wait.. <img src={loadingIcon} width={20} height={20} alt="Loading icon" /></div>

                                : <div />
                        }

                        <div className="submit-button-wrapper">
                            <button type="submit" className="submit-button">Create Account</button>
                        </div>

                        <Link to="/" className="navigate-login-text">Already have an Account?</Link>
                    </form>
                </div>
            </div>
        );
    }

    handleSignup = (event) => {

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

        const privateURL = "http://localhost:4000/user/signup"
        const publicURL = "https://6zaa7xe4m3.execute-api.ap-south-1.amazonaws.com/dev/userAuth/*"

        fetch(publicURL, {

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
                    console.log('signup successful!')
                    alert("Signup successful! You will be redirected to Login Page..")
                    this.props.history.push("/")
                }
                else {
                    console.log(data.message)

                    this.setState({
                        auth: false,
                        errorText: data.message,
                        loading: false
                    })
                }
            });

        event.preventDefault();
    };

    handleInputChange = (event) => {

        const target = event.target
        const name = target.name;
        const value = target.value;

        this.setState({

            [name]: value
        });
    };
}

export default signup;