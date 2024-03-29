//
//  BaseNavigationViewController.m
//  LXProject
//
//  Created by 孙向前 on 14-9-18.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置navigationBar背景
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
//        UIImage *image=[UIImage imageNamed:@"navigationbar_background.png"];
//        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    } else {
//        [self.navigationBar setNeedsDisplay];
//    }

    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        self.navigationBar.tintColor = RGBCOLOR(0, 184, 211);
    } else {
        // Load resources for iOS 7 or later
        self.navigationBar.barTintColor = RGBCOLOR(0, 184, 211);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
