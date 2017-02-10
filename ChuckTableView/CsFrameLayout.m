//
//  CsFrameLayout.m
//  cs_framelayout
//
//  Created by 梁慧聪 on 2017/1/6.
//  Copyright © 2017年 梁慧聪. All rights reserved.
//

#import "CsFrameLayout.h"
#import "UIView+Metrics.h"
typedef NS_ENUM(NSInteger,HotpotFrameLayoutDirection) {
    HotpotFrameLayoutDirectionHorizontal,
    HotpotFrameLayoutDirectionVertical
};
@interface CsFrameLayout()
@property (nonatomic) UIView *view;
@property (nonatomic) NSString *key;

@property (nonatomic) HotpotFrameLayoutDirection direction;
@property (nonatomic) NSMutableDictionary *layoutHorizontal;
@property (nonatomic) NSMutableDictionary *layoutVertical;

@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;
@property (nonatomic) CGFloat frameLeft;
@property (nonatomic) CGFloat frameRight;
@property (nonatomic) CGFloat frameTop;
@property (nonatomic) CGFloat frameBottom;
@property (nonatomic) CGFloat frameCenterX;
@property (nonatomic) CGFloat frameCenterY;
@end
@implementation CsFrameLayout
- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.view = view;
        self.key = @"default";
        
        self.frameWidth = -0.1f;
        self.frameHeight = -0.1f;
        
        self.frameCenterX = -0.1f;
        self.frameCenterY = -0.1f;
        
        self.layoutHorizontal = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.layoutVertical = [[NSMutableDictionary alloc]initWithCapacity: 0];
    }
    return self;
}

-(CsFrameLayout *)width{
    self.key = @"width";
    self.direction = HotpotFrameLayoutDirectionHorizontal;
    return self;
}

-(CsFrameLayout *)height{
    self.key = @"height";
    self.direction = HotpotFrameLayoutDirectionVertical;
    return self;
}

-(CsFrameLayout *)left{
    self.key = @"left";
    self.direction = HotpotFrameLayoutDirectionHorizontal;
    return self;
}

-(CsFrameLayout *)right{
    self.key = @"right";
    self.direction = HotpotFrameLayoutDirectionHorizontal;
    return self;
}

-(CsFrameLayout *)top{
    self.key = @"top";
    self.direction = HotpotFrameLayoutDirectionVertical;
    return self;
}

-(CsFrameLayout *)bottom{
    self.key = @"bottom";
    self.direction = HotpotFrameLayoutDirectionVertical;
    return self;
}

-(CsFrameLayout *)centerX{
    self.key = @"centerX";
    self.direction = HotpotFrameLayoutDirectionHorizontal;
    return self;
    
}

-(CsFrameLayout *)centerY{
    self.key = @"centerY";
    self.direction = HotpotFrameLayoutDirectionVertical;
    return self;
}

-(CsFrameLayout *)sizeToFit{
    [self.view sizeToFit];
    return self;
}
-(SpaceEqual)leftSpaceEqual{
    return [self.left equalTo];
}
-(SpaceEqual)rightSpaceEqual{
    return [self.right equalTo];
}

-(SpaceEqual)topSpaceEqual{
    return [self.top equalTo];
}

-(SpaceEqual)bottomSpaceEqual{
    return [self.bottom equalTo];
}

-(SpaceEqual)widthEqual{
    return [self.width equalTo];
}

-(SpaceEqual)heightEqual{
    return [self.height equalTo];
}

-(SpaceEqual)centerXEqual{
    return [self.centerX equalTo];
}

-(SpaceEqual)centerYEqual{
    return [self.centerY equalTo];
}

