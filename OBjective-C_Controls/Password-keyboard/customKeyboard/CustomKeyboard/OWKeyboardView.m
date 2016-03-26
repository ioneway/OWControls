//
//  LVKeyboardView.m
//  PasswordKeyBoard
//
//  Created by weiwang on 16/3/24.
//  Copyright (c) 2015年 王伟. All rights reserved.
//

#import "OWKeyboardView.h"

#define OWKeyboardCols  4
#define OWKeyboardRows  4
#define OWKeyboardTextFont 27
#define OWKeyboardHeight  216.f

@interface OWKeyboardView ()

/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteBtn;

/** 退出按钮 */
@property (nonatomic, strong) UIButton *downBtn;

/** 确定按钮 */
@property (nonatomic, strong) UIButton *sureBtn;

@end


@implementation OWKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self setupNumberKeyButton];
        self.deleteBtn = [self normalButtonWithImageName:@"RYNumbeKeyboard.bundle/delete.png" andAction:@selector(deleteBtnClick:)];
        self.sureBtn = [self normalButtonWithImageName:@"" andAction:@selector(sureBtnClick:)];
        self.downBtn = [self normalButtonWithImageName:@"resign.png" andAction:@selector(downBtnClick:)];
        [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        self.sureBtn.backgroundColor = [UIColor colorWithRed:69.0/255.0 green:181.0/255.0 blue:251.0/255.0 alpha:1.f];
        
        [self layoutButtons];
        
    }
    return self;
}




#pragma mark - 数字按钮
- (void)setupTopButtonsWithHighImage {
    for (int i = 0; i < 10; i++) {
        
        UIButton *numBtn = [[UIButton alloc] init];
        [numBtn setTitle:@"" forState:UIControlStateNormal];
        [numBtn setBackgroundColor:[UIColor whiteColor]];
        numBtn.titleLabel.font = [UIFont systemFontOfSize:OWKeyboardTextFont];
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:numBtn];
    }
}




#pragma mark - 删除按钮可以点击 符号、ABC按钮不能点击

- (void)layoutButtons {
    
    self.backgroundColor = [UIColor lightGrayColor];
    NSArray *arrM = [self generateRandArray];
    
    CGFloat colMargin_temp = 0.0;
    CGFloat rowMargin_temp = 0.0;
    
    CGFloat colMargin = 0.5;
    CGFloat rowMargin = 0.5;
    
    CGFloat numBtnW = (self.width - 3 * colMargin) / OWKeyboardCols;
    CGFloat numBtnH = (OWKeyboardHeight - 3 * rowMargin) / OWKeyboardRows;
    
    self.deleteBtn.x = self.width - numBtnW;
    self.deleteBtn.y = 0;
    self.deleteBtn.width = numBtnW;
    self.deleteBtn.height = numBtnH*2;
    [self addSubview:self.deleteBtn];
    
    self.sureBtn.x = self.width - numBtnW;
    self.sureBtn.y = CGRectGetMaxY(self.deleteBtn.frame)+colMargin;
    self.sureBtn.width = numBtnW;
    self.sureBtn.height = numBtnH*2;
    [self addSubview:self.sureBtn];
    
    UIButton *unUsedBtn = [[UIButton alloc] init];
    unUsedBtn.backgroundColor = [UIColor whiteColor];
    unUsedBtn.x = 0;
    unUsedBtn.y = numBtnH*3+rowMargin*3;
    unUsedBtn.width = numBtnW;
    unUsedBtn.height = numBtnH;
    
    [self addSubview:unUsedBtn];

    self.downBtn.x = numBtnW*2 + rowMargin*2;
    self.downBtn.y = numBtnH*3 + colMargin*3;
    self.downBtn.width = numBtnW;
    self.downBtn.height = numBtnH;
    [self addSubview:self.downBtn];
    
    NSUInteger count = self.subviews.count;
    
    // 布局数字按钮
    for (NSUInteger i = 0; i < count; i++) {
        if (i == 0) { // 0
            UIButton *buttonZero = self.subviews[i];
            buttonZero.height = numBtnH;
            buttonZero.width = numBtnW;
            buttonZero.x = numBtnW + colMargin;
            buttonZero.y = self.height - buttonZero.height;
            [buttonZero setTitle:[arrM[0] stringValue] forState:UIControlStateNormal];
        }
        if (i > 0 && i < 10) { // 0 ~ 9
            
            UIButton *topButton = self.subviews[i];
            CGFloat row = (i - 1) / 3;
            CGFloat col = (i - 1) % 3;
            
            colMargin_temp = col!=0?colMargin:0.0;
            rowMargin_temp = row!=0?rowMargin:0.0;
            
            topButton.x = col * (numBtnW + colMargin_temp);
            topButton.y = row * (numBtnH + rowMargin_temp);
            topButton.width = numBtnW;
            topButton.height = numBtnH;
            [topButton setTitle:[arrM[i] stringValue] forState:UIControlStateNormal];
        }
    }
}




#pragma mark- private method

-(void)setupNumberKeyButton {
    for (int i = 0; i < 10; i++) {
        
        UIButton *numBtn = [[UIButton alloc] init];
        [numBtn setTitle:@"" forState:UIControlStateNormal];
        [numBtn setBackgroundColor:[UIColor whiteColor]];
        numBtn.titleLabel.font = [UIFont systemFontOfSize:OWKeyboardTextFont];
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:numBtn];
    }
}

-(UIButton *)normalButtonWithImageName:(NSString *)imageName andAction:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(void)setupUnUsedKeyButton {
    UIButton *unUsedBtn = [[UIButton alloc] init];
    unUsedBtn.backgroundColor = [UIColor whiteColor];
}

-(void)sureBtnClick:(UIButton *)btn
{
    [self hideKeyboard];
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickSureBtn:)]) {
        [self.delegate keyboard:self didClickSureBtn:btn];
    }
}

-(void)downBtnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickDownBtn:)]) {
        [self.delegate keyboard:self didClickDeleteBtn:btn];
    }
}

- (void)numBtnClick:(UIButton *)numBtn {
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickButton:)]) {
        [self.delegate keyboard:self didClickButton:numBtn];
    }
}

- (void)deleteBtnClick:(UIButton *)deleteBtn {
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickDeleteBtn:)]) {
        [self.delegate keyboard:self didClickDeleteBtn:deleteBtn];
    }
}


-(void)hideKeyboard
{
    [UIView animateWithDuration:0.2 animations:^(void){
        float height = [UIApplication sharedApplication].keyWindow.frame.size.height;
        self.frame = CGRectMake(0, height+10, self.width, self.height);
    }completion:^(BOOL b){
        [self.superview becomeFirstResponder];
        [self removeFromSuperview];
        
    }];
}

/**
 *  生成10个随机数字
 *
 *  @return 返回数组包含0~9十个随机数字
 */
-(NSArray *)generateRandArray
{
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM removeAllObjects];
    for (int i = 0 ; i < 10; i++) {
        int j = arc4random_uniform(10);
        NSLog(@"%i", i);
        NSNumber *number = [[NSNumber alloc] initWithInt:j];
        if ([arrM containsObject:number]) {
            i--;
            continue;
        }
        [arrM addObject:number];
    }
    return arrM;
}
@end
