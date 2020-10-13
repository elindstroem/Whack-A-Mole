//
//  ViewController.swift
//  WhackAMole
//
//  Created by Lindstrom, Ella on 10/13/20.
//  Copyright © 2020 Lindstrom, Ella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var screenWidth = 0
    var screenHeight = 0
    var grass = UILabel()
    var scoreBox = UILabel()
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let screenBounds: CGRect = UIScreen.main.bounds
        screenWidth = Int(screenBounds.width)
        screenHeight = Int(screenBounds.height)
        
        //scoreBox
        scoreBox.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight/10)
        scoreBox.text = String(score)
        
        view.addSubview(scoreBox)
        
        //grass background
        grass.frame = CGRect(x: 20, y: screenHeight / 10 + 20, width: screenWidth - 40, height: screenHeight - (screenHeight / 10) - 40)
        grass.backgroundColor = .green
        
        view.addSubview(grass)
        
        self.view = view
    }


}

