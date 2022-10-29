//
//  SimpleSavingsViewController.swift
//  CW01
//
//  Created by user214394 on 4/9/22.

// Author details
    // --- M.R.T.T Bandara
    // --- 2019356 / W1761298

// Code references
    // --- https://cocoacasts.com/ud-4-how-to-store-a-dictionary-in-user-defaults-in-swift
    // --- https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
    // --- https://stackoverflow.com/questions/36028493/add-a-scrollview-to-existing-view

import UIKit

class SimpleSavingsViewController: UIViewController {

    @IBOutlet weak var simpleSavingsPageScrollView: UIScrollView!
    @IBOutlet weak var principalAmountTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var futureValueTextField: UITextField!
    @IBOutlet weak var numberOfPaymentsTextField: UITextField!
    
    var principalAmountText: String = ""
    var interestRateText: String = ""
    var futureValueText: String = ""
    var numberOfPaymentsText: String = ""
    
    var principalAmount: Float = 0
    var interestRate: Float = 0
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
        simpleSavingsPageScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        
        financialCalculationsObj = FinancialCalculations(principal: 0.0, loan: 0.0, interest: 0.0, monthlyPay: 0.0, futureVal: 0.0, paymentCount: 0.0)
        
        allTextFieldsList.append(contentsOf: [principalAmountTextField, interestRateTextField, futureValueTextField, numberOfPaymentsTextField])
        
        loadUserEnteredData()
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        // --- Refresh textfields ---
        principalAmountTextField.text = ""
        interestRateTextField.text = ""
        futureValueTextField.text = ""
        numberOfPaymentsTextField.text = ""
        
        // --- Refresh array elements ---
        allTextFieldsList.removeAll()
        allTextFieldsList.append(contentsOf: [principalAmountTextField, interestRateTextField, futureValueTextField, numberOfPaymentsTextField])
        filledTextFieldsList.removeAll()
        
        if(resultDisplayedTextfield != nil){
            resultDisplayedTextfield.backgroundColor = UIColor.secondaryLabel
        }
        
        // --- Save user entered data ---
        saveUserEnteredData()
        
        // --- Display an alert ---
        let alert = UIAlertController(title: "Simple Savings", message: "Your inputs have been refreshed!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveUserEnteredData() -> Void {
        let defaults = UserDefaults.standard
        let userEnteredData = [
            "principalAmount": principalAmountTextField.text,
            "interestRate": interestRateTextField.text,
            "futureValue": futureValueTextField.text,
            "numberOfPayments": numberOfPaymentsTextField.text
        ]
        defaults.set(userEnteredData, forKey: "simpleSavingsUserInput")
    }
    
    func loadUserEnteredData() -> Void {
        let defaults = UserDefaults.standard
        let previousEnteredValues: [String: String] = defaults.object(forKey: "simpleSavingsUserInput") as? [String:String] ?? [:]
        principalAmountTextField.text = previousEnteredValues["principalAmount"]
        interestRateTextField.text = previousEnteredValues["interestRate"]
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
        if(filledTextFieldsList.count == 3){
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
        print(filledTextFieldsList.count)
        lastUpdatedTextField = interestRateTextField
        interestRateText = interestRateTextField.text!
        interestRate = (interestRateText as NSString).floatValue
        validate(textfield: interestRateTextField, text: interestRateText)
        if(filledTextFieldsList.count == 3){
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
        if(filledTextFieldsList.count == 3){
            calculate()
        }
        display()
        saveUserEnteredData()
    }
    
    // --------- Number of payments textfield value change function -----------
    
    @IBAction func numberOfPaymentsAction(_ sender: Any) {
        if(resultDisplayedTextfield != nil){
            resultDisplayedTextfield.text = ""
            resultDisplayedTextfield.backgroundColor = UIColor.secondaryLabel
            resultDisplayedTextfield = nil
        }
        lastUpdatedTextField = numberOfPaymentsTextField
        numberOfPaymentsText = numberOfPaymentsTextField.text!
        numberOfPayments = (numberOfPaymentsText as NSString).floatValue
        validate(textfield: numberOfPaymentsTextField, text: numberOfPaymentsText)
        if(filledTextFieldsList.count == 3){
            calculate()
        }
        display()
        saveUserEnteredData()
    }
    
    //---------------- Display result in UI ------------------

    func display() -> Void{
        for listIndex in (0...(allTextFieldsList.count-1)){
            if(filledTextFieldsList.contains(allTextFieldsList[listIndex])){
                print("")
            }
            else{
                if((allTextFieldsList[listIndex] != lastUpdatedTextField) && ((filledTextFieldsList.count) == 3)){
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
                print("")
            }
            else{
                if(filledTextFieldsList.count < 3){
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
        
        financialCalculationsObj = FinancialCalculations(principal: principalAmount, loan: 0.0, interest: interestRate, monthlyPay: 0.0, futureVal: futureValue, paymentCount: numberOfPayments)
        
        if(allTextFieldsList[0] == principalAmountTextField){
            result = Float((financialCalculationsObj?.simpleSavingsPrincipalAmountCalculation())!)
        }
        else if(allTextFieldsList[0] == interestRateTextField){
            result = Float((financialCalculationsObj?.simpleSavingsInterestRateCalculation())!)
        }
        else if(allTextFieldsList[0] == futureValueTextField){
            result = Float((financialCalculationsObj?.simpleSavingsFutureValueCalculation())!)
        }
        else if(allTextFieldsList[0] == numberOfPaymentsTextField){
            result = Float((financialCalculationsObj?.simpleSavingsNumberOfPaymentsCalculation())!)
        }
        else{
            print("")
        }
    }
}
