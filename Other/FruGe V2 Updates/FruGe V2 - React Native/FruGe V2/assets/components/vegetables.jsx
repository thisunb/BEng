import React from 'react';
import { StyleSheet, Text, View, ScrollView, ImageBackground } from 'react-native';
import Header from './header';
import ItemCard from './itemCard';
import NavSection from './navSection';
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';
import image from '../images/nav-background-veg.png';

class vegetables extends React.Component {

    state = {
        priceData: false,
        selectedDate: "today",
        dateText: "date",
        appendDateText: "Today",

        clickedStyle1: "date-button-inner-clicked",
        clickedStyle2: "date-button-inner",
        clickedStyle3: "date-button-inner",
    }

    render() {

        const priceData = this.state.priceData
        console.log(priceData)

        const selectedDate = this.state.selectedDate
        const dateText = this.state.dateText
        const appendDateText = this.state.appendDateText

        const clickedStyle1 = this.state.clickedStyle1
        const clickedStyle2 = this.state.clickedStyle2
        const clickedStyle3 = this.state.clickedStyle3

        return (
            <View style={{ flex: 1, backgroundColor: '#EFFFF4' }}>

                <ImageBackground source={image} style={styles.image} blurRadius={0.5} >
                    <Header heading="- Vegetables" />
                    <NavSection />
                </ImageBackground>

                {
                    priceData ?
                        <View><Text style={styles.subHeading}> Predicted prices for {appendDateText} ({priceData[0][dateText]})</Text></View>
                        : <View />
                }

                <ScrollView>

                    {
                        priceData ?

                            <View style={styles.itemCardContainer}>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/beans.png')} itemName="Beans" itemPrice={"Rs. " + priceData[0][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/carrot.png')} itemName="Carrot" itemPrice={"Rs. " + priceData[1][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/leeks.png')} itemName="Leeks" itemPrice={"Rs. " + priceData[2][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/knolkhol.jpg')} itemName="Knolkhol" itemPrice={"Rs. " + priceData[4][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/cabbage.png')} itemName="Cabbage" itemPrice={"Rs. " + priceData[5][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/tomato.png')} itemName="Tomato" itemPrice={"Rs. " + priceData[6][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/ladiesfingers.png')} itemName="Ladies Fingers" itemPrice={"Rs. " + priceData[7][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/brinjals.png')} itemName="Brinjals" itemPrice={"Rs. " + priceData[8][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/pumpkin.png')} itemName="Pumpkin" itemPrice={"Rs. " + priceData[9][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/cucumber.png')} itemName="Cucumber" itemPrice={"Rs. " + priceData[10][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/bittergourd.png')} itemName="Bitter Gourd" itemPrice={"Rs. " + priceData[11][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/greenchilies.jpg')} itemName="Green Chiilies" itemPrice={"Rs. " + priceData[12][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/beetroot.png')} itemName="Beet Root" itemPrice={"Rs. " + priceData[3][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/potato.png')} itemName="Potato" itemPrice={"Rs. " + priceData[14][selectedDate]} /></View>
                            </View>

                            : <View style={styles.loadingText}>
                                <Text style={{ fontWeight: 'bold', fontStyle: 'italic', textAlign: 'center', fontSize: wp('3%') }}>Loading...</Text>
                            </View>
                    }

                </ScrollView>
            </View>
        );
    }

    componentDidMount() {

        var publicURL = "https://1upfqc4cxh.execute-api.ap-south-1.amazonaws.com/dev/priceData"
        var privateURL = "http://localhost:3001/priceData"
        var privateURL2 = "http://192.168.1.23:3001/priceData"

        fetch(publicURL, {

            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        }).then((result) => {

            result.json().then((resp) => {

                this.setState({ priceData: resp })
            })
        })
    }
}

export default vegetables;


//----------------------------------------------- Styles--------------------------------------------


const styles = StyleSheet.create({

    image: {
        resizeMode: 'cover',
        justifyContent: 'center',
    },

    itemCardContainer: {
        flexDirection: 'row',
        display: 'flex',
        justifyContent: 'center',
        flexWrap: 'wrap',
        backgroundColor: '#EFFFF4'
    },

    item: {
        marginTop: hp('2%'),
        marginBottom: hp('1%'),
        marginLeft: wp('2%'),
        marginRight: wp('2%'),
        backgroundColor: 'white'
    },

    loadingText: {
        padding: wp('4%'),
    },

    subHeading: {
        width: '100%',
        backgroundColor: '#668A6E',
        color: '#E8FFEE',
        textAlign: 'center',
        fontWeight: 'bold',
        fontStyle: 'italic',
        padding: wp('2%'),
        fontSize: wp('3%')
    }
});