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
    var mole = UIButton()
    var timer = Timer()
    
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
        
        //first mole
        mole.frame = CGRect(x: screenWidth / 2, y: screenHeight / 2, width: 40, height: 40)
        mole.layer.cornerRadius = 20
        mole.backgroundColor = .brown
        mole.addTarget(self, action: #selector(whacked(_:)), for: .touchUpInside)
        
        view.addSubview(mole)
        
        self.view = view
        
        //set countdown for mole
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerWentOff), userInfo: nil, repeats: true)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenBounds: CGRect = UIScreen.main.bounds
        screenWidth = Int(screenBounds.width)
        screenHeight = Int(screenBounds.height)
        
        //scoreBox
        scoreBox.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight/10)
        scoreBox.text = String(score)
        
        //grass background
        grass.frame = CGRect(x: 20, y: screenHeight / 10 + 20, width: screenWidth - 40, height: screenHeight - (screenHeight / 10) - 40)
        grass.backgroundColor = .green
    }
    
    @objc func makeNewButton(diameter: Int) {
        mole.removeFromSuperview()
        
        
        //new button
        let randomDiameter = Int.random(in: 10...50)
        let maxXRight = (screenWidth - 20) - randomDiameter
        let maxYBottom = (screenHeight - 20) - randomDiameter
        let randomX = Int.random(in: 20...maxXRight)
        let randomY = Int.random(in: (screenHeight / 10 + 20)...maxYBottom)
        
        mole.frame = CGRect(x: randomX, y: randomY, width: randomDiameter, height: randomDiameter)
        mole.layer.cornerRadius = CGFloat(randomDiameter / 2)
        view.addSubview(mole)
    }
    
    @objc func whacked(_ sender:UIButton!) {
        let randomDiameter = Int.random(in: 10...50)
        makeNewButton(diameter: randomDiameter)
        
        switch randomDiameter {
        case 10...20:
            score += 4
        case 21...30:
            score += 3
        case 31...40:
            score += 2
        default:
            score += 1
        }
        
        scoreBox.text = String(score)
    }
    @objc func timerWentOff() {
        makeNewButton(diameter: Int.random(in: 10...50))
    }

}

