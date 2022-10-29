//
//  ViewController.swift
//  CW01
//
//  Created by user214394 on 3/15/22.

// Author details
    // --- M.R.T.T Bandara
    // --- 2019356 / W1761298

// Code references
    // --- https://cocoacasts.com/ud-4-how-to-store-a-dictionary-in-user-defaults-in-swift
    // --- https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
    // --- https://stackoverflow.com/questions/36028493/add-a-scrollview-to-existing-view

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var homePageScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // --- Set scroll view dimensions ---
        homePageScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    }
}
