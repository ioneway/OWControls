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
        let btn: UIButton = self.normalButton("down.png", action: "downBtnClick:");
        return btn;
    }();
    
    lazy var  sureBtn: UIButton = {
        let btn: UIButton = self.normalButton("", action: "sureBtnClick:");
        btn.backgroundColor = UIColor(red: 81.0/255.0, green:  81.0/255.0, blue:  81.0/255.0, alpha: 1.0);
        return btn;
    }();
    
    var btnKeys = Array<UIButton>();
    
    var delegate: OWKeyBoardViewDelegate?;
    
    internal init(){
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 216.0));
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
        let numKeyW: CGFloat = self.width / 4.0;
        let numKeyH: CGFloat = self.height / 4.0;
        
        self.deleteBtn.x = self.width - numKeyW;
        self.deleteBtn.y = 0;
        self.deleteBtn.size = CGSize(width: numKeyW * 2, height: numKeyH * 2);
        
        self.sureBtn.frame = self.deleteBtn.frame;
        self.sureBtn.y = self.deleteBtn.height + colMargin;
        
        self.downBtn.x = numKeyW * 2 + colMargin;
        self.downBtn.y = numKeyH * 3 + rowMargin;
        self.downBtn.size = CGSize(width: numKeyW, height: numKeyH);
        let randomNums = self.generateRandomNumbers();
        for i in 0..<self.btnKeys.count {
            let btn = self.btnKeys[i]
            btn.size = CGSize(width: numKeyW, height: numKeyH);
            if i == 0 {
                btn.x = numKeyW + colMargin;
                btn.y = numKeyH + rowMargin;
                btn.setTitle(String(randomNums[i]), forState: UIControlState.Normal);
            }else{
                let col = i%3;
                let row = i/3;
                btn.x = (numKeyW + colMargin) * CGFloat(col);
                btn.y = (numKeyH + rowMargin) * CGFloat(row);
            }
        }
    }
    
    
    
    func generateRandomNumbers()-> Array<UInt8>{
        var array = Array<UInt8>();
        
        for var i in 0..<10 {
            var j: UInt8 = 0;
            arc4random_addrandom(&j, 10);
            if array.contains(j) {
                 i = i-1; continue;
            }
            array.append(j);
        }
        
        return array;
    }
    
    func generateNumberKeys(){
        for i in 0..<10 {
            let btn: UIButton = self.normalButton("", action: "numberKeyClick:");
            btn .setTitle("", forState: .Normal);
            btn.titleLabel?.font = UIFont.systemFontOfSize(27);
            self .addSubview(btn);
            self.btnKeys[i] = btn;
        }
    }
    
    func normalButton(imageName:String, action: Selector) ->UIButton {
        let btn: UIButton = UIButton();
        btn.backgroundColor = UIColor.whiteColor();
        btn.setImage(UIImage(named: imageName), forState:UIControlState.Normal);
        btn .addTarget(self, action: action, forControlEvents: .TouchUpInside);
        return btn;
    }
    
    func numberKeyClick(sender: UIButton){
        if let delegate = self.delegate {
            delegate.keyboard(self, didClickNumKey: sender);
        }
    }
    
    func sureBtnClick(sender: UIButton){
        if let delegate = self.delegate {
            delegate.keyboard(self, didClickSureKey: sender);
        }
    }
    
    func deleteBtnClick(sender: UIButton){
        if let delegate = self.delegate {
            delegate.keyboard(self, didClickDeleteKey: sender);
        }
    }
    
    func downBtnClick(sender: UIButton){
        if let delegate = self.delegate {
            delegate.keyboard(self, didClickDownKey: sender);
        }
    }
}
