//
//  ViewController.swift
//  Retrocalc
//
//  Created by Chima onyekwere on 8/13/17.
//  Copyright © 2017 Chima onyekwere. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
 
    @IBOutlet weak var outputLbl: UILabel!
   
    @IBOutlet weak var clearBtn: UIButton!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    
    enum Operation: String {
    case Divide = "/"
    case Add = "+"
    case Multiply = "*"
    case Subtract = "-"
    case Empty = "Empty"
    case Clear = "0"
        
        
    }
    
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var zero = "\(0)"
    var result = ""
    
    
    override func viewDidLoad() {

        
        
        super.viewDidLoad()
       
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            
            print(err.debugDescription)
            
            
        
        }
        
          outputLbl.text = "0"
        
        clearBtn.isHidden = true


    }
    @IBAction func numberPressed(sender: UIButton)
    { playSound()
        
     
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func dividePressed(sender:  AnyObject)
    { playSound()
        processOp(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(sender:  AnyObject)
    { playSound()
          processOp(operation: .Multiply)
    }
    
    @IBAction func subtractPressed(sender:  AnyObject)
    { playSound()
          processOp(operation: .Subtract)
    }
    
    @IBAction func addPressed(sender:  AnyObject)
    { playSound()
          processOp(operation: .Add)
    }
    
    
    
    @IBAction func equalPressed(sender:  AnyObject)
    { playSound()
        processOp(operation: currentOperation)
        
         clearBtn.isHidden = false
    }
    
    @IBAction func acPressed(sender:  AnyObject)
    { playSound()
        
        
        runningNumber.removeAll()
        outputLbl.text = "0"
           currentOperation = Operation.Empty
    }

    
    func playSound() {
        if btnSound.isPlaying {
        btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOp(operation: Operation) {
        
        if currentOperation != Operation.Empty {
        //A user double clicked an operator
            
            if runningNumber != ""{
                //if not empty
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    
                }
                  else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                }
                  else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    
                }
                else if currentOperation == Operation.Clear{
                    result = "\(Double(zero)!)"
                    
                }

                
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        
        }
        
        else {
        //First time an operator has been pressed
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        
        
        }
        
    }
}

