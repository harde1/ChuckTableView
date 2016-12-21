//
//  UtilScreenSize.h
//  FanXing
//
//  Created by cong on 16/7/25.
//  Copyright © 2016年 kugou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define PxToPt(p) [UtilScreenSize getPtbyWidth:p]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface UtilScreenSize : NSObject
//根据宽度比，得出pt
+(CGFloat)getPtbyWidth:(CGFloat)px;
//根据px得出font
+(CGFloat)getFontbyPx:(CGFloat)px;
//数组是否包含某整数
+(BOOL)containNum:(NSInteger)num inArray:(NSArray *)arr;
@end
