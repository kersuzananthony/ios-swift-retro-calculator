//
//  ViewController.swift
//  calculator
//
//  Created by Kersuzan on 18/10/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operator: String {
        case Add = "+"
        case Substract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = ""
    }
    
    var sounds: AVAudioPlayer = AVAudioPlayer()
    
    var numberToDisplay: String = ""
    var leftNumber: String = ""
    var rightNumber: String = ""
    var currentOperator: Operator = Operator.Empty
    var result: String = ""
    
    
    @IBOutlet var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let soundPath = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundPathUrl = NSURL(fileURLWithPath: soundPath!)
        
        do {
            try sounds = AVAudioPlayer(contentsOfURL: soundPathUrl)
            sounds.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func playSound() {
        if sounds.playing {
            sounds.stop()
        }
        
        sounds.play()
    }
    
    func processCalcul(op : Operator) {
        playSound()
        
        print("Left number \(leftNumber)")
        print("Right number \(rightNumber)")
        print("Writtent \(numberToDisplay)")
        print("OP \(currentOperator)")
        
        if currentOperator != Operator.Empty {
            if numberToDisplay != "" {
                rightNumber = numberToDisplay
                numberToDisplay = ""
                
                switch currentOperator {
                case Operator.Add:
                    result = "\(Double(leftNumber)! + Double(rightNumber)!)"
                    break
                case Operator.Substract:
                    result = "\(Double(leftNumber)! - Double(rightNumber)!)"
                    break
                case Operator.Multiply:
                    result = "\(Double(leftNumber)! * Double(rightNumber)!)"
                    break
                case Operator.Divide:
                    result = "\(Double(leftNumber)! / Double(rightNumber)!)"
                    break
                default:
                    break
                }
                
                leftNumber = result
                outputLabel.text = result
            }
            
            currentOperator = op
        } else {
            // First operator
            if numberToDisplay != "" {
                leftNumber = numberToDisplay
                numberToDisplay = ""
                currentOperator = op
            }
            
        }
    }

    @IBAction func onNumberPressed(sender: UIButton) {
        playSound()
        numberToDisplay += "\(sender.tag)"
        outputLabel.text = numberToDisplay
    }
    
    
    @IBAction func onAddPressed(sender: UIButton) {
        processCalcul(Operator.Add)
    }

    @IBAction func onSubstractPressed(sender: UIButton) {
        processCalcul(Operator.Substract)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processCalcul(Operator.Multiply)
    }
    
    @IBAction func onDividePressed(sender: UIButton) {
        processCalcul(Operator.Divide)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processCalcul(currentOperator)
    }
    
    @IBAction func onClearPressed(sender: UIButton) {
        playSound()
        numberToDisplay = ""
        leftNumber = ""
        rightNumber = ""
        result = ""
        currentOperator = Operator.Empty
        outputLabel.text = "0"
        
    }
}

