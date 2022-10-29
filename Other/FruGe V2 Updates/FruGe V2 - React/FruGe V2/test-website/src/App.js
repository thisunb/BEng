import React from 'react';
import login from './components/login.js'
import signup from './components/signup.js'
import dashboard from './components/dashboard.js'
import fruits from './components/fruits.js'
import vegetables from './components/vegetables.js'
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom'
import Navbar from './components/navbar.js';
import Footer from './components/footer.js';
import './App.css';

class App extends React.Component {
  render() {
    return (
      <Router>
        <Navbar/>
        <Switch>
          <Route exact path='/' component={login} />
          <Route path='/signup' component={signup} />
          <Route path='/dashboard' component={dashboard} />
          <Route path='/vegetables' component={vegetables}/>
          <Route path='/fruits' component={fruits}/>
          {/* <Route path='/footer' component={Footer}/> */}
        </Switch>
        <Footer/>
      </Router>
    );
  }
}

export default App;