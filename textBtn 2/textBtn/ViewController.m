//
//  ViewController.m
//  textBtn
//
//  Created by Paul on 2017/7/24.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "ViewController.h"

@interface NSString (crypto)

- (NSString *)encryptedString;
@end

@implementation NSString (crypto)

- (NSString *)encryptedString
{
//    return [@"***********************************" substringToIndex:MAX(self.length, 1)];
    
    NSString * str = @"****";
    
    return str;
}
@end


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UILabel *btn3;
@property (weak, nonatomic) IBOutlet UILabel *btn5;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UIButton *showbtn;

@property (strong, nonatomic) NSMutableDictionary  *config;

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    
    // 初始化设置
    self.config = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewControllerConfig"] mutableCopy];
    if (!self.config) {
        self.config = [@{
                     NSStringFromSelector(@selector(btn1)) : @"12344345654655",
                     NSStringFromSelector(@selector(btn2)) : @"12",
                     NSStringFromSelector(@selector(btn3)) : @"12345",
                     NSStringFromSelector(@selector(label4)) : @"1234567",
                     NSStringFromSelector(@selector(btn5)) : @"1",
                     @"showOriginValue" : @(YES)
                     } mutableCopy];
        [self syncConfigToUserDefault];
    }
    
    // 刷新UI
    [self setupUI];
}

// 持久化
- (void)syncConfigToUserDefault
{
    [[NSUserDefaults standardUserDefaults] setObject:self.config forKey:@"ViewControllerConfig"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)show:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    // 更改设置
    BOOL showOrigin = [self.config[@"showOriginValue"] boolValue];
    showOrigin = !showOrigin;
    [self.config setObject:@(showOrigin) forKey:@"showOriginValue"];
    [self syncConfigToUserDefault];
    
    // 刷新UI
    [self setupUI];
}

- (void)setupUI
{
    // 取原始值
    NSString *btn1str = [self.config objectForKey: NSStringFromSelector(@selector(btn1))];
    NSString *btn2str = [self.config objectForKey: NSStringFromSelector(@selector(btn2))];
    NSString *btn3str = [self.config objectForKey: NSStringFromSelector(@selector(btn3))];
    NSString *lbl4str = [self.config objectForKey: NSStringFromSelector(@selector(label4))];
    NSString *btn5str = [self.config objectForKey: NSStringFromSelector(@selector(btn5))];
    
    if ([self.config[@"showOriginValue"] boolValue]) { // 显示金额
        [self.showbtn setTitle:@"隐藏" forState:UIControlStateNormal];
    }
    else { // 隐藏金额
        [self.showbtn setTitle:@"显示" forState:UIControlStateNormal];
        btn1str = [btn1str encryptedString];
        btn2str = [btn2str encryptedString];
        btn3str = [btn3str encryptedString];
        lbl4str = [lbl4str encryptedString];
        btn5str = [btn5str encryptedString];
    }
    
    // UI
    [self.btn1 setTitle:btn1str forState:UIControlStateNormal];
    [self.btn2 setTitle:btn2str forState:UIControlStateNormal];
    self.btn3.text = btn3str;
    self.label4.text = lbl4str;
    self.btn5.text = btn5str;
}

@end
