//
//  PersonalCenterViewController.m
//  GanHuiYou
//
//  Created by 孙向前 on 14-9-27.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import "PersonalCenterViewController.h"

@interface PersonalCenterViewController ()

@end

@implementation PersonalCenterViewController

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
    [self setNavTitle:@"个人中心"];
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