-(SpaceEqual)centerEqual{
    return [self.center equalTo];
}
-(CsFrameLayout *(^)(CGFloat))equalTo{
    __weak typeof(self) wSelf = self;
    [self render];
    return ^id(CGFloat value){
        switch (wSelf.direction) {
            case HotpotFrameLayoutDirectionHorizontal:
                [wSelf.layoutHorizontal setValue:@(value) forKey:wSelf.key];
                break;
            case HotpotFrameLayoutDirectionVertical:
                [wSelf.layoutVertical setValue:@(value) forKey:wSelf.key];
                break;
            default:
                break;
        }
        return self;
    };
}


-(CsFrameLayout *(^)(CGFloat offset))offset{
    __weak typeof(self) wSelf = self;
    return ^id(CGFloat offset){
        
        NSMutableDictionary *tempDictionary ;
        
        switch (self.direction) {
            case HotpotFrameLayoutDirectionHorizontal:
                tempDictionary = wSelf.layoutHorizontal;
                break;
            case HotpotFrameLayoutDirectionVertical:
                tempDictionary = wSelf.layoutVertical;
                break;
            default:
                break;
        }
        CGFloat value = [[tempDictionary objectForKey:wSelf.key] floatValue] + offset;
        [tempDictionary setValue:@(value) forKey:wSelf.key];
        return self;
    };
    
}
-(End)end{
    [self render];
    return ^(){};
}

-(void)render{
    
    // Get view default size info.
    [self.view sizeToFit];
    
    id left = [self.layoutHorizontal objectForKey:@"left"];
    id right = [self.layoutHorizontal objectForKey:@"right"];
    id width = [self.layoutHorizontal objectForKey:@"width"];
    id centerX = [self.layoutHorizontal objectForKey:@"centerX"];
    
    id top = [self.layoutVertical objectForKey:@"top"];
    id bottom = [self.layoutVertical objectForKey:@"bottom"];
    id height = [self.layoutVertical objectForKey:@"height"];
    id centerY = [self.layoutVertical objectForKey:@"centerY"];
    
    // left width right
    // √    -     -
    if(left){
        self.frameLeft = [left floatValue];
        
        // left width right
        // √    √     -
        if(width){
            self.frameWidth = [width floatValue];
        }
        
        // left width right
        // √    x     √
        else if(right){
            self.frameWidth = [right floatValue] - [left floatValue];
        }
        
        else{
            // warn!
        }
    }
    
    // left width right
    // x    √     -
    else if(width){
        self.frameWidth = [width floatValue];
        
        // left width right
        // x    √     √
        if(right){
            self.frameLeft = [right floatValue] - [width floatValue];
        }
        
        else{
            
            // Warn!
            
        }
        
    }
    else if(right){
        
        self.frameLeft = [right floatValue] - self.view.frame.size.width;
    }
    
    
    
    
    // top height bottom
    // √    -     -
    if(top){
        self.frameTop = [top floatValue];
        
        // top height bottom
        // √    √     -
        if(height){
            self.frameHeight = [height floatValue];
        }
        
        // top height bottom
        // √    x     √
        else if(bottom){
            self.frameHeight = [bottom floatValue] - [top floatValue];
        }
        
        else{
            // warn!
        }
    }
    // top height bottom
    // x    √     -
    else if(height){
        self.frameHeight = [height floatValue];
        
        // top height bottom
        // x    √     √
        if(bottom){
            self.frameTop = [bottom floatValue] - [height floatValue];
        }
        
        else{
            
            // Warn!
            
        }
        
    }
    else if(bottom){
        
        self.frameTop = [bottom floatValue] - self.view.frame.size.height;
    }
    
    
    
    self.view.frame = CGRectMake(self.frameLeft,
                                 self.frameTop,
                                 self.frameWidth > 0?self.frameWidth:self.view.frame.size.width,
                                 self.frameHeight > 0? self.frameHeight:self.view.frame.size.height);
    
    if(centerX)
        
        self.view.center = CGPointMake([centerX floatValue], self.view.center.y);
    
    if(centerY)
        self.view.center = CGPointMake(self.view.center.x, [centerY floatValue]);;
    
    
    
}
@end
