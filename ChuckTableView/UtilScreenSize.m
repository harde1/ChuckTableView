//
//  UtilScreenSize.m
//  FanXing
//
//  Created by cong on 16/7/25.
//  Copyright © 2016年 kugou. All rights reserved.
//

#import "UtilScreenSize.h"
@implementation UtilScreenSize
+(CGFloat)getPtbyWidth:(CGFloat)px {
    
    CGFloat screen_min_length = MIN([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    return (px * screen_min_length) / 750;
}


+(CGFloat)getFontbyPx:(CGFloat)px {
    float screen_min_length = MIN([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    return (px * screen_min_length) / 750;
}

+(BOOL)containNum:(NSInteger)num inArray:(NSArray *)arr{
    if (![arr isKindOfClass:[NSArray class]]) {
        return NO;
    }
    if ([arr indexOfObject:[NSString stringWithFormat:@"%ld",num]] != NSNotFound) {
        return YES;
    }
    return NO;
}
@end
