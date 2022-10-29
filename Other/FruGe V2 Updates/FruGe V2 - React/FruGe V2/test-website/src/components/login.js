import React from 'react';
import '../css/form.css'
import logo from '../images/logo.png';
import loadingIcon from '../images/loading-icon.gif';
import { Link } from 'react-router-dom';

class login extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            username: '',
            password: '',
            auth: true,
            errorText: "",
            loading: false
        };

        this.handleInputChange = this.handleInputChange.bind(this);
        this.handleLogin = this.handleLogin.bind(this);
    }

    render() {
        return (
            <div className="form-page-wrapper">
                <div className="form-heading-text"> Login</div>

                <div className="form-wrapper">
                    <form onSubmit={this.handleLogin}>
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
                            <button type="submit" className="submit-button">Login</button>
                        </div>

                        <Link to="/signup" className="create-account-text1">Do not have an Account?</Link>

                        <div className="password-reset-text">
                            Forgot Password?
                        </div>
                    </form>
                </div>
            </div>
        );
    }

    handleLogin(event) {

        this.setState({

            loading: true
        });

        const payload = {
            userName: this.state.username,
            password: this.state.password
        }

        const privateURL = "http://localhost:4000/user/login"
        const publicURL = "https://ipubiu44v3.execute-api.ap-south-1.amazonaws.com/dev/userAuth"

        fetch(publicURL, {

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
                    console.log("login successfull")
                    this.props.history.push('/dashboard');
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
    }

    handleInputChange = (event) => {
        const target = event.target;
        const name = target.name;
        const value = target.value;

        this.setState({
            [name]: value
        });
    }
}

export default login;