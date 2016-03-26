//
//  LVKeyboardView.h
//  customKeyboard
//
//  Created by PBOC CS on 15/2/26.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"


@class OWKeyboardView;
@protocol OWKeyboardViewDelegate <NSObject>

@optional
/** 点击了数字按钮 */
- (void)keyboard:(OWKeyboardView *)keyboard didClickButton:(UIButton *)button;
/** 点击删除按钮 */
- (void)keyboard:(OWKeyboardView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn;
/** 点击退出键盘按钮 */
- (void)keyboard:(OWKeyboardView *)keyboard didClickDownBtn:(UIButton *)downBtn;
/** 点击确认按钮 */
- (void)keyboard:(OWKeyboardView *)keyboard didClickSureBtn:(UIButton *)sureBtn;

@end

@interface OWKeyboardView : UIView

@property (nonatomic, assign) id<OWKeyboardViewDelegate> delegate;

@end
