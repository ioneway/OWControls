//
//  ViewController.swift
//  Password-keyboard
//
//  Created by weiwang on 16/3/27.
//  Copyright © 2016年 王伟. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OWKeyBoardViewDelegate{

    var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField = UITextField(frame: CGRect(x: 100, y: 100, width: 300, height: 56));
        textField.backgroundColor = UIColor.redColor();
        textField.center = self.view.center;
        self.view .addSubview(textField);
        
        let keyboard = OWKeyBoardView(textField: self.textField);
        textField.inputView = keyboard;
        keyboard.delegate = self;
    }

    func keyboard(keyboard:OWKeyBoardView, didClickNumKey button: UIButton){
        
    }
    
    func keyboard(keyboard:OWKeyBoardView, didClickDownKey button: UIButton){
        
        
    }
    
    func keyboard(keyboard:OWKeyBoardView, didClickDeleteKey button: UIButton){

    }
    
    func keyboard(keyboard:OWKeyBoardView, didClickSureKey button: UIButton){
        
    }

}

