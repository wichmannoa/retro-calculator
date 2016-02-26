//
//  ViewController.swift
//  retro-calculator
//
//  Created by Otto on 2/26/16.
//  Copyright © 2016 Otto. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
      
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
        try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    @IBAction func onSubstractPress(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber;
    }
    
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            
            if runningNumber != ""{
                rightValString = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Multiply{
                    result = "\(Double(rightValString)! * Double(leftValString)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
            }
            
            leftValString = result;
            outputLbl.text = result;
            
            currentOperation = op;
            
            
            
            
        }else{
            leftValString = runningNumber;
            runningNumber = "";
            currentOperation = op;
        }
    }
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
          btnSound.play()
        
    }


}

