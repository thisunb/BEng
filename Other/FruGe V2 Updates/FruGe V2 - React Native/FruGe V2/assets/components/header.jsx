import React from 'react';
import { StyleSheet, Text, SafeAreaView, Image, StatusBar } from 'react-native';
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';

class header extends React.Component {

    constructor(props) {
        super(props)
    }

    state = {
        heading: ""
    }

    render() {
        return (
            <SafeAreaView style={styles.container}>
                <StatusBar hidden={true} />
                <Image source={require('../images/logo.png')} style={styles.logoImage} />
                <Text style={styles.headerText}>FruGe {this.props.heading}</Text>
            </SafeAreaView>
        );
    }
}

export default header;

const styles = StyleSheet.create({
    container: {
        height: hp('10%'),
        flexDirection: 'row',
        backgroundColor: '#66DB5C',
        alignItems: 'center',
        justifyContent: 'center',
        borderBottomEndRadius: wp('10%'),
        borderBottomStartRadius: wp('10%'),
        textDecorationColor: 'white',
        borderBottomWidth: wp('0.6%'),
        borderLeftWidth: wp('0.6%'),
        borderRightWidth: wp('0.6%'),
        borderColor: '#007C43'
    },

    logoImage: {
        width: wp('10%'),
        height: wp('10%'),
        borderColor: '#1F451C',
        borderWidth: wp('0.3%'),
        borderRadius: wp('5%'),
        position: 'absolute',
        top: hp('2%'),
        left: wp('2%'),
    },

    headerText: {
        color: 'white',
        fontWeight: 'bold',
        fontSize: wp('4%'),
        position: 'absolute',
        top: hp('4%'),
    }
});