//
//  NSString+SizeFont.m
//  FanXing
//
//  Created by Wilson on 14/12/13.
//  Copyright (c) 2014年 kugou. All rights reserved.
//

#import "NSString+SizeFont.h"

@implementation NSString (SizeFont)
- (CGSize)sizeWithFont:(UIFont *)font andSize:(CGSize)cSize{
    CGSize size=CGSizeZero;
#ifdef __IPHONE_7_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil];
        CGRect rect = [self boundingRectWithSize:cSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil];
        size = rect.size;
        
    }else{
        size = [self sizeWithFont:font constrainedToSize:cSize];
    }
#else
    size = [self sizeWithFont:font constrainedToSize:cSize];
#endif
    return size;
}
@end
