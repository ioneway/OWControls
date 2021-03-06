//
//  UIView+Utils.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/27.
//  Copyright © 2016年 王伟. All rights reserved.
//

import UIKit

extension UIView {
    var x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var frame: CGRect = self.frame;
            frame.origin.x = newValue;
            self.frame = frame;
        }
    }
    
    var y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var frame: CGRect = self.frame;
            frame.origin.y = newValue;
            self.frame = frame;
        }
    }
    
    var centerX: CGFloat {
        get{
            return self.center.x;
        }
        set{
            var center: CGPoint = self.center;
            center.x = newValue;
            self.center = center;
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y;
        }
        set {
            var center: CGPoint = self.center;
            center.y = newValue;
            self.center = center;
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width;
        }
        set {
            var frame: CGRect = self.frame;
            frame.size.width = newValue;
            self.frame = frame;
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height;
        }
        set {
            var frame: CGRect = self.frame;
            frame.size.height = newValue;
            self.frame = frame;
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size;
        }
        set {
            self.frame.size = newValue;
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin;
        }
        set {
            self.origin = newValue;
        }
    }

}