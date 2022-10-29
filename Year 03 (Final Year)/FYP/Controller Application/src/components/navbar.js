import React from 'react';
import '../css/navbar.css'
import { Link } from 'react-router-dom'
import logo from '../images/logo.png';

class Navbar extends React.Component {

    render() {
        return (
            <div className="nav-bar-line">
                <div className="nav-bar-logo-wrapper"><Link to="/dashboard"><img src={logo} width={50} height={50} alt="FruGe Logo" className="nav-bar-logo" /></Link></div>
                <div className="nav-item-wrapper">
                    <Link to="/" className="nav-item">Commodity Data</Link>
                    <Link to="/produceforecast" className="nav-item">Produce Forecast</Link>
                </div>
            </div>
        );
    }
}

export default Navbar;