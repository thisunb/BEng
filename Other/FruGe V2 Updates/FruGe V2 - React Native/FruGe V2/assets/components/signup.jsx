import React from "react";
import { StyleSheet, Text, View, ScrollView, TouchableOpacity, TextInput, ImageBackground, Image } from "react-native";
import Header from "./header";
import NavSection from "./navSection";
import { widthPercentageToDP as wp, heightPercentageToDP as hp, } from "react-native-responsive-screen";
import image from '../images/form-background.jpg';

class signup extends React.Component {
    state = {
        firstName: "",
        lastName: "",
        username: "",
        email: "",
        password: "",
        confirmPassword: "",
        auth: true,
        errorText: "",
        loading: false,
    };

    render() {
        return (
            <View style={{ flex: 1, backgroundColor: '#EFFFF4' }}>

                <ImageBackground source={image} style={styles.image} blurRadius={1.5} >
                    <Header heading="- Signup" />
                    <NavSection />
                </ImageBackground>

                <ScrollView>
                    <View style={styles.formWrapper}>

                        <View style={styles.logoImageContainer}><Image source={require('../images/logo.png')} style={styles.logoImage} /></View>

                        <View style={styles.detail}>
                            <View style={styles.inputTextArea}>
                                <Text style={{ fontWeight: 'bold', padding: wp('1%'), fontSize: wp('3%') }}>First Name: </Text>
                                <TextInput
                                    style={styles.textFieldStyle}
                                    placeholder="Enter your first name"
                                    textAlign="center"
                                    onChangeText={(text) => {
                                        this.setState({ firstName: text });
                                    }}
                                />
                            </View>
                        </View>

                        <View style={styles.detail}>
                            <View style={styles.inputTextArea}>
                                <Text style={{ fontWeight: 'bold', padding: wp('1%'), fontSize: wp('3%') }}>Last Name: </Text>
                                <TextInput
                                    style={styles.textFieldStyle}
                                    placeholder="Enter your last name"
                                    textAlign="center"
                                    onChangeText={(text) => {
                                        this.setState({ lastName: text });
                                    }}
                                />
                            </View>
                        </View>

                        <View style={styles.detail}>
                            <View style={styles.inputTextArea}>
                                <Text style={{ fontWeight: 'bold', padding: wp('1%'), fontSize: wp('3%') }}>Username: </Text>
                                <TextInput
                                    style={styles.textFieldStyle}
                                    placeholder="Enter your username"
                                    textAlign="center"
                                    onChangeText={(text) => {
                                        this.setState({ username: text });
                                    }}
                                />
                            </View>
                        </View>

                        <View style={styles.detail}>
                            <View style={styles.inputTextArea}>
                                <Text style={{ fontWeight: 'bold', padding: wp('1%'), fontSize: wp('3%') }}>Email: </Text>
                                <TextInput
                                    style={styles.textFieldStyle}
                                    placeholder="Enter your email"
                                    textAlign="center"
                                    onChangeText={(text) => {
                                        this.setState({ email: text });
                                    }}
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
                                    onChangeText={(text) => {
                                        this.setState({ password: text });
                                    }}
                                />
                            </View>
                        </View>

                        <View style={styles.detail}>
                            <View style={styles.inputTextArea}>
                                <Text style={{ fontWeight: 'bold', padding: wp('1%'), fontSize: wp('3%') }}>Confirm Password: </Text>
                                <TextInput
                                    style={styles.textFieldStyle}
                                    secureTextEntry={true}
                                    placeholder="Confirm your password"
                                    textAlign="center"
                                    onChangeText={(text) => {
                                        this.setState({ confirmPassword: text });
                                    }}
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
                                <View style={styles.loadingIcon}><Text style={{ textAlign: 'center', fontWeight: 'bold' }}> Please Wait..</Text></View>

                                : <View />
                        }

                        <TouchableOpacity onPress={this.handleSignup}>
                            <View style={styles.submitButtonWrapper}>
                                <Text style={{ textAlign: "center", color: "white", fontWeight: "bold", fontSize: wp('3%') }}>
                                    Signup
                                </Text>
                            </View>
                        </TouchableOpacity>

                        <View style={styles.navToLogin}>
                            <TouchableOpacity
                                onPress={() => this.props.navigation.navigate("login")}>
                                <Text style={{ textAlign: "center", fontSize: wp('3%'), fontWeight: "bold", fontStyle: "italic", marginTop: hp('1%'), marginBottom: hp('2%') }} >
                                    Already have an account?
                                </Text>
                            </TouchableOpacity>
                        </View>
                    </View>
                </ScrollView>
            </View>
        );
    }

    handleSignup = () => {
        const firstName = this.state.firstName
        const lastName = this.state.lastName
        const username = this.state.username
        const email = this.state.email
        const password = this.state.password
        const confirmPassword = this.state.confirmPassword

        if (firstName == "" || lastName == "" || username == "" || email == "" || password == "" || confirmPassword == "") {

            this.setState({
                auth: false,
                errorText: "Please Fill all the required fields"
            });
        }
        else {

            if (password != confirmPassword) {
                this.setState({
                    auth: false,
                    errorText: "Password does not match with the confirm password"
                });
            }
            else {

                this.setState({
                    loading: true,
                });

                let status = 0;

                const payload = {
                    firstName: this.state.firstName,
                    lastName: this.state.lastName,
                    userName: this.state.username,
                    email: this.state.email,
                    password: this.state.password,
                };

                const privateURL = "http://localhost:4000/user/signup";
                const privateURL2 = "http://192.168.1.23:4000/user/signup";
                const publicURL = "https://6zaa7xe4m3.execute-api.ap-south-1.amazonaws.com/dev/userAuth/*";

                fetch(publicURL, {
                    method: "POST",
                    headers: {
                        Accept: "application/json",
                        "Content-type": "application/json",
                    },
                    body: JSON.stringify(payload),
                })
                    .then((res) => res.json((status = res.status)))
                    .then((data) => {
                        if (status == 201) {
                            console.log("signup successful!");
                            alert("Signup successful! You will be redirected to Login Page..");
                            this.props.navigation.navigate("login");
                        } else {
                            console.log(data.message);

                            this.setState({
                                auth: false,
                                errorText: data.message,
                                loading: false,
                            });
                        }
                    });
            }
        }
    };
}

export default signup;

//----------------------------------------------- Styles--------------------------------------------

const styles = StyleSheet.create({

    image: {
        resizeMode: 'cover',
        justifyContent: 'center',
    },

    formWrapper: {
        backgroundColor: '#D6F5C1',
    },

    logoImageContainer: {
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: hp('2%')
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

    errorText: {
        marginTop: hp('1%')
    },

    loadingIcon: {
        marginTop: hp('1%')
    },

    navToLogin: {
        marginTop: hp('1%')
    },
});