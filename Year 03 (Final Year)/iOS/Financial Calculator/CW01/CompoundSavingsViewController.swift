//
//  CompoundSavingsViewController.swift
//  CW01
//
//  Created by user214394 on 3/19/22.

// Author details
    // --- M.R.T.T Bandara
    // --- 2019356 / W1761298

// Code references
    // --- https://cocoacasts.com/ud-4-how-to-store-a-dictionary-in-user-defaults-in-swift
    // --- https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
    // --- https://stackoverflow.com/questions/36028493/add-a-scrollview-to-existing-view

import UIKit

class CompoundSavingsViewController: UIViewController {

    @IBOutlet weak var compoundSavingsPageScrollView: UIScrollView!
    @IBOutlet weak var principalAmountTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var monthlyPaymentTextField: UITextField!
    @IBOutlet weak var futureValueTextField: UITextField!
    @IBOutlet weak var numberOfPaymentsTextField: UITextField!
    
    var principalAmountText: String = ""
    var interestRateText: String = ""
    var monthlyPaymentText: String = ""
    var futureValueText: String = ""
    var numberOfPaymentsText: String = ""
    
    var principalAmount: Float = 0
    var interestRate: Float = 0
    var monthlyPayment: Float = 0
    var futureValue: Float = 0
    var numberOfPayments: Float = 0
    
    var allTextFieldsList: [UITextField] = []
    var filledTextFieldsList: [UITextField] = []
    
    var result: Float = 0
    
    var lastUpdatedTextField: UITextField!
    var resultDisplayedTextfield: UITextField!
    
    var financialCalculationsObj: FinancialCalculations?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // --- Set scroll view dimensions ---
        compoundSavingsPageScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        
        financialCalculationsObj = FinancialCalculations(principal: 0.0, loan: 0.0, interest: 0.0, monthlyPay: 0.0, futureVal: 0.0, paymentCount: 0.0)
        
        allTextFieldsList.append(contentsOf: [principalAmountTextField, interestRateTextField, monthlyPaymentTextField, futureValueTextField, numberOfPaymentsTextField])
        
        loadUserEnteredData()
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        // --- Refresh textfields ---
        principalAmountTextField.text = ""
        interestRateTextField.text = ""
        monthlyPaymentTextField.text = ""
        futureValueTextField.text = ""
        numberOfPaymentsTextField.text = ""
        
        // --- Refresh array elements ---
        allTextFieldsList.removeAll()
        allTextFieldsList.append(contentsOf: [principalAmountTextField, interestRateTextField, monthlyPaymentTextField, futureValueTextField, numberOfPaymentsTextField])
        filledTextFieldsList.removeAll()
        
        if(resultDisplayedTextfield != nil){
            resultDisplayedTextfield.backgroundColor = UIColor.secondaryLabel
        }
        
        // --- Save user entered data ---
        saveUserEnteredData()
        
        // --- Display an alert ---
        let alert = UIAlertController(title: "Compound Savings", message: "Your inputs have been refreshed!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveUserEnteredData() -> Void {
        let defaults = UserDefaults.standard
        let userEnteredData = [
            "principalAmount": principalAmountTextField.text,
            "interestRate": interestRateTextField.text,
            "monthlyPayment": monthlyPaymentTextField.text,
            "futureValue": futureValueTextField.text,
            "numberOfPayments": numberOfPaymentsTextField.text
        ]
        defaults.set(userEnteredData, forKey: "compoundSavingsUserInput")
    }
    
    func loadUserEnteredData() -> Void {
        let defaults = UserDefaults.standard
        let previousEnteredValues: [String: String] = defaults.object(forKey: "compoundSavingsUserInput") as? [String:String] ?? [:]
        principalAmountTextField.text = previousEnteredValues["principalAmount"]
        interestRateTextField.text = previousEnteredValues["interestRate"]
        monthlyPaymentTextField.text = previousEnteredValues["monthlyPayment"]
        futureValueTextField.text = previousEnteredValues["futureValue"]
        numberOfPaymentsTextField.text = previousEnteredValues["numberOfPayments"]
    }
    
    // --------- Principal amount textfield value change function -----------
    
    @IBAction func principalAmountAction(_ sender: Any) {
        if(resultDisplayedTextfield != nil){
            resultDisplayedTextfield.text = ""
            resultDisplayedTextfield.backgroundColor = UIColor.secondaryLabel
            resultDisplayedTextfield = nil
        }
        lastUpdatedTextField = principalAmountTextField
        principalAmountText = principalAmountTextField.text!
        principalAmount = (principalAmountText as NSString).floatValue
        validate(textfield: principalAmountTextField, text: principalAmountText)
        if(filledTextFieldsList.count == 4){
            calculate()
        }
        display()
        saveUserEnteredData()
    }
    
    // --------- Interest rate textfield value change function -----------
    
    @IBAction func interestRateAction(_ sender: Any) {
        if(resultDisplayedTextfield != nil){
            resultDisplayedTextfield.text = ""
            resultDisplayedTextfield.backgroundColor = UIColor.secondaryLabel
            resultDisplayedTextfield = nil
        }
        lastUpdatedTextField = interestRateTextField
        interestRateText = interestRateTextField.text!
        interestRate = (interestRateText as NSString).floatValue
        validate(textfield: interestRateTextField, text: interestRateText)
        if(filledTextFieldsList.count == 4){
            calculate()
        }
        display()
        saveUserEnteredData()
    }
    
    // --------- Monthly payment textfield value change function -----------
    
    @IBAction func monthlyPaymentAction(_ sender: Any) {
        if(resultDisplayedTextfield != nil){
            resultDisplayedTextfield.text = ""
            resultDisplayedTextfield.backgroundColor = UIColor.secondaryLabel
            resultDisplayedTextfield = nil
        }
        lastUpdatedTextField = monthlyPaymentTextField
        monthlyPaymentText = monthlyPaymentTextField.text!
        monthlyPayment = (monthlyPaymentText as NSString).floatValue
        validate(textfield: monthlyPaymentTextField, text: monthlyPaymentText)
        if(filledTextFieldsList.count == 4){
            calculate()
        }
        display()
        saveUserEnteredData()
    }
    
    // --------- Future value textfield value change function -----------
    
    @IBAction func futureValueAction(_ sender: Any) {
        if(resultDisplayedTextfield != nil){
            resultDisplayedTextfield.text = ""
            resultDisplayedTextfield.backgroundColor = UIColor.secondaryLabel
            resultDisplayedTextfield = nil
        }
        lastUpdatedTextField = futureValueTextField
        futureValueText = futureValueTextField.text!
        futureValue = (futureValueText as NSString).floatValue
        validate(textfield: futureValueTextField, text: futureValueText)
        if(filledTextFieldsList.count == 4){
            calculate()
        }
        display()
        saveUserEnteredData()
    }
    
    // --------- Number of payments textfield value change function -----------
    
    @IBAction func numberOfPayments(_ sender: Any) {
        if(resultDisplayedTextfield != nil){
            resultDisplayedTextfield.text = ""
            resultDisplayedTextfield.backgroundColor = UIColor.secondaryLabel
            resultDisplayedTextfield = nil
        }
        lastUpdatedTextField = numberOfPaymentsTextField
        numberOfPaymentsText = numberOfPaymentsTextField.text!
        numberOfPayments = (numberOfPaymentsText as NSString).floatValue
        validate(textfield: numberOfPaymentsTextField, text: numberOfPaymentsText)
        if(filledTextFieldsList.count == 4){
            calculate()
        }
        display()
        saveUserEnteredData()
    }
    
    //---------------- Display result in UI ------------------

    func display() -> Void{
        for listIndex in (0...(allTextFieldsList.count-1)){
            if(filledTextFieldsList.contains(allTextFieldsList[listIndex])){
                print()
            }
            else{
                if((allTextFieldsList[listIndex] != lastUpdatedTextField) && ((filledTextFieldsList.count) == 4)){
                    allTextFieldsList[listIndex].text = String(result)
                    allTextFieldsList[listIndex].backgroundColor = UIColor.systemBlue
                    resultDisplayedTextfield = allTextFieldsList[listIndex]
                }
                break
            }
        }
    }
    
    //------------- Function for textfield validation -------------
    
    func validate(textfield:UITextField, text:String) -> Void{
        if(text.isEmpty){
            if let index = filledTextFieldsList.firstIndex(of: textfield) {
                filledTextFieldsList.remove(at: index)
                allTextFieldsList.append(textfield)
            }
        }
        else{
            if(filledTextFieldsList.contains(textfield)){
                print()
            }
            else{
                if(filledTextFieldsList.count < 4){
                    filledTextFieldsList.append(textfield)
                    if let index = allTextFieldsList.firstIndex(of: textfield) {
                        allTextFieldsList.remove(at: index)
                    }
                }
            }
        }
    }
    
    //-------------- Function for financial calculation --------------
    
    func calculate() -> Void{
        
        financialCalculationsObj = FinancialCalculations(principal: principalAmount, loan: 0.0, interest: interestRate, monthlyPay: monthlyPayment, futureVal: futureValue, paymentCount: numberOfPayments)
        
        if(allTextFieldsList[0] == principalAmountTextField){
            result = Float((financialCalculationsObj?.compoundSavingsPrincipalAmountCalculation())!) 
        }
        else if(allTextFieldsList[0] == interestRateTextField){
            result = Float((financialCalculationsObj?.compoundSavingsInterestRateCalculation())!)
        }
        else if(allTextFieldsList[0] == monthlyPaymentTextField){
            result = Float((financialCalculationsObj?.compoundSavingsMonthlyPaymentCalculation())!)
        }
        else if(allTextFieldsList[0] == futureValueTextField){
            result = Float((financialCalculationsObj?.compoundSavingsFutureValueCalculation())!)
        }
        else if(allTextFieldsList[0] == numberOfPaymentsTextField){
            result = Float((financialCalculationsObj?.compoundSavingsNumberOfPaymentsCalculation())!)
        }
        else{
            print()
        }
    }

    //-------------- Test function for financial calculation --------------
    
    func ccalculate() -> Float{
        if(allTextFieldsList[0] == principalAmountTextField){
            let total: Float = interestRate + monthlyPayment + futureValue + numberOfPayments
            result = total
            return  total
        }
        else if(allTextFieldsList[0] == interestRateTextField){
            let total: Float = principalAmount + monthlyPayment + futureValue + numberOfPayments
            result = total
            return total
        }
        else if(allTextFieldsList[0] == monthlyPaymentTextField){
            let total: Float = principalAmount + interestRate + futureValue + numberOfPayments
            result = total
            return total
        }
        else if(allTextFieldsList[0] == futureValueTextField){
            let total: Float = principalAmount + interestRate + monthlyPayment + numberOfPayments
            result = total
            return total
        }
        else if(allTextFieldsList[0] == numberOfPaymentsTextField){
            let total: Float = principalAmount + interestRate + monthlyPayment + futureValue
            result = total
            return total
        }
        else{
            return 0.0
        }
    }
}
