//
//  BaseTabViewController.m
//  LXProject
//
//  Created by 孙向前 on 14-9-19.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import "BaseTabViewController.h"
#import "BaseNavigationViewController.h"
#import "RHMethods.h"

@interface BaseTabViewController ()

@property (nonatomic,retain) NSMutableArray *buttons;
@property (nonatomic,retain) UIImageView *bgImageView;

@end

@implementation BaseTabViewController

/**
 @method
 @abstract 继承，初始化TabbarController
 @discussion 隐藏真实tabbar,构造button替换点击,所有子controller的hidesBottomBarWhenPushed=YES。
 @param 所有参数个数保持一致
 @result 返回tabbar
 */
- (id)initWithTitles:(NSArray*)titles defaultImages:(NSArray*)dimages highlightImages:(NSArray*)himages controllers:(NSArray*)controllers
{
    self = [super init];
    if (self) {

        [self.tabBar setHidden:YES];

        if (titles.count==dimages.count&&dimages.count==controllers.count) {
            
            [self customTabBar:titles
                 defaultImages:dimages
               highlightImages:himages
                   controllers:(NSArray*)controllers];
            
            [self addObserver:self forKeyPath:@"selectedIndex" options:0 context:nil];
            
        } else {
            DLog(@"check tabbar image's or title's count");
        }
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

//初始化子控制器
-(void)_initViewController:(NSArray *)viewcontrollers{
    
    NSMutableArray *viewConrollers=[NSMutableArray arrayWithCapacity:4];
    for (UIViewController *viewController in viewcontrollers) {
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:viewController];
        [viewConrollers addObject:nav];
    }
    self.viewControllers = viewConrollers;
    
}

- (void)customTabBar:(NSArray*)titles
       defaultImages:(NSArray*)dimages
     highlightImages:(NSArray*)himages
         controllers:(NSArray*)controllers{
    
    [self _initViewController:controllers];
    
    self.bgImageView = [RHMethods imageviewWithFrame:CGRectMake(0, kScreenHeight-48, 0, 0) defaultimage:@"menu_bg.png" stretchW:-1 stretchH:-1];
	[self.view addSubview:self.bgImageView];
    
    //创建按钮
	int viewCount = titles.count > 5 ? 5 : titles.count;
	self.buttons = [NSMutableArray arrayWithCapacity:viewCount];
	double _width = 320 / viewCount;
	double _height = self.tabBar.frame.size.height;
	for (int i = 0; i < viewCount; i++) {
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(i*_width,self.tabBar.frame.origin.y, _width, _height);
		[btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
		btn.tag = i;

        [btn setImage:[UIImage imageNamed:dimages[i]] forState:UIControlStateNormal];
        [btn setTitleColor:RGBCOLOR(148, 148, 148) forState:UIControlStateNormal];
        [btn setTitleColor:RGBCOLOR(231,160,87) forState:UIControlStateHighlighted];
        [btn setTitleColor:RGBCOLOR(231,160,87) forState:UIControlStateSelected];
        
        if(himages.count){
            [btn setImage:[UIImage imageNamed:himages[i]] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:himages[i]] forState:UIControlStateSelected];
        }
        
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(30, -22, 0, 0)];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:12];
        
		[self.buttons addObject:btn];
		[self.view  addSubview:btn];
	}
	[self selectedTab:[self.buttons objectAtIndex:0]];
    
}

- (void)selectedTab:(UIButton *)button{
    
    [self.buttons makeObjectsPerformSelector:@selector(setSelected:) withObject:nil];
    
    [button setSelected:YES];
    
	if (self.currentSelectedIndex != button.tag)
    {
        UIButton *preBtn=[self.buttons objectAtIndex:self.currentSelectedIndex];
        [preBtn setSelected:NO];
	}
    
	self.currentSelectedIndex = button.tag;
	self.selectedIndex = self.currentSelectedIndex;
    
}

- (void)hideTabBar{
    [UIView animateWithDuration:.3 animations:^{
        for (UIButton *btn in self.buttons) {
            [btn setCenter:CGPointMake(btn.center.x, [UIScreen mainScreen].bounds.size.height+btn.frame.size.height/2)];
        }
        UIImageView *bgimgview=self.bgImageView;
        [bgimgview setCenter:CGPointMake(bgimgview.center.x, [UIScreen mainScreen].bounds.size.height+bgimgview.frame.size.height/2)];
    }];
}

- (void)showTabBar{
    [UIView animateWithDuration:.3 animations:^{
        for (UIButton *btn in self.buttons) {
            [btn setCenter:CGPointMake(btn.center.x, [UIScreen mainScreen].bounds.size.height-btn.frame.size.height/2)];
        }
        UIImageView *bgimgview=self.bgImageView;
        [bgimgview setCenter:CGPointMake(bgimgview.center.x, [UIScreen mainScreen].bounds.size.height-bgimgview.frame.size.height/2)];
    }];
}

- (void)selectedTabIndex:(NSInteger)idx{
    [self selectedTab:[self.buttons objectAtIndex:idx]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    UIButton *button=[self.buttons objectAtIndex:self.selectedIndex];
    
    if (!button.selected) {
        [self selectedTab:button];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addConstraints{
    
//    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    NSArray *hArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[scrollView(138)]-0-|"
//                                                              options:0
//                                                              metrics:nil
//                                                                views:@{@"scrollView":self.scrollView,
//                                                                        @"view":self.view}];
//    NSArray *vArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[scrollView]-0-|"
//                                                              options:0
//                                                              metrics:nil
//                                                                views:@{@"scrollView":self.scrollView}];
//    [self.view addConstraints:hArray];
//    [self.view addConstraints:vArray];
    
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
