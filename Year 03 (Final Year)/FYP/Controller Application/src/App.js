import React from 'react';
import commodityData from './components/commodityData.js';
import produceForecast from './components/produceForecast.js'
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import Navbar from './components/navbar.js';
import Footer from './components/footer.js';
import './App.css';

class App extends React.Component {
  render() {
    return (
      <Router>
        <Navbar/>
        <Switch>
          <Route exact path='/' component={commodityData} />
          <Route path='/produceForecast' component={produceForecast} />
        </Switch>
        <Footer/>
      </Router>
    );
  }
}

export default App;