import React from 'react';
import '../css/navbar.css'
import { Link } from 'react-router-dom'
import logo from '../images/logo.png';

class Navbar extends React.Component {

    render() {
        return (
            <div className="nav-bar-line">
                <div className="nav-bar-logo-wrapper"><Link to="/dashboard"><img src={logo} width={60} height={60} alt="FruGe Logo" className="nav-bar-logo" /></Link></div>
                <div className="nav-item-wrapper">
                    <Link to="/dashboard" className="nav-item">Dashboard</Link>
                    <Link to="/vegetables" className="nav-item">Vegetables</Link>
                    <Link to="/fruits" className="nav-item">Fruits</Link>
                    <Link to="/" className="nav-item">Login</Link>
                    <Link to="/signup" className="nav-item">Signup</Link>
                </div>
            </div>
        );
    }
}

export default Navbar;