//
//  HelpViewController.swift
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

class HelpViewController: UIViewController {

    @IBOutlet weak var helpPageScrollView: UIScrollView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // --- Set scroll view dimensions ---
        helpPageScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        
        instructionsTextView.text = setInstructions()
    }
    
    func setInstructions() -> String{
        var instructionsText: String
        instructionsText =
        
        "1. Use Compound Savings Page to complete any calculations pertaining to compound savings. This includes calculating the principal amount, interest rate, monthly payment, futures value and number of payments. The calculation will start automatically when 4 of any attributes are filled and the answer pertaining to the unfilled attribute will be displayed highlightning the textbox.\n\n" +
        
        "2. Use Simple Savings Page to complete any calculations pertaining to simple savings. This includes calculating the principal amount, interest rate, future value and number of payments. The calculation will start automatically when 3 of any attributes are filled and the answer pertaining to the unfilled attribute will be displayed highlightning the textbox.\n\n" +
        
        "3. Use Loans Mortgage Page to complete any calculations pertaining to loans mortgage. This includes calculating the loan amount, interest rate, monthly payment and number of payments. The calculation will start automatically when 3 of any attributed are filled and the answer pertaining to the unfilled attribute will be displayed highlightning the textbox\n\n" +
        
        "4. Each page contains a refresh button that will refresh the entered values in the textboxes.\n\n" +
        
        "5. Each page contains a Show Years button to display the number of payments in years."
        
        return instructionsText
    }
    
}
