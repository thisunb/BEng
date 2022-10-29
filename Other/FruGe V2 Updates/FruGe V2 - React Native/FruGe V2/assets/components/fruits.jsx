import React from 'react';
import { StyleSheet, Text, View, ScrollView, ImageBackground } from 'react-native';
import Header from './header';
import ItemCard from './itemCard';
import NavSection from './navSection';
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';
import image from '../images/nav-background-fruits.png';

class fruits extends React.Component {

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
            <View style={{ flex: 1 , backgroundColor: '#EFFFF4'}}>

                <ImageBackground source={image} style={styles.image} blurRadius={0.5} >
                    <Header heading="- Fruits" />
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
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/banana.jpg')} itemName="Banana" itemPrice={"Rs. " + priceData[15][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/lime.jpg')} itemName="Lime" itemPrice={"Rs. " + priceData[13][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/papaya.png')} itemName="Papaya" itemPrice={"Rs. " + priceData[16][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/pineapple.jpg')} itemName="Pineapple" itemPrice={"Rs. " + priceData[17][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/mango.jpg')} itemName="Mango" itemPrice={"Rs. " + priceData[18][selectedDate]} /></View>
                                <View style={styles.item}><ItemCard imageUrl={require('../images/items/avocado.jpg')} itemName="Avocado" itemPrice={"Rs. " + priceData[19][selectedDate]} /></View>
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

export default fruits;


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