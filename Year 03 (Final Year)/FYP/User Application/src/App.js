import React from 'react';
import Guest from './components/guest.js';
import Dashboard from './components/dashboard.js';
import Vegetables from './components/vegetables.js';
import Fruits from './components/fruits.js';
import RiceAndGrains from './components/riceAndGrains.js';
import DailyForecast from './components/dailyForecast.js';
import WeeklyForecast from './components/weeklyForecast.js';
import MonthlyForecast from './components/monthlyForecast.js';
import Login from './components/login.js';
import Signup from './components/signup.js';
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
          <Route exact path='/' component={Guest} />
          <Route path='/guest' component={Guest} />
          <Route path='/login' component={Login} />
          <Route path='/signup' component={Signup} />
          <Route path='/dashboard' component={Dashboard} />
          <Route path='/vegetables' component={Vegetables} />
          <Route path='/fruits' component={Fruits} />
          <Route path='/riceAndGrains' component={RiceAndGrains} />
          <Route path='/dailyForecast' component={DailyForecast} />
          <Route path='/weeklyForecast' component={WeeklyForecast} />
          <Route path='/monthlyForecast' component={MonthlyForecast} />
        </Switch>
        <Footer/>
      </Router>
    );
  }
}

export default App;