import React from 'react';
import { StyleSheet, Text, View, ScrollView, TouchableOpacity, TextInput, ImageBackground, Image } from 'react-native';
import Header from './header';
import NavSection from './navSection';
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';
import image from '../images/form-background.jpg';

class login extends React.Component {

    state = {
        username: '',
        password: '',
        auth: true,
        errorText: "",
        loading: false
    }

    render() {
        return (
            <View style={{ flex: 1, backgroundColor: '#EFFFF4' }}>

                <ImageBackground source={image} style={styles.image} blurRadius={1.5} >
                    <Header heading="- Login" />
                    <NavSection />
                </ImageBackground>

                <ScrollView>
                    <View style={styles.formWrapper}>

                        <View style={styles.logoImageContainer}><Image source={require('../images/logo.png')} style={styles.logoImage} /></View>

                        <View style={styles.detail}>
                            <View style={styles.inputTextArea}>
                                <Text style={{ fontWeight: 'bold', padding: wp('1%'), fontSize: wp('3%') }}>Username:</Text>
                                <TextInput
                                    style={styles.textFieldStyle}
                                    placeholder="Enter your username"
                                    textAlign="center"
                                    onChangeText={(text) => { this.setState({ username: text }) }}
                                />
                            </View>
                        </View>

                        <View style={styles.detail}>
                            <View style={styles.inputTextArea}>
                                <Text style={{ fontWeight: 'bold', padding: wp('1%'), fontSize: wp('3%') }}>Password: </Text>
                                <TextInput
                                    style={styles.textFieldStyle}
                                    secureTextEntry={true}
                                    placeholder="Enter your password"
                                    textAlign="center"
                                    onChangeText={(text) => { this.setState({ password: text }) }}
                                />
                            </View>
                        </View>

                        {
                            this.state.auth ?
                                <View />
                                : <View style={styles.errorText}><Text style={{ textAlign: 'center', fontSize: wp('3%'), fontWeight: 'bold', fontStyle: 'italic' }}>{this.state.errorText}!!</Text></View>
                        }

                        {
                            this.state.loading ?
                                <View style={styles.loadingIcon}><Text style={{ textAlign: 'center', fontSize: wp('3%'), fontWeight: 'bold' }}> Please Wait..</Text></View>

                                : <View />
                        }

                        <TouchableOpacity
                            onPress={this.handleLogin}>
                            <View style={styles.submitButtonWrapper}>
                                <Text style={{ textAlign: 'center', color: 'white', fontWeight: 'bold', fontSize: wp('3%') }}>Login</Text>
                            </View>
                        </TouchableOpacity>

                        <View style={styles.passwordResetText}>
                            <TouchableOpacity>
                                <Text style={{ textAlign: 'center', fontWeight: 'bold', fontStyle: 'italic', fontSize: wp('3%') }}>Forgot Password?</Text>
                            </TouchableOpacity>
                        </View>
                    </View>
                </ScrollView>
            </View>
        );
    }

    handleLogin = () => {

        const username = this.state.username
        const password = this.state.password

        if (username == "" || password == "") {

            this.setState({
                auth: false,
                errorText: "Please Fill all the required fields"
            });
        }
        else {

            this.setState({

                loading: true
            });

            const payload = {
                userName: this.state.username,
                password: this.state.password
            }

            const privateURL = "http://localhost:4000/user/login"
            const privateURL2 = "http://192.168.1.23:4000/user/login"
            const publicURL = "https://ipubiu44v3.execute-api.ap-south-1.amazonaws.com/dev/userAuth"

            fetch(publicURL, {

                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-type': 'application/json'
                },
                body: JSON.stringify(payload)
            })
                .then(res => res.json())
                .then((data) => {
                    if (data.auth) {
                        console.log("login successful")
                        alert("Login Sucessful!")
                        this.props.navigation.navigate("home");
                    }
                    else {
                        console.log(data.message)
                        this.setState({
                            auth: false,
                            errorText: data.message,
                            loading: false

                        })
                    }
                });
        }
    }
}

export default login;


//----------------------------------------------- Styles--------------------------------------------


const styles = StyleSheet.create({

    image: {
        resizeMode: 'cover',
        justifyContent: 'center',
    },

    formWrapper: {
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#D6F5C1',
    },

    logoImageContainer: {
        marginTop: hp('5%'),
        justifyContent: 'center',
        alignItems: 'center',
    },

    logoImage: {
        width: wp('20%'),
        height: wp('20%'),
        borderColor: '#1F451C',
        borderWidth: wp('1%'),
        borderRadius: wp('20%'),
    },

    textFieldStyle: {
        justifyContent: 'center',
        alignSelf: 'center',
        width: wp('70%'),
        borderWidth: wp('0.08%'),
        padding: wp('2.5%'),
        borderRadius: wp('2%'),
        borderColor: '#6DC11E',
        backgroundColor: 'white',
        fontSize: wp('3%')
    },

    detail: {
        justifyContent: 'center',
        alignSelf: 'center',
        padding: wp('2%'),
    },

    submitButtonWrapper: {
        marginTop: wp('5%'),
        justifyContent: 'center',
        alignSelf: 'center',
        width: wp('50%'),
        padding: wp('5%'),
        backgroundColor: 'green',
        borderRadius: wp('3%'),
    },

    passwordResetText: {
        marginTop: wp('3%'),
        marginBottom: wp('6%'),
    },

    errorText: {
        marginTop: hp('1%')
    },

    loadingIcon: {
        marginTop: hp('1%')
    },
});