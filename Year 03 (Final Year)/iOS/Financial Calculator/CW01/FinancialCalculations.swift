//
//  FinancialCalculations.swift
//  CW01
//
//  Created by user214394 on 3/17/22.

// Author details
    // --- M.R.T.T Bandara
    // --- 2019356 / W1761298

// Code references
    // --- https://cocoacasts.com/ud-4-how-to-store-a-dictionary-in-user-defaults-in-swift
    // --- https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
    // --- https://stackoverflow.com/questions/36028493/add-a-scrollview-to-existing-view

import Foundation
import UIKit

class FinancialCalculations{
    
    var principalAmount: Float = 0.0
    var loanAmount: Float = 0.0
    var interestRate: Float = 0.0
    var monthlyPayment: Float = 0.0
    var futureValue: Float = 0.0
    var numberOfPayments: Float = 0.0
    
    init(principal: Float, loan: Float, interest: Float, monthlyPay: Float, futureVal: Float, paymentCount: Float){
        principalAmount = principal
        loanAmount = loan
        interestRate = interest
        monthlyPayment = monthlyPay
        futureValue = futureVal
        numberOfPayments = paymentCount
    }
    
    // ------------------------- Compound savings calculations -----------------------
    
    func compoundSavingsPrincipalAmountCalculation() -> Float{
        principalAmount = (futureValue-(monthlyPayment*(pow((1+interestRate/1200), numberOfPayments)-1)/(interestRate/1200)))/(pow((1+interestRate/1200), numberOfPayments))
        print("principal amount (compound savings) - " + String(principalAmount))
        return round(principalAmount * 100) / 100.0
    }
    
    func compoundSavingsInterestRateCalculation() -> Float{
        interestRate = 1200*(pow((futureValue/principalAmount), (1/(numberOfPayments)))-1)
        print("interest rate (compound savings) - " + String(interestRate))
        return round(interestRate * 100) / 100.0
    }
    
    func compoundSavingsMonthlyPaymentCalculation() -> Float{
        monthlyPayment = (futureValue-(principalAmount*(pow((1+interestRate/1200), (numberOfPayments)))))/((pow((1+interestRate/1200), (numberOfPayments))-1)/(interestRate/1200))
        print("monthly payment (compound savings) - " + String(monthlyPayment))
        return round(monthlyPayment * 100) / 100.0
    }
    
    func compoundSavingsFutureValueCalculation() -> Float{
        futureValue =  principalAmount * (pow((1+interestRate/1200), (numberOfPayments))) + monthlyPayment*((pow((1+interestRate/1200), (numberOfPayments))-1)/(interestRate/1200))
        print("future value (compound savings) - " + String(futureValue))
        return round(futureValue * 100) / 100.0
    }
    
    func compoundSavingsNumberOfPaymentsCalculation() -> Float{
        numberOfPayments = log10(((futureValue*interestRate/1200) + monthlyPayment)/((principalAmount*interestRate/1200) + monthlyPayment))/(12*log10(1+interestRate/1200))
        print("number of payments (compound savings) - " + String(numberOfPayments))
        return ceil(numberOfPayments * 12)
    }
    
    // -------------------------- Simple savings calculations -------------------------
    
    func simpleSavingsPrincipalAmountCalculation() -> Float{
        principalAmount = futureValue/pow((1+interestRate/1200), (numberOfPayments))
        print("principal amount (simple savings) - " + String(principalAmount))
        return round(principalAmount * 100) / 100.0
    }
    
    func simpleSavingsInterestRateCalculation() -> Float{
        interestRate = 1200*(pow((futureValue/principalAmount), (1/(numberOfPayments)))-1)
        print("interest rate (simple savings) - " + String(interestRate))
        return round(interestRate * 100) / 100.0
    }
    
    func simpleSavingsFutureValueCalculation() -> Float{
        futureValue = principalAmount*pow(1+interestRate/1200, (numberOfPayments))
        print("future value (simple savings) - " + String(futureValue))
        return round(futureValue * 100) / 100.0
    }
    
    func simpleSavingsNumberOfPaymentsCalculation() -> Float{
        numberOfPayments = log(futureValue/principalAmount)/(log(1+interestRate/1200))
        print("number of payments (simple savings) - " + String(numberOfPayments))
        return ceil(numberOfPayments)
    }
    
    // -------------------------- Loans mortgage calculations --------------------------
    
    func loansMortgageLoanAmountCalculation() -> Float{
        loanAmount = (monthlyPayment*((pow((interestRate/1200+1), (12)))-1)*(pow((interestRate/1200+1), (-12))))/(interestRate/1200)
        print("loan amount (loans mortgage) - " + String(loanAmount))
        return round(loanAmount * 100) / 100.0
    }
    
    func loansMortgageMonthlyPaymentCalculation() -> Float{
        monthlyPayment = ((loanAmount*interestRate/1200)*pow((1+interestRate/1200), (numberOfPayments)))/(pow((1+interestRate/1200), (numberOfPayments))-1)
        print("monthly payment (loans mortgage) - " + String(monthlyPayment))
        return round(monthlyPayment * 100) / 100.0
    }
    
    func loansMortgageNumberOfPaymentsCalculation() -> Float{
        numberOfPayments = log10(1-((loanAmount/monthlyPayment)*(interestRate/1200)))/(-log10(interestRate/1200+1))
        print("number of payments (loans mortgage) - " + String(numberOfPayments))
        if(numberOfPayments.isNaN){
            numberOfPayments = 0
        }
        return ceil(numberOfPayments)
    }
}
