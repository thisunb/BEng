import React from 'react';
import axios from 'axios';
import '../css/produceForecast.css';
import Alert from '../components/alert.js';
import ForecastItem from '../components/forecastItem.js';
import loadingIcon from '../images/loading-icon.gif';
import refreshIcon from '../images/refresh-icon.png';
import io from 'socket.io-client';

class ProduceForecast extends React.Component {

  constructor(props){
    super(props);
    this.forecastConfig = this.forecastConfig.bind(this);
  }

  state = { 
    selectedFiles: [],
    serverResponse: [],
    commodityList: [],
    existCommodityList: [],
    newCommodityList: [],
    selectedCommodityList: [],
    alertText: "",
    previousItems: false,
    newItemsAdded: false,
    displayProcessStatus: false,
    
    processingText: "",
    selectedConfig: "",
    highlightParameterTuning: {},
    highlightTrain: {},
    highlightForecast: {},
    parameterTuning: false,
    modelTrain: false,
    priceForecast: false,
    loadingForecast: false,
    loadingExistingForecasts: false,
    chooseExistItemFiles: false,
    chooseNewItemFiles: false,
    currentlyRunningProcess: false,
    previousProcessFinished: false
  }; 

  componentDidMount(){
    this.fetchExistingForecast()
    this.displayAnyCurrentlyRunningProcess()
  }

  async displayAnyCurrentlyRunningProcess(){
    var publicURL = ""
    var privateURL = "http://localhost:4000/dataModel/checkRunningProcess"

    await fetch(privateURL, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    })
    .then(res => res.json())
    .then((data) => {
      this.setState({
        currentlyRunningProcess: data[0].updating
      })
    })
    .catch((err) =>{
      console.log(err)
    })  

    // --- Display unfinished / running processes ---
    if(this.state.currentlyRunningProcess){
      this.setState({
        displayProcessStatus: true,
        loadingForecast: true,
        alertText: "Previously started process is still running..."
      })
      this.displayAlert()
      this.fetchFlaskServerUpdates()
    }
  }

  handleForecastItemSelection = (event) => {
    const id = (event.target.id).replace(/ /g,"_")
    const list = this.state.selectedCommodityList

    if(list.includes(id)){
      for(var i = 0; i < list.length; i++){
        if(list[i] === id){
          list.splice(i, 1)
        }
      }
      // --- Change the tile styles ---
      event.target.style.backgroundColor = "transparent"
      event.target.style.borderColor = "#71E47B"
      event.target.style.color = "white"
    }
    else{
      list.push(id)
      // --- Change the tile styles ---
      event.target.style.backgroundColor = "#7CF086"
      event.target.style.borderColor = "white"
      event.target.style.color = "black"
    }
    this.setState({
      selectedCommodityList: list
    })
  }

  forecastConfig(event){
    const id = event.target.id
    if(id == "parameter-tuning"){
      this.setState({
        parameterTuning: true,
        modelTrain: true,
        priceForecast: true,
        highlightParameterTuning: {backgroundColor:"#7CF086", color:"black", borderColor:'white'},
        highlightTrain: {backgroundColor:"transparent", color:"white"},
        highlightForecast: {backgroundColor:"transparent", color:"white"}
      })
    }
    else if(id == "train"){
      this.setState({
        parameterTuning: false,
        modelTrain: true,
        priceForecast: true,
        highlightParameterTuning: {backgroundColor:"transparent", color:"white"},
        highlightTrain: {backgroundColor:"#7CF086", color:"black", borderColor:'white'},
        highlightForecast: {backgroundColor:"transparent", color:"white"}
      })
    }
    else{
      this.setState({
        parameterTuning: false,
        modelTrain: false,
        priceForecast: true,
        highlightParameterTuning: {backgroundColor:"transparent", color: "white"},
        highlightTrain: {backgroundColor:"transparent", color:"white"},
        highlightForecast: {backgroundColor:"#7CF086", color:"black", borderColor:'white'}
      })
    }
  }

  onFileChange = (event) => { 
    this.setState({
      chooseExistItemFiles: false,
      chooseNewItemFiles: false
    })

    if(event.target.id == "choose-update-files"){
      this.setState({
        chooseExistItemFiles: true
      })
    }
    else{
      this.setState({
        chooseNewItemFiles: true
      })
    }

    this.setState({
      selectedFiles: event.target.files
    })
  }; 

  onFileUpload = (event) => { 
    const selectedFiles = this.state.selectedFiles
    var  message = ""

    if(selectedFiles.length > 0){

      event.preventDefault()
      const formData = new FormData();

      for(var i = 0; i < selectedFiles.length; i++){
        formData.append("files", selectedFiles[i], selectedFiles[i].filename);
      }

      try {
        axios({
          method: "POST",
          url: "http://127.0.0.1:5000/uploadFiles",
          data: formData,
        });
      } 
      catch(error) {
        console.log(error)
      }

      message = "Files have been uploaded!"
      this.setState({
        alertText: message
      })

      if(event.target.id == "add-new-btn"){
        // --- Add newly added items to selected items list ---
        const existCommodityList = this.state.existCommodityList
        const selectedCommodityList = this.state.selectedCommodityList
        const newCommodityList = this.state.newCommodityList
        const sameItemsSelected = []

        for(var i = 0; i < selectedFiles.length; i++){
          var itemName = String(selectedFiles[i]["name"]).replace(".xlsx", "")
          if(selectedCommodityList.includes(itemName) == false){
            selectedCommodityList.push(itemName)
          }
          if(existCommodityList.includes(itemName) == false & newCommodityList.includes(itemName) == false){
            newCommodityList.push(itemName)
          }
          else{
            sameItemsSelected.push(itemName)
          }
        }

        var displayNewItems = false
        newCommodityList.length > 0 ? displayNewItems=true : displayNewItems=false

        if(sameItemsSelected.length > 0){
          message = "Already available files are not added."
        }

        this.setState({
          selectedCommodityList: selectedCommodityList,
          newCommodityList: newCommodityList,
          newItemsAdded: displayNewItems,
          selectedFiles: [],
          alertText : message
        })
      }
    }
    else{
      message = "Choose files to upload and start forecast!"
      this.setState({
        alertText: message
      })
    }
    if(message != "") {
      this.displayAlert()
    }
  };

  startForecast = () => {

    if(this.state.selectedCommodityList.length == 0){
      this.setState({
        alertText: "Select items from existing forecasts and/or add new data set to start forecast!",
      })
      this.displayAlert()
    }
    else if(!this.state.priceForecast){
      this.setState({
        alertText: "Select a forecast configuration!",
      })
      this.displayAlert()
    }
    else{
      // --- Display process status box ---
      this.setState({
        displayProcessStatus: true
      })

      this.setState({
        loadingForecast: true
      })

      this.setState({
        serverResponse: []
      })

      var publicURL = ""
      var privateURL = "http://localhost:4000/dataModel/trainForecast"

      var payload = {
        "commodityList": this.state.selectedCommodityList,
        "parameterTuning": this.state.parameterTuning,
        "modelTrain": this.state.modelTrain,
        "priceForecast": this.state.priceForecast
      }

      this.fetchFlaskServerUpdates()

      fetch(privateURL, {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
      })
      .then(res => res.json())
        .then((data) => {
        console.log(data.message)      
        this.setState({
          alertText: data.message,
          loadingForecast: false
        })   
        this.displayAlert()
      })
      .catch((err) =>{
        this.setState({
          alertText: err.message,
          loadingForecast: false
        })   
        this.displayAlert()
      })  
    }
  }

  refreshSelectedFiles = (event) => {
    if(event.target.id == "refresh-new-items" && this.state.chooseNewItemFiles){
      var selectedCommodityList = this.state.selectedCommodityList
      var newCommodityList = this.state.newCommodityList
      for(var i = 0; i < newCommodityList.length; i++){
        if(selectedCommodityList.includes(newCommodityList[i])){
          for(var j = 0; j < selectedCommodityList.length; j++){
            if(newCommodityList[i] === selectedCommodityList[j]){
              selectedCommodityList.splice(j, 1)
              break
            }
          }
        }
      }
      this.setState({
        newCommodityList: [],
        selectedFiles: [],
        newItemsAdded: false
      })
    }

    if(event.target.id == "refresh-exist-items" && this.state.chooseExistItemFiles){
      this.setState({
        selectedFiles: []
      })
    }
  }

  fetchExistingForecast(){
    var publicURL = ""
    var privateURL = "http://localhost:4000/dataModel/modelTrainData"

    this.setState({
      loadingExistingForecasts: true
    })

    fetch(privateURL, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    })
    .then(res => res.json())
    .then((data) => {   
      this.setState({
        commodityList: data,
        loadingExistingForecasts: false
      })   
    })
    .catch((err) =>{
      this.setState({
        alertText: err.message,
        loadingExistingForecasts: false
      })   
      this.displayAlert()
    })  
  }

  fetchFlaskServerUpdates(){
    const socket = io("http://localhost:4000/", {transports: ['websocket']})
    this.setState(() =>{
      socket.on("receive_message", (data) => {
        this.setState({
          serverResponse: data.messages
        })
        const responseBox = document.getElementById('response-box-id');
        responseBox.scrollTop = responseBox.scrollHeight;

        // --- Display ui update for previously running processes ---
        if(data.updating == false){
          this.setState({
            alertText: "Process finished! Check client app for any updates.",
            loadingForecast: false
          })
          this.displayAlert()
        }
      })
    })
  };

  displayAlert(){
    document.getElementById("alert-container-id").style.display = "block"
    document.getElementById("body-id").style.opacity = "0.7"
    document.getElementById("body-id").style.pointerEvents = "none"
  };

  render() { 
    const serverResponse = this.state.serverResponse
    var rows = [];
    for (var i = 0; i < serverResponse.length; i++) {
      rows.push(<p key={i} style={{color:"white"}}>{serverResponse[i]}</p> );
    }    

    const commodityList = this.state.commodityList
    const existCommodityList = this.state.existCommodityList
    var rows2 = [];
    for(var i = 0; i < commodityList.length; i++){
      existCommodityList.push(commodityList[i]["item_name"])
      rows2.push(<ForecastItem clickEvent={this.handleForecastItemSelection} id={commodityList[i]["item_name"]} item_name={String(commodityList[i]["item_name"]).replace(/_/g, ' ')}/>)
    }

    const newCommodityList = this.state.newCommodityList
    var rows3 = [];
    for(var i = 0; i < newCommodityList.length; i++){
      rows3.push(<ForecastItem item_name={String(newCommodityList[i]).replace(/_/g, ' ')}/>)
    }

    const selectedFiles = this.state.selectedFiles
    var rows4 = [];
    for(var i = 0; i < selectedFiles.length; i++){
      if(i === (selectedFiles.length - 1)){
        rows4.push(<p style={{fontStyle:"italic"}}>{selectedFiles[i].name}&nbsp;</p>)
      }
      else{
        rows4.push(<p style={{fontStyle:"italic"}}>{selectedFiles[i].name},&nbsp;</p>)
      }
    }

    return ( 
      <div>
        <div>
          <Alert alertText={this.state.alertText}/>
        </div>
        <div id="body-id" className='produce-container-container'> 
          <div className='forecast-executer'>

            {/* --- Existing forecasts section --- */}

            <div className='forecast-item-heading'>Existing Forecasts ({commodityList.length})</div> 

            <div style={{display:"flex", flexDirection:"row", justifyContent:"space-between", width:"100%"}}>
              <div className='forecast-item-subheading'><p>Previously completed forecasts are listed here: Update data files for existing items.</p></div>
              <div className='file-uploader-container'>
                <div className='file-uploader' id="update"> 
                  <input  type="file" multiple name="file" onChange={this.onFileChange} id="choose-update-files" hidden/> 
                  <label className='choose-file-btn' for="choose-update-files">Choose file</label><br/>
                  <button id="update-btn" onClick={this.onFileUpload} className="upload-button"> Upload </button> 
                </div>
                <div style={{display:"flex", justifyContent:"center"}}>
                  <div id="refresh-exist-items" className='refresh-icon-wrapper' onClick={this.refreshSelectedFiles}>
                    <span id="refresh-exist-items" className='refresh-text'>Refresh</span>
                    <img id="refresh-exist-items" src={refreshIcon} width={40} height={20} alt="Refresh icon"/></div>
                </div>
              </div>
            </div>

            {
              this.state.loadingExistingForecasts ?
                <div style={{textAlign:"center"}}><img src={loadingIcon} style={{marginBottom:"50px"}} width={50} height={50} alt="Loading icon" /></div>
                  
              :this.state.commodityList.length > 0 ?
                <div className='available-forecast-container' >
                  <tbody style={{display:"flex", flexDirection:"row", flexWrap:"wrap", width:"100%", justifyContent:"center"}}>{rows2}</tbody>
                </div>
              :<div style={{marginBottom:"100px"}} className='no-added-message'>Previous forecasts are not available!</div>
            }
            
            {
              this.state.selectedFiles.length > 0 && this.state.chooseExistItemFiles ?
              <div id="selected-files-list-upper" className='selected-files-container-wrapper'>
                <span style={{color:"white", marginBottom:"5px", fontWeight:"600"}}>Selected files:</span>
                <tbody className='selected-files-container'>{rows4}</tbody>
              </div>
              :null
            }

            {/* --- New item forecast section --- */}

            <div className='forecast-item-heading'>New Item Forecast ({newCommodityList.length})</div> 

            <div id="j" style={{display:"flex", flexDirection:"row", justifyContent:"space-between", width:"100%"}}>
              <div className='forecast-item-subheading'><p>Add a new commodity to produce forecast:</p></div>
              <div className='file-uploader-container'>
                <div className='file-uploader' id="upload"> 
                  <input type="file" multiple name="file" onChange={this.onFileChange} id="choose-new-files" hidden/>
                  <label className='choose-file-btn' for="choose-new-files">Choose file</label><br/>
                  <button id="add-new-btn" onClick={this.onFileUpload} className="upload-button"> Upload </button> 
                </div>
                <div style={{display:"flex", justifyContent:"center"}}>
                  <div id="refresh-new-items" className='refresh-icon-wrapper' onClick={this.refreshSelectedFiles}>
                    <span id="refresh-new-items" className='refresh-text'>Refresh</span>
                    <img id="refresh-new-items" src={refreshIcon} width={40} height={20} alt="Refresh icon"/>
                  </div>
                </div>
              </div>
            </div>

            {
              this.state.newItemsAdded ?
              <div className='new-forecast-container'>
                <tbody style={{display:"flex", flexDirection:"row", flexWrap:"wrap", width:"100%", justifyContent:"center"}}>{rows3}</tbody>
              </div>
              : <div style={{marginBottom:"100px"}} className='no-added-message'>New commodities are not added yet.</div>
            }   

            {
              this.state.selectedFiles.length > 0 && this.state.chooseNewItemFiles ?
              <div id="selected-files-list-lower" className='selected-files-container-wrapper'>
                <span style={{color:"white", marginBottom:"5px", fontWeight:"600"}}>Selected files:</span>
                <tbody className='selected-files-container'>{rows4}</tbody>
              </div>
              :null
            }

            {/* --- Forecast configuration section --- */}

            <div className='forecast-item-heading'>Forecast Configuration</div> 

            <div style={{display:"flex", justifyContent:"space-between", width:"100%"}}>
              <div style={{display:"flex", flexWrap:"wrap", alignSelf:"flex-start"}} className='forecast-item-subheading'><p>Select forecast configuration:</p></div>
              
              <div style={{display:"flex", flexWrap:"wrap", marginTop:"40px", marginBottom:"30px"}}>
                <div className='config-item' style={this.state.highlightParameterTuning} id="parameter-tuning" onClick={this.forecastConfig}>Parameter tune, train & forecast</div>
                <div className='config-item' style={this.state.highlightTrain} id="train" onClick={this.forecastConfig}>Model train & forecast</div>
                <div className='config-item' style={this.state.highlightForecast} id="forecast" onClick={this.forecastConfig}>Forecast only</div>
              </div>
            </div>

            {/* --- Start forecast section --- */}

            <div className='forecast-item-heading'>Start Forecast</div>
            <div style={{display:"flex", alignSelf:"flex-start"}} className='forecast-item-subheading'><p>Select commodities in existing forecasts and/or add new commodities to produce forecast:</p></div>
            
            {
              this.state.loadingForecast ?
                <div style={{textAlign:"center"}}><img src={loadingIcon} width={50} height={50} alt="Loading icon" /></div>
              :null
            }
            
            {
              this.state.displayProcessStatus ?
              <div> 
                <div className='response-heading'>Process status:</div>
                <div id="response-box-id" className='response-box'><tbody style={{display:"flex", flexDirection:"column", flexWrap:"wrap", justifyContent:"center"}}>{rows}</tbody></div>
              </div> 
              : null
            }

            <div>
              <button onClick={this.startForecast} className="forecast-button"> Produce forecast </button>
            </div>
          </div> 
        </div> 
      </div> 
    ); 
  } 
}

export default ProduceForecast;