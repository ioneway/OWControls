//
//  OWKeyBoardView.swift
//  Password-keyboard
//
//  Created by weiwang on 16/3/27.
//  Copyright © 2016年 王伟. All rights reserved.
//

import UIKit

protocol OWKeyBoardViewDelegate {

     func keyboard(keyboard:OWKeyBoardView, didClickNumKey button: UIButton);
     func keyboard(keyboard:OWKeyBoardView, didClickDownKey button: UIButton);
     func keyboard(keyboard:OWKeyBoardView, didClickDeleteKey button: UIButton);
     func keyboard(keyboard:OWKeyBoardView, didClickSureKey button: UIButton);
}

class OWKeyBoardView: UIView {

  lazy var  deleteBtn: UIButton = {
    let btn: UIButton = self.normalButton("delete.png", action: "deleteBtnClick:");
    return btn;
    }();
    
    lazy var  downBtn: UIButton = {
        let btn: UIButton = self.normalButton("resign.png", action: "downBtnClick:");
        return btn;
    }();
    
    lazy var  sureBtn: UIButton = {
        let btn: UIButton = self.normalButton("", action: "sureBtnClick:");
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal);
        btn.setTitle("确定", forState: .Normal);
        btn.titleLabel?.font = UIFont.systemFontOfSize(25);
        btn.setTitleColor(UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha: 0.7), forState: .Normal);
        btn.backgroundColor = UIColor(red:69.0/255.0, green:181.0/255.0, blue:251.0/255.0, alpha: 1.0);
        return btn;
    }();
    
    var btnKeys = Array<UIButton>();
    var textField: UITextField?;
    var delegate: OWKeyBoardViewDelegate?;
    
    internal init(textField:UITextField?){
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: UIApplication.screenWidth, height: 216.0));
        self.textField = textField;
        self.backgroundColor = UIColor.lightGrayColor();
        self.addSubview(self.deleteBtn);
        self.addSubview(self.downBtn);
        self.addSubview(self.sureBtn);
        self.generateNumberKeys();
        
        self.layoutKeys();
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layoutKeys(){
        let colMargin: CGFloat = 0.5;
        let rowMargin: CGFloat = 0.5;
        let numKeyW: CGFloat = (self.width - rowMargin*4.0) / 4.0 ;
        let numKeyH: CGFloat = (self.height - colMargin*3.0) / 4.0;
        
        self.deleteBtn.x = numKeyW*3+colMargin*3;
        self.deleteBtn.y = rowMargin;
        self.deleteBtn.size = CGSize(width: numKeyW, height: numKeyH * 2);
        
        self.sureBtn.frame = self.deleteBtn.frame;
        self.sureBtn.y = self.deleteBtn.height + rowMargin*2.0;
        
        self.downBtn.x = numKeyW * 2.0 + colMargin*2.0;
        self.downBtn.y = numKeyH * 3.0 + rowMargin*4.0;
        self.downBtn.size = CGSize(width: numKeyW, height: numKeyH);
        
        let btn = self.normalButton("", action: "");
        btn.x = 0;
        btn.y = numKeyH*3.0 + colMargin*4.0;
        btn.size = CGSize(width: numKeyW, height: numKeyH);
        self.addSubview(btn);
        
        let randomNums = self.generateRandomNumbers();
        
        for i in 0..<self.btnKeys.count {
            let btn = self.btnKeys[i]
            btn.size = CGSize(width: numKeyW, height: numKeyH);
            btn.setTitle(String(randomNums[i]), forState: .Normal);
            if i == 9 {
                btn.x = numKeyW + colMargin;
                btn.y = numKeyH*3.0 + rowMargin*4.0;
            }else{
                let col = i%3;
                let row = i/3;
                btn.x = (numKeyW + colMargin) * CGFloat(col);
                btn.y = (numKeyH + rowMargin) * CGFloat(row) + rowMargin;
            }
        }
        

    }
    
    func generateRandomNumbers()-> Array<UInt32>{
        var array = Array<UInt32>();
        
        for (var i=0; i<10; i++){
            let j: UInt32 = arc4random_uniform(10)
            
            if array.contains(j) {
                 i = i-1; continue;
            }
            array.append(j);
        }
        
        return array;
    }
    
    func generateNumberKeys(){
        for _ in 0..<10 {
            let btn: UIButton = self.normalButton("", action: "numberKeyClick:");
            btn .setTitle("", forState: .Normal);
            btn.titleLabel?.font = UIFont.systemFontOfSize(27);
            self .addSubview(btn);
            self.btnKeys.append(btn);
        }
    }
    
    func normalButton(imageName:String, action: Selector) ->UIButton {
        let btn: UIButton = UIButton();
        btn.backgroundColor = UIColor.whiteColor();
        btn.setImage(UIImage(named: imageName), forState:UIControlState.Normal);
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal);
        btn .addTarget(self, action: action, forControlEvents: .TouchUpInside);
        
        return btn;
    }
    
    func numberKeyClick(sender: UIButton){
        self.textField?.text?.appendContentsOf((sender.titleLabel?.text!)!);
        if let delegate = self.delegate {
            delegate.keyboard(self, didClickNumKey: sender);
        }
    }
    
    func sureBtnClick(sender: UIButton){
        self.textField?.resignFirstResponder()
        if let delegate = self.delegate {
            delegate.keyboard(self, didClickSureKey: sender);
        }
    }
    
    func deleteBtnClick(sender: UIButton){
        if self.textField?.text != ""{
            self.textField?.text?.removeAtIndex((self.textField?.text?.endIndex.predecessor())!);
        }
        if let delegate = self.delegate {
            delegate.keyboard(self, didClickDeleteKey: sender);
        }
    }
    
    func downBtnClick(sender: UIButton){
        self.textField?.resignFirstResponder();
        if let delegate = self.delegate {
            delegate.keyboard(self, didClickDownKey: sender);
        }
    }
}
