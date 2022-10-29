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

                        <div className="footer-description-heading">FruGe</div> 

                        {/* <div className> */}

                        FruGe delivers price prediction for Fruits & Vegetables for today, tomorrow and next week. <br/><br/>
                        <i>Do not hesitate to contact us for any clarifications! <br/>

                        Mobile - +94777345678 </i>

                        <div className="footer-contact-wrapper">
                        <Link to="/dashboard" className="footer-contact-item"> <img src={whatsappIcon} width={20} height={20} /></Link>
                        <Link to="/vegetables" className="footer-contact-item"><img src={viberIcon} width={25} height={25} /></Link>
                        <Link to="/fruits" className="footer-contact-item"><img src={facebookIcon} width={20} height={20} /></Link>
                        <Link to="/" className="footer-contact-item"><img src={instagramIcon} width={20} height={20} /></Link>
                        </div>
                    </div>
                
                    <div className="footer-logo-wrapper"><img src={logo} width={200} height={200} className="footer-logo"/></div>

                    <div className="footer-nav-wrapper">
                        <h3 className="navigate-pages-text"> Navigate to pages</h3>
                        <Link to="/dashboard" className="footer-nav-item">Dashboard</Link>
                        <Link to="/vegetables" className="footer-nav-item">Vegetables</Link>
                        <Link to="/fruits" className="footer-nav-item">Fruits</Link>
                        <Link to="/" className="footer-nav-item">Login</Link>
                        <Link to="/signup" className="footer-nav-item">Signup</Link>
                    </div>

                    <div className="footer-impo-link-wrapper">
                        <h3 className="footer-impo-link-text"> Important Links</h3>
                        <Link to="/dashboard" className="footer-impo-item">Dashboard</Link>
                        <Link to="/vegetables" className="footer-impo-item">Vegetables</Link>
                        <Link to="/fruits" className="footer-impo-item">Fruits</Link>
                        <Link to="/" className="footer-impo-item">Login</Link>
                        <Link to="/signup" className="footer-impo-item">Signup</Link>
                    </div>
                </div>
            </footer>
        );
    }
}

export default Footer;