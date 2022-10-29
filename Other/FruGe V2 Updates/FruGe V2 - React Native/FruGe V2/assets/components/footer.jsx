import React from 'react';
import { StyleSheet, Text, View, Button, SafeAreaView, Image } from 'react-native';

export default function footer() {

    return (
        <View style={styles.container}>
            <Text style={styles.textColor}>Predicted Price for Today</Text>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        display: 'flex',
        height: '10%',
        width: '100%',
        backgroundColor: '#66DB5C',
        justifyContent: 'center',
        alignItems: 'center',
        borderTopEndRadius: 50,
        borderTopStartRadius: 50,
        textDecorationColor: 'white',
        position: 'absolute',
        bottom: 0,
    },

    textColor: {
        color: 'white',
        fontWeight: 'bold',
        fontSize: 18
    }
});