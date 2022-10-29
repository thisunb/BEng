import React from 'react';
import { StyleSheet, Text, View, Image } from 'react-native';
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';

class itemCard extends React.Component {

    constructor(props) {
        super(props)
    }

    state = {
        imageUrl: "",
        itemName: "",
        itemPrice: ""
    }

    render() {
        return (
            <View style={styles.itemContainer}>
                <Image source={this.props.imageUrl} style={styles.logoImage} />

                <View style={styles.itemName}>
                    <Text style={{ textAlign: 'center', color: 'white', fontSize: wp('2.5%'), }}> {this.props.itemName}</Text>
                </View>

                <View style={styles.itemPrice}>
                    <Text style={{ textAlign: 'center', color: 'black', fontSize: wp('2.5%'), fontStyle: 'italic', fontWeight: 'bold' }}> {this.props.itemPrice}</Text>
                </View>
            </View>
        );
    }
}

export default itemCard;

const styles = StyleSheet.create({

    itemContainer: {
        display: 'flex',
        width: wp('25%'),
        borderRadius: wp('1%'),
        borderWidth: wp('0.1%'),
        borderColor: 'green',
        alignItems: 'center',
    },

    logoImage: {
        width: '100%',
        borderRadius: wp('1%'),
        height: hp('12%'),
    },

    itemName: {
        padding: wp('1%'),
        width: '100%',
        fontWeight: 'bold',
        backgroundColor: 'green',
    },

    itemPrice: {
        padding: wp('2%'),
        width: '100%',
        fontWeight: 'bold',
        backgroundColor: '#A2D89E',
        borderBottomLeftRadius: wp('1%'),
        borderBottomRightRadius: wp('1%'),
    }
});