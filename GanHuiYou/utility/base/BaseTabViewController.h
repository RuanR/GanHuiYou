//
//  BaseTabViewController.h
//  LXProject
//
//  Created by 孙向前 on 14-9-19.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabViewController : UITabBarController

@property (nonatomic, assign) int	currentSelectedIndex;

- (id)initWithTitles:(NSArray*)titles
       defaultImages:(NSArray*)dimages
     highlightImages:(NSArray*)himages
         controllers:(NSArray*)controllers;

- (void)hideTabBar;
- (void)showTabBar;

- (void)selectedTabIndex:(NSInteger)idx;

@end
