//
//  AreaCell.m
//  GanHuiYou
//
//  Created by 孙向前 on 14-9-28.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import "AreaCell.h"

@implementation AreaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
