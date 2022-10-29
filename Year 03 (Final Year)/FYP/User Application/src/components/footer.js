import React from 'react';
import '../css/footer.css'
import { Link } from 'react-router-dom'
import whatsappIcon from '../images/whatsapp.png';
import viberIcon from '../images/viber.png';
import instagramIcon from '../images/instagram.png';
import facebookIcon from '../images/facebook.png';
import logo from '../images/logo.png';

class Footer extends React.Component {
    render() {
        return (
            <footer>
                <div className="footer-wrapper">
                    <div className="footer-description">
                        <div className="footer-description-heading">Website</div> 
                        This website delivers price forecasts of food commodities available in the Sri Lankan market. <br/><br/>
                        <i>Do not hesitate to contact us for any clarifications! <br/>
                        Mobile - +94770319316 </i>
                        <div className="footer-contact-wrapper">
                        <a href="https://www.whatsapp.com/" target="_blank" className="footer-contact-item"> <img src={whatsappIcon} width={20} height={20} /></a>
                        <a href="https://www.viber.com/en/" target="_blank" className="footer-contact-item"><img src={viberIcon} width={25} height={25} /></a>
                        <a href="https://www.facebook.com/" target="_blank" className="footer-contact-item"><img src={facebookIcon} width={20} height={20} /></a>
                        <a href="https://www.instagram.com/" target="_blank" className="footer-contact-item"><img src={instagramIcon} width={20} height={20} /></a>
                        </div>
                    </div>

                    <div className="footer-logo-wrapper"><img src={logo} width={200} height={200} className="footer-logo"/></div>
                    
                    <div className="footer-nav-wrapper">
                        <h3 className="navigate-pages-text"> Navigate to pages</h3>
                        <Link to="/dashboard" className="footer-nav-item">Dashboard</Link>
                        <Link to="/vegetables" className="footer-nav-item">Vegetables</Link>
                        <Link to="/fruits" className="footer-nav-item">Fruits</Link>
                        <Link to="/login" className="footer-nav-item">Login</Link>
                        <Link to="/signup" className="footer-nav-item">Signup</Link>
                    </div>
 
                    <div className="footer-impo-link-wrapper">
                        <h3 className="footer-impo-link-text"> Important Links</h3>
                        <Link to="/dailyForecast" className="footer-impo-item">Daily Forecast</Link>
                        <Link to="/weeklyForecast" className="footer-impo-item">Weekly Forecast</Link>
                        <Link to="/monthlyForecast" className="footer-impo-item">Monthly Forecast</Link>
                    </div>
                </div>
            </footer>
        );
    }
}

export default Footer;

