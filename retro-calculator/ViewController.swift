//
//  ViewController.swift
//  retro-calculator
//
//  Created by Jesus Lopez de Nava on 10/15/15.
//  Copyright © 2015 LodenaApps. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Equals = "="
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var operSound: AVAudioPlayer!
    var clearSound: AVAudioPlayer!

    var runningNumber = ""
    var leftVarString = ""
    var rightVarString = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLbl.text = "0.0"
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        let path2 = NSBundle.mainBundle().pathForResource("oper", ofType: "wav")
        let soundUrl2 = NSURL(fileURLWithPath: path2!)
        
        do {
            try operSound = AVAudioPlayer(contentsOfURL: soundUrl2)
            operSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        let path3 = NSBundle.mainBundle().pathForResource("clear", ofType: "wav")
        let soundUrl3 = NSURL(fileURLWithPath: path3!)
        
        do {
            try clearSound = AVAudioPlayer(contentsOfURL: soundUrl3)
            clearSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed (btn: UIButton!) {
        playSound(1)
        if btn.tag == 0 && Double(outputLbl.text!)! == 0.0 {
            runningNumber = "0"
        } else {
            if runningNumber == "0" {
                runningNumber = ""
            }
            runningNumber += "\(btn.tag)"
            outputLbl.text = runningNumber
        }
        
        if currentOperation == Operation.Equals {
            leftVarString = ""
            rightVarString = ""
            currentOperation = Operation.Empty
        }
        
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(Operation.Equals)
    }
    
    @IBAction func onClear(sender: UIButton) {
        playSound(3)
        leftVarString = ""
        rightVarString = ""
        currentOperation = Operation.Empty
        runningNumber = ""
        outputLbl.text = "0.0"
    }
    
    
    func processOperation(op: Operation) {
        playSound(2)
        
        if currentOperation != Operation.Empty {
            //Run some math
            
            if runningNumber != "" {
                rightVarString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVarString)! * Double(rightVarString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVarString)! / Double(rightVarString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftVarString)! + Double(rightVarString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftVarString)! - Double(rightVarString)!)"
                }
                
                leftVarString = result
                outputLbl.text = result
            }
                
            currentOperation = op
            
        } else {
            //This is the first time an operator has been pressed
            if runningNumber != "" {
                leftVarString = runningNumber
                runningNumber = ""
                currentOperation = op
            }
        }
    }
    
    func playSound(typeOfSound: Int) {
        
        switch typeOfSound {
        
        case 1:
            if btnSound.playing {
                btnSound.stop()
            }
            btnSound.play()
            
        case 2:
            if operSound.playing {
                operSound.stop()
            }
            operSound.play()
            
        default:
            if clearSound.playing {
                clearSound.stop()
            }
            clearSound.play()
            
        }
            
    }
        
    
}
