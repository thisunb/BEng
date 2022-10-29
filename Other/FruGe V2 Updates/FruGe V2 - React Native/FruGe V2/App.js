import React from 'react';
import { StyleSheet } from 'react-native';
import Home from './assets/components/home';
import Vegetables from './assets/components/vegetables';
import Fruits from './assets/components/fruits';
import Login from './assets/components/login';
import Signup from './assets/components/signup';

import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

const Stack = createStackNavigator();

export default function App() {

  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="home" component={Home} options={{ headerShown: false }} />
        <Stack.Screen name="vegetables" component={Vegetables} options={{ headerShown: false }} />
        <Stack.Screen name="fruits" component={Fruits} options={{ headerShown: false }} />
        <Stack.Screen name="login" component={Login} options={{ headerShown: false }} />
        <Stack.Screen name="signup" component={Signup} options={{ headerShown: false }} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

const styles = StyleSheet.create({


});