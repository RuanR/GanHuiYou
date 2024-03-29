//
//  StringRef.m
//  beta1
//
//  Created by jack ray on 11-1-17.
//  Copyright 2011 重庆奥芬多网络科技有限公司. All rights reserved.
//

#import "NSString+expanded.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString(expanded)

- (NSString *)stringByReplaceHTML{
    
    NSScanner *theScanner;
    NSString *text = nil;
    NSString *html = self;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //
    
    return html;
    
}

- (int)calc_charsetNum
{
    NSUInteger unicodeStrLen = [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];// 每一个字符统一占2个字节
    NSUInteger UTF8Strlen = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];// 中文3个字节,英文1个字节
    // 根据中文算一个字，英文算半个字的规则计算
    NSUInteger zh_num = UTF8Strlen / 2 - unicodeStrLen / 4;// 中文字数
    NSUInteger en_num = unicodeStrLen * 3 / 4 - UTF8Strlen / 2;// 英文字数
    return (zh_num*2 + ceilf(en_num));
}

-(NSString*)replaceControlString
{
    NSString *tempStr = self;
	tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
	tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\b" withString:@"\\b"];
	tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
	tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\r" withString:@"\\t"];
	tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\t" withString:@"\\r"];
	tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
	tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
	
	return tempStr;
}
-(NSString*)replaceStoreKey
{
    NSString *tempStr = self;
    NSRange range=[tempStr rangeOfString:@"user.lat="];
    if (range.length==0) {
        range=[tempStr rangeOfString:@"loc.latOffset="];
        if (range.length==0) {
            range=[tempStr rangeOfString:@"lat="];
            if (range.length!=0) {
                NSInteger l=[[tempStr substringFromIndex:[tempStr rangeOfString:@"lng="].location] rangeOfString:@"&"].location;
                range.length=[tempStr rangeOfString:@"lng="].location-range.location+l;
                tempStr=[tempStr stringByReplacingCharactersInRange:range withString:@""];
            }
        }else{
            NSInteger l=[[tempStr substringFromIndex:[tempStr rangeOfString:@"loc.lngOffset="].location] rangeOfString:@"&"].location;
            range.length=[tempStr rangeOfString:@"loc.lngOffset="].location-range.location+l;
            tempStr=[tempStr stringByReplacingCharactersInRange:range withString:@""];
        }
    }else{
        NSInteger l=[[tempStr substringFromIndex:[tempStr rangeOfString:@"user.lng="].location] rangeOfString:@"&"].location;
        range.length=[tempStr rangeOfString:@"user.lng="].location-range.location+l;
        tempStr=[tempStr stringByReplacingCharactersInRange:range withString:@""];
    }
    return tempStr;
}

//"upload/".length=7
-(NSString*)imagePathType:(imageType)__type
{
    if ((__type != imageSmallType && __type != imageBigType)) {
        return self;
    }else{
        return [self stringByReplacingOccurrencesOfString:@"/" withString:__type==imageSmallType?@"/s":@"/b" options:0 range:NSMakeRange(7, [self length]-7)];
    }
}
- (CGFloat)getHeightByWidth:(NSInteger)_width font:(UIFont *)_font
{
    //!self不会调用，不用判断了
    return [self sizeWithFont:_font constrainedToSize:CGSizeMake(_width, 1000) lineBreakMode:UILineBreakModeCharacterWrap].height;
}

//- (NSString *)indentString:(NSString*)_string font:(UIFont *)_font
//{
//    if (!_string) {
//        return self;
//    }else{
//        CGSize  size=[_string sizeWithFont:_font];
//        NSLog(@"%f,%f",size.width/[@" " sizeWithFont:_font].width,[@" " sizeWithFont:_font].width);
//        return [NSString stringWithFormat:@"%@%@",[@"" stringByPaddingToLength:(size.width/[@"_" sizeWithFont:_font].width+2)*2 withString:@" " startingAtIndex:0],self];
//    }
//}
- (NSString *)indentLength:(CGFloat)_len font:(UIFont *)_font
{
    NSString *str=@"";
    CGFloat temp=0.0;
    while (temp<=_len) {
        str=[str stringByAppendingString:@" "];
        temp=[str sizeWithFont:_font].width;
    }
    return [NSString stringWithFormat:@"%@%@",str,self];
    //[@"" stringByPaddingToLength:(_len/[@"_" sizeWithFont:_font].width+1) withString:@"_" startingAtIndex:0]
}
- (BOOL)notEmptyOrNull
{
    if ([self isEqualToString:@""]||[self isEqualToString:@"null"] || [self isEqualToString:@"\"\""] || [self isEqualToString:@"''"]) {
        return NO;
    }
    return YES;
}

+ (NSString *)replaceEmptyOrNull:(NSString *)checkString
{
    if (!checkString || [checkString isEqualToString:@""]||[checkString isEqualToString:@"null"]) {
        return @"";
    }
    return checkString;
}
-(NSString*)replaceTime
{
    NSString *tempStr = self;
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"-" withString:@"年" options:0 range:NSMakeRange(0, 5)];
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
    tempStr=[tempStr stringByAppendingString:@"日"];
    return tempStr;
}

- (NSString*)soapMessage:(NSString *)key,...
{
    NSString *akey;
    va_list ap;
    va_start(ap, key);
    NSString *obj = nil;
    if (key) {
        if ([key rangeOfString:@"<"].length == 0)
            obj=[NSString stringWithFormat:@"<%@>%@</%@>",key,@"%@",key];
        else
            obj = key;
        
        while (obj&&(akey=va_arg(ap,id))) {
            if ([akey rangeOfString:@"<"].length == 0)
                obj=[obj stringByAppendingFormat:@"<%@>%@</%@>",akey,@"%@",akey];
            else
                obj = [obj stringByAppendingString:akey];
        }
        va_end(ap);
    }
    
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:soap=\"http://soap.csc.iofd.cn/\"> <soapenv:Header/> <soapenv:Body><soap:%@>%@</soap:%@></soapenv:Body></soapenv:Envelope>",self,obj?obj:@"",self];;
}
- (NSString *)md5{
	const char *concat_str = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(concat_str, strlen(concat_str), result);
	NSMutableString *hash = [NSMutableString string];
	for (int i = 0; i < 16; i++){
		[hash appendFormat:@"%02X", result[i]];
	}
	return [hash lowercaseString];
	
}
@end
