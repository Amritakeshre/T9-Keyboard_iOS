//
//  ViewController.swift
//  T9KeyboardDemo
//
//  Created by Amrita on 03/03/17.
//  Copyright © 2017 iOSTrainer. All rights reserved.
//

import UIKit
fileprivate let TagOffset = 100
class HomeViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
   
    let a1 = [".",",","!","1"]
    let a2 = ["a","b","c","2"]
    let a3 = ["d","e","f","3"]
    let a4 = ["g","h","i","4"]
    let a5 = ["j","k","l","5"]
    let a6 = ["m","n","o","6"]
    let a7 = ["p","q","r","s","7"]
    let a8 = ["t","u","v","8"]
    let a9 = ["w","x","y","z","9"]
    
    var array:[[String]] = []
    
    var timer : Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        array = [a1, a2, a3, a4, a5, a6, a7, a8, a9]
    }

    @IBAction func handleLongPressGesture(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .ended else{
        return
        }
        guard let view = sender.view else {
            return
        }
        let viewTag = view.tag - TagOffset
        
        if textField.text != nil{
         textField.text = "\(textField.text!)\(viewTag)"
        }else{
            textField.text = textField.text! + ""
        }
        
    }
        
    var chrIndex = 0
    var currentViewTag = 0
    
    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else {return}
        timer?.invalidate(); timer = nil
        
        let viewTag = view.tag - TagOffset
        
        if currentViewTag != viewTag {
            self.chrIndex = 0
        }
        currentViewTag = viewTag
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: viewTag , repeats: false)
        
    }
    
    func tick(){
        if let timer_ = timer { // optional binding. because TIMER IS OPTIONAL.
            let tag = timer_.userInfo as! Int
            write(tag)
        }
    }
    
    func write(_ tag : Int){
        guard (tag >= 0 || tag <= 12)  else {return}

            if tag == 11 {
                self.textField.text = "\(self.textField.text!)*"
                return
            }
        
            if tag == 12 {
                self.textField.text = "\(self.textField.text!)#"
                return
            }
        
            if tag == 0 {
                self.textField.text = "\(self.textField.text!)0"
                return
            }
        
            var charactersArr = self.array[tag-1] //array of possible values for this button
        
            let indexToShow = self.chrIndex % charactersArr.count
            
            self.textField.text = "\(self.textField.text ?? "")\(charactersArr[indexToShow])"
            chrIndex += 1
        }

    @IBAction func btnClear(_ sender: UIButton) {
        textField.text = ""
        chrIndex = 0
        currentViewTag = 0
    }
}



