//
//  ViewController.m
//  GanHuiYou
//
//  Created by 孙向前 on 14-9-27.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import "ViewController.h"
#import "XLCycleScrollView.h"
#import "UIView+expanded.h"

#import "HomeViewController.h"//首页
#import "MyAssistantsViewController.h"//我的医助
#import "NewsViewController.h"//新闻
#import "PersonalCenterViewController.h"//个人中心

#import "BaseTabViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet XLCycleScrollView *xlCycle;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

#pragma mark - actions
//显示密码
- (IBAction)showPasswordButtonClicked:(UIButton *)sender {
    _txtPassword.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}

//登录
- (IBAction)loginButtonClicked:(id)sender {
    [self hideKeyboard];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    MyAssistantsViewController *myAssistants = [[MyAssistantsViewController alloc] init];
    NewsViewController *news = [[NewsViewController alloc] init];
    PersonalCenterViewController *personalCenter = [[PersonalCenterViewController alloc] init];
    
    NSArray *vcs = @[home,myAssistants,news,personalCenter];
    NSArray *titles = @[@"首页",@"我的医助",@"新闻",@"个人中心"];
    NSArray *defaultImages = @[@"",@"",@"",@""];
    NSArray *highlightImages = @[@"",@"",@"",@""];
    
    BaseTabViewController *tabbar = [[BaseTabViewController alloc] initWithTitles:titles defaultImages:defaultImages highlightImages:highlightImages controllers:vcs];
    [self presentViewController:tabbar animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:.3 animations:^{
        self.view.frameY = -50;
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hideKeyboard];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hideKeyboard];
}

- (void)hideKeyboard{
    if (!self.view.frameY) return;
    [UIView animateWithDuration:.3 animations:^{
        self.view.frameY = 64;
    }];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)farwordButtonClicked:(id)sender {
    
//    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"DoctorterMinal" bundle:nil];
//    
//    UIViewController *firstVC = [secondStoryboard instantiateInitialViewController];
//
//    [self.navigationController pushViewController:firstVC animated:YES];
    
}
@end
