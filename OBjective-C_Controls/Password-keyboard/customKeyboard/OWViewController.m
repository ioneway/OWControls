//
//  OWViewController.m
//  customKeyboard
//
//  Created by weiwang on 16/3/24.
//  Copyright (c) 2015年 王伟. All rights reserved.
//

#import "OWViewController.h"
#import "OWKeyboardView.h"

@interface OWViewController () <UITextFieldDelegate, OWKeyboardViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) OWKeyboardView *keyboard;

@property (nonatomic, strong) NSMutableString *passWord;

@end

@implementation OWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat x = 0;
    CGFloat y = self.view.height - 216;
    CGFloat w = self.view.width;
    CGFloat h = 216;
    self.keyboard = [[OWKeyboardView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.keyboard.delegate = self;
    
    self.textField.inputView = _keyboard;
  
    self.textField.delegate = self;
}

- (IBAction)click:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
}

/***************需要*************/
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    self.textField.text = nil;
//    self.passWord = nil;
//    
//    CGFloat x = 0;
//    CGFloat y = self.view.height - 216;
//    CGFloat w = self.view.width;
//    CGFloat h = 216;
//    self.keyboard = [[LVKeyboardView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    self.keyboard.delegate = self;
//    
//    self.textField.inputView = _keyboard;
//    
//    return YES;
//}

#pragma mark - LVKeyboardDelegate
- (void)keyboard:(OWKeyboardView *)keyboard didClickButton:(UIButton *)button {
    
    if (self.passWord.length > 5) return;
    [self.passWord appendString:button.currentTitle];
    
    self.textField.text = self.passWord;
    NSLog(@"%@", self.textField.text);
}

- (void)keyboard:(OWKeyboardView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn {
    NSLog(@"删除");
    NSUInteger loc = self.passWord.length;
    if (loc == 0)   return;
    NSRange range = NSMakeRange(loc - 1, 1);
    [self.passWord deleteCharactersInRange:range];
    self.textField.text = self.passWord;
    NSLog(@"%@", self.textField.text);
}

#pragma mark - 需要
- (NSMutableString *)passWord {
    if (!_passWord) {
        _passWord = [NSMutableString stringWithCapacity:6];
    }
    return _passWord;
}





@end
