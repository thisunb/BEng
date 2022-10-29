//
//  LoansMortgageViewController.swift
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

class LoansMortgageViewController: UIViewController {

    @IBOutlet weak var loansMortgagePageScrollView: UIScrollView!
    @IBOutlet weak var loanAmountTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var monthlyPaymentTextField: UITextField!
    @IBOutlet weak var numberOfPaymentsTextField: UITextField!
    
    var loanAmountText: String = ""
    var interestRateText: String = ""
    var monthlyPaymentText: String = ""
    var numberOfPaymentsText: String = ""
    
    var loanAmount: Float = 0
    var interestRate: Float = 0
    var monthlyPayment: Float = 0
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
        loansMortgagePageScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        
        financialCalculationsObj = FinancialCalculations(principal: 0.0, loan: 0.0, interest: 0.0, monthlyPay: 0.0, futureVal: 0.0, paymentCount: 0.0)
        
        allTextFieldsList.append(contentsOf: [loanAmountTextField, interestRateTextField, monthlyPaymentTextField, numberOfPaymentsTextField])
        
        loadUserEnteredData()
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        // --- Refresh textfields ---
        loanAmountTextField.text = ""
        interestRateTextField.text = ""
        monthlyPaymentTextField.text = ""
        numberOfPaymentsTextField.text = ""
        
        // --- Refresh array elements ---
        allTextFieldsList.removeAll()
        allTextFieldsList.append(contentsOf: [loanAmountTextField, interestRateTextField, monthlyPaymentTextField, numberOfPaymentsTextField])
        filledTextFieldsList.removeAll()
        
        if(resultDisplayedTextfield != nil){
            resultDisplayedTextfield.backgroundColor = UIColor.secondaryLabel
        }
        
        // --- Save user entered data ---
        saveUserEnteredData()
        
        // --- Display an alert ---
        let alert = UIAlertController(title: "Loans Mortgage", message: "Your inputs have been refreshed!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveUserEnteredData() -> Void {
        let defaults = UserDefaults.standard
        let userEnteredData = [
            "loanAmount": loanAmountTextField.text,
            "interestRate": interestRateTextField.text,
            "monthlyPayment": monthlyPaymentTextField.text,
            "numberOfPayments": numberOfPaymentsTextField.text
        ]
        defaults.set(userEnteredData, forKey: "loansMortgageUserInput")
    }
    
    func loadUserEnteredData() -> Void {
        let defaults = UserDefaults.standard
        let previousEnteredValues: [String: String] = defaults.object(forKey: "loansMortgageUserInput") as? [String:String] ?? [:]
        loanAmountTextField.text = previousEnteredValues["loanAmount"]
        interestRateTextField.text = previousEnteredValues["interestRate"]
        monthlyPaymentTextField.text = previousEnteredValues["monthlyPayment"]
        numberOfPaymentsTextField.text = previousEnteredValues["numberOfPayments"]
    }
    
    // --------- Loan amount textfield value change function -----------
    
    @IBAction func loanAmountAction(_ sender: Any) {
        if(resultDisplayedTextfield != nil){
            resultDisplayedTextfield.text = ""
            resultDisplayedTextfield.backgroundColor = UIColor.secondaryLabel
            resultDisplayedTextfield = nil
        }
        lastUpdatedTextField = loanAmountTextField
        loanAmountText = loanAmountTextField.text!
        loanAmount = (loanAmountText as NSString).floatValue
        validate(textfield: loanAmountTextField, text: loanAmountText)
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
        
        financialCalculationsObj = FinancialCalculations(principal: 0.0, loan: loanAmount, interest: interestRate, monthlyPay: monthlyPayment, futureVal: 0.0, paymentCount: numberOfPayments)
        
        if(allTextFieldsList[0] == loanAmountTextField){
            result = Float((financialCalculationsObj?.loansMortgageLoanAmountCalculation())!)
        }
        else if(allTextFieldsList[0] == interestRateTextField){
            let alert = UIAlertController(title: "Loans Mortgage", message: "Interest rate calculation is not available!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if(allTextFieldsList[0] == monthlyPaymentTextField){
            result = Float((financialCalculationsObj?.loansMortgageMonthlyPaymentCalculation())!)
        }
        else if(allTextFieldsList[0] == numberOfPaymentsTextField){
            print("ggg")
            result = Float((financialCalculationsObj?.loansMortgageNumberOfPaymentsCalculation())!)
        }
        else{
            print("")
        }
    }
}
