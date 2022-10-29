import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';
import { useNavigation } from '@react-navigation/native';

export default function navSection() {

    const navigation = useNavigation();

    return (
        <View style={styles.navSection}>

            <TouchableOpacity
                onPress={() => navigation.navigate('home')}
                style={styles.dashboardNav} >
                <Text style={{ textAlign: 'center', fontWeight: 'bold', color: 'white', fontSize: wp('3%') }}> Dashboard</Text>
            </TouchableOpacity>

            <TouchableOpacity
                onPress={() => navigation.navigate("vegetables")}
                style={styles.vegeNav} >
                <Text style={{ textAlign: 'center', fontWeight: 'bold', color: 'white', fontSize: wp('3%') }}> Vegetables</Text>
            </TouchableOpacity>

            <TouchableOpacity
                onPress={() => navigation.navigate("fruits")}
                style={styles.fruitNav} >
                <Text style={{ textAlign: 'center', fontWeight: 'bold', color: 'white', fontSize: wp('3%') }}> Fruits</Text>
            </TouchableOpacity>

            <TouchableOpacity
                onPress={() => navigation.navigate("login")}
                style={styles.loginNav} >
                <Text style={{ textAlign: 'center', fontWeight: 'bold', color: 'white', fontSize: wp('3%') }}> Login</Text>
            </TouchableOpacity>

            <TouchableOpacity
                onPress={() => navigation.navigate("signup")}
                style={styles.signupNav} >
                <Text style={{ textAlign: 'center', fontWeight: 'bold', color: 'white', fontSize: wp('3%') }}> Signup</Text>
            </TouchableOpacity>
        </View>
    );
}


//----------------------------------------------- Styles--------------------------------------------


const styles = StyleSheet.create({

    image: {
        resizeMode: 'cover',
        justifyContent: 'center',
    },

    navSection: {
        marginTop: hp('0.8%'),
        padding: hp('3%'),
        display: 'flex',
        flexDirection: 'row',
        flexWrap: 'wrap',
        justifyContent: 'center',
        alignItems: 'center',
    },

    dashboardNav: {
        width: wp('30%'),
        marginTop: wp('1%'),
        marginRight: wp('1%'),

        padding: wp('4%'),
        textAlign: 'center',
        backgroundColor: '#2C5F25',
        borderBottomEndRadius: wp('1%'),
        borderBottomStartRadius: wp('10%'),
        borderTopEndRadius: wp('10%'),
        borderTopStartRadius: wp('1%'),
        borderColor: '#66DB5C',
        borderWidth: wp('0.7%')
    },

    vegeNav: {
        width: wp('30%'),
        marginTop: wp('1%'),
        marginRight: wp('1%'),
        padding: wp('4%'),
        textAlign: 'center',
        backgroundColor: '#2C5F25',
        borderBottomEndRadius: wp('10%'),
        borderBottomStartRadius: wp('1%'),
        borderTopEndRadius: wp('1%'),
        borderTopStartRadius: wp('10%'),
        borderColor: '#66DB5C',
        borderWidth: wp('0.7%')
    },

    fruitNav: {
        width: wp('30%'),
        marginTop: wp('1%'),
        marginRight: wp('1%'),
        padding: wp('4%'),
        textAlign: 'center',
        backgroundColor: '#2C5F25',
        borderBottomEndRadius: wp('1%'),
        borderBottomStartRadius: wp('10%'),
        borderTopEndRadius: wp('10%'),
        borderTopStartRadius: wp('1%'),
        borderColor: '#66DB5C',
        borderWidth: wp('0.7%')
    },

    loginNav: {
        width: wp('30%'),
        marginTop: wp('1%'),
        marginRight: wp('1%'),
        padding: wp('4%'),
        textAlign: 'center',
        backgroundColor: '#2C5F25',
        borderBottomEndRadius: wp('10%'),
        borderBottomStartRadius: wp('1%'),
        borderTopEndRadius: wp('1%'),
        borderTopStartRadius: wp('10%'),
        borderColor: '#66DB5C',
        borderWidth: wp('0.7%')
    },

    signupNav: {
        width: wp('30%'),
        marginTop: wp('1%'),
        marginRight: wp('1%'),
        padding: wp('4%'),
        textAlign: 'center',
        backgroundColor: '#2C5F25',
        borderBottomEndRadius: wp('1%'),
        borderBottomStartRadius: wp('10%'),
        borderTopEndRadius: wp('10%'),
        borderTopStartRadius: wp('1%'),
        borderColor: '#66DB5C',
        borderWidth: wp('0.7%')
    },
});