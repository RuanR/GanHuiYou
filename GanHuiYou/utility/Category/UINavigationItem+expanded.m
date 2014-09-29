//
//  UINavigationItem+expanded.m
//  guanggaoban
//
//  Created by 孙向前 on 14-4-26.
//  Copyright (c) 2014年 edwin good. All rights reserved.
//

#import "UINavigationItem+expanded.h"

@implementation UINavigationItem(Addition)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width = -5;
    
    if (_leftBarButtonItem)
    {
        [self setLeftBarButtonItems:@[spaceButtonItem, _leftBarButtonItem]];
    }
    else
    {
        [self setLeftBarButtonItems:@[spaceButtonItem]];
    }
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width = -5;
    
    if (_rightBarButtonItem)
    {
        [self setRightBarButtonItems:@[spaceButtonItem, _rightBarButtonItem]];
    }
    else
    {
        [self setRightBarButtonItems:@[spaceButtonItem]];
    }
}
#endif

@end
