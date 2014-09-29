//
//  RHMethods.m
//  ktvdr
//
//  Created by 何涛 Thomas on 12-4-8.
//  Copyright (c) 2012年 重庆奥芬多网络科技有限公司. All rights reserved.
//

#import "RHMethods.h"
@implementation RHMethods
/**
 *	根据Aframe 调整label宽度或高度，宽、高为0时自动根据内容文字调整。
 *  如：aframe={0,0,0,20} 自动调整到合适宽度
 *  如：aframe={0,0,280,0} 自动调整到合适高度
 *	@param	aframe	传入框架
 *	@param	afont	字体
 *	@param	acolor	颜色
 *	@param	atext	文字
 *
 *	@return	返回调整宽高之后的label
 */
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext;
{
    UILabel *baseLabel=[[UILabel alloc] initWithFrame:aframe];
    if(afont)baseLabel.font=afont;
    if(acolor)baseLabel.textColor=acolor;
    baseLabel.lineBreakMode=UILineBreakModeCharacterWrap;
    baseLabel.text=atext;
    if (!aframe.size.height) {
        baseLabel.numberOfLines=0;
        CGSize size = [baseLabel sizeThatFits:CGSizeMake(aframe.size.width, MAXFLOAT)];
        aframe.size.height = size.height;
        baseLabel.frame = aframe;
    }else if (!aframe.size.width) {
        CGSize size = [baseLabel sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
        aframe.size.width = size.width;
        baseLabel.frame = aframe;
    }
    baseLabel.backgroundColor=[UIColor clearColor];
    baseLabel.highlightedTextColor=[UIColor whiteColor];
    return baseLabel;// autorelease];
}

+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title image:(NSString*)_image bgimage:(NSString*)_bgimage
{
    UIButton *baseButton=[[UIButton alloc] initWithFrame:_frame];
    if (_title) {
        [baseButton setTitle:_title forState:UIControlStateNormal];
        [baseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (_image) {
        [baseButton setImage:[UIImage imageNamed:_image] forState:UIControlStateNormal];
    }
    if (_bgimage) {
        [baseButton setBackgroundImage:[UIImage imageNamed:_bgimage] forState:UIControlStateNormal];
    }
    
    return baseButton;// autorelease];
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image
{
    return [self imageviewWithFrame:_frame defaultimage:_image stretchW:0 stretchH:0];// autorelease];
}
//-1 if want stretch half of image.size
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image stretchW:(NSInteger)_w stretchH:(NSInteger)_h
{
    UIImageView *imageview = nil;
    if(_image){
        if (_w&&_h) {
            UIImage *image = [UIImage imageNamed:_image];
            if (_w==-1) {
                _w = image.size.width/2;
            }
            if(_h==-1){
                _h = image.size.height/2;
            }
            imageview = [[UIImageView alloc] initWithImage:
                         [image stretchableImageWithLeftCapWidth:_w topCapHeight:_h]];
        }else{
            imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_image]];
        }
    }
    if (CGRectIsEmpty(_frame)) {
        [imageview setFrame:CGRectMake(_frame.origin.x,_frame.origin.y, imageview.image.size.width, imageview.image.size.height)];
    }else{
        [imageview setFrame:_frame];
    }
    return  imageview;// autorelease];
}

@end