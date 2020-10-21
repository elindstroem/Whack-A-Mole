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
    var numMoles = 0
    var endGameReport = UIButton()
    var theDiameter = 0
    var ended = false
    var theTime = 0.0
    var messageBox = UILabel()
    var missed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let screenBounds: CGRect = UIScreen.main.bounds
        screenWidth = Int(screenBounds.width)
        screenHeight = Int(screenBounds.height)
        
        //scoreBox
        scoreBox.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight/10)
        scoreBox.text = "Score: \(score)"
        
        view.addSubview(scoreBox)
        
        //grass background
        grass.frame = CGRect(x: 20, y: screenHeight / 10 + 20, width: screenWidth - 40, height: screenHeight - (screenHeight / 10) - 40)
        grass.backgroundColor = .green
        
        view.addSubview(grass)
        
        //first mole
        mole.frame = CGRect(x: screenWidth / 2, y: screenHeight / 2, width: 40, height: 40)
        mole.layer.cornerRadius = 20
        theDiameter = 40
        switch theDiameter {
            case 10...20:
                mole.backgroundColor = .red
            case 21...30:
                mole.backgroundColor = .orange
            case 31...40:
                mole.backgroundColor = .yellow
            default:
                mole.backgroundColor = .blue
        }
        mole.addTarget(self, action: #selector(whacked(_:)), for: .touchUpInside)
        
        view.addSubview(mole)
        
        //missed mole messageBox
        messageBox.frame = CGRect(x: screenWidth / 2, y: 20, width: screenWidth / 2 - 20, height: screenHeight / 10)
        
        view.addSubview(messageBox)
        
        self.view = view
        
        //set countdown for mole
        theTime = Double.random(in: 2.0...5.0)
        timer = Timer.scheduledTimer(timeInterval: theTime, target: self, selector: #selector(makeNewButton), userInfo: nil, repeats: true)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenBounds: CGRect = UIScreen.main.bounds
        screenWidth = Int(screenBounds.width)
        screenHeight = Int(screenBounds.height)
        
        //scoreBox
        scoreBox.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight/10)
        scoreBox.text = "Score: \(score)"
        
        //grass background
        grass.frame = CGRect(x: 20, y: screenHeight / 10 + 20, width: screenWidth - 40, height: screenHeight - (screenHeight / 10) - 40)
        grass.backgroundColor = .green
        
        if ended {
            endGameReport.frame = CGRect(x: 20, y: screenHeight / 10 + 20, width: screenWidth - 40, height: screenHeight - (screenHeight / 10) - 40)
        }
    }
    
    @objc func makeNewButton() {
        mole.removeFromSuperview()
        
        if missed {
            if score % 2 == 0 {
                messageBox.text = "uh oh"
            } else {
                messageBox.text = "yikes"
            }
        } else {
            if score % 2 == 0 {
                messageBox.text = "nice"
            } else {
                messageBox.text = "coolio"
            }
        }
        
        if numMoles >= 10 {
            endGame()
        } else {
            
            //new button
            let diameter = Int.random(in: 10...50)
            let maxXRight = (screenWidth - 20) - diameter
            let maxYBottom = (screenHeight - 20) - diameter
            let randomX = Int.random(in: 20...maxXRight)
            let randomY = Int.random(in: (screenHeight / 10 + 20)...maxYBottom)
        
            mole.frame = CGRect(x: randomX, y: randomY, width: diameter, height: diameter)
            mole.layer.cornerRadius = CGFloat(diameter / 2)
            numMoles += 1
            theDiameter = diameter
            switch theDiameter {
            case 10...20:
                mole.backgroundColor = .red
            case 21...30:
                mole.backgroundColor = .orange
            case 31...40:
                mole.backgroundColor = .yellow
            default:
                mole.backgroundColor = .blue
            }
            timer.invalidate()
            theTime = Double.random(in: 2.0...5.0)
            timer = Timer.scheduledTimer(timeInterval: theTime, target: self, selector: #selector(makeNewButton), userInfo: nil, repeats: true)
            view.addSubview(mole)
        }
        missed = true
    }
    
    @objc func whacked(_ sender:UIButton!) {
        missed = false
        
        switch theDiameter {
        case 10...20:
            score += 4
        case 21...30:
            score += 3
        case 31...40:
            score += 2
        default:
            score += 1
        }
        
        switch theTime {
        case 2.0...3.0:
            score += 3
        case 3.1...4.0:
            score += 2
        default:
            score += 1
        }
        
        makeNewButton()
        
        scoreBox.text = "Score: \(score)"
    }
    
    @objc func endGame() {//puts the button thing
        ended = true
        messageBox.text = ""
        numMoles = 0
        timer.invalidate()
        scoreBox.removeFromSuperview()
        
        //the button to click that makes the game start over
        endGameReport.frame = CGRect(x: 20, y: screenHeight / 10 + 20, width: screenWidth - 40, height: screenHeight - (screenHeight / 10) - 40)
        endGameReport.addTarget(self, action: #selector(startOver(_:)), for: .touchUpInside)
        endGameReport.setTitleColor(.black, for: .normal)
        endGameReport.setTitle("Score: \(score)", for: .normal)
        view.addSubview(endGameReport)
        
        self.view = view
    }
    
    @objc func startOver(_ sender:UIButton!) {//sets game up to how it was
        endGameReport.removeFromSuperview()
        endGameReport.frame = CGRect(x: screenWidth, y: 0, width: 1, height: 1)
        view.addSubview(endGameReport)
        view.addSubview(scoreBox)
        self.view = view
        
        scoreBox.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight/10)
        score = 0
        
        ended = false
        game()
    }
    
    @objc func game() {//initializing code to set game up again
        //scoreBox
        scoreBox.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight/10)
        scoreBox.textAlignment = NSTextAlignment.left
        scoreBox.text = "Score: \(score)"
        
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
        theTime = Double.random(in: 2.0...5.0)
        timer = Timer.scheduledTimer(timeInterval: theTime, target: self, selector: #selector(makeNewButton), userInfo: nil, repeats: true)
    }

}

