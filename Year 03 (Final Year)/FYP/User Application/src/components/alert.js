import React from 'react';
import '../css/alert.css';
import closeIcon from '../images/close-button-icon.png';

class Alert extends React.Component {

    constructor(props){
        super(props);
    }

    state = {
        alertText: ""
    }

    render() {
        return (    
            <div className="alert-container" id="alert-container-id">
                <div className='close-alert-icon-wrapper'><img id="close-alert-icon" src={closeIcon} width={20} height={20} alt="close button icon" onClick={() => this.handleCloseClick()} /></div>
                <div className='alert-heading-wrapper'><p id='alert-heading'>Alert</p></div>
                <div className='alert-text-wrapper'><p id='alert-text'>{this.props.alertText}</p></div>
            </div>    
        );
    }

    handleCloseClick=()=>{
        // document.getElementById("alert-container-id").style.display = "none"

        document.getElementById("page").style.opacity = "1"
        document.getElementById("alert-container-id").style.visibility = "hidden"
        document.getElementById("alert-container-id").style.opacity = "0"
        document.getElementById("alert-container-id").style.transition = "1s"
    }
}

export default Alert;