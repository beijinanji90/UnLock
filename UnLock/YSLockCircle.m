//
//  YSLockCircle.m
//  UnLock
//
//  Created by chenfenglong on 16/2/19.
//  Copyright © 2016年 YS. All rights reserved.
//

#import "YSLockCircle.h"

@interface YSLockCircle ()

@property (nonatomic,assign) LockCircleState state;

@end

@implementation YSLockCircle

- (instancetype)init
{
    if (self = [super init]) {
        self.state = LockCircleStateNormal;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.state = LockCircleStateNormal;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    switch (self.state) {
        case LockCircleStateNormal:
            [self setEmptyCircle:contextRef WithRect:rect];
            break;
            
        case LockCircleStateSelected:
            [self setEmptyWithSmallCircle:contextRef WithRect:rect];
            break;
            
        case LockCircleStateError:
            [self setErrorStateCircle:contextRef WithRect:rect];
            break;
            
        default:
            break;
    }
}

- (void)updateCircleState:(LockCircleState)state
{
    self.state = state;
    [self setNeedsDisplay];
}

/*空心圆*/
- (void)setEmptyCircle:(CGContextRef)contentRef WithRect:(CGRect)rect
{
    rect = CGRectMake(1.0, 1.0, rect.size.width - 2, rect.size.height - 2);
    CGContextSetLineWidth(contentRef, 1.0);
    CGContextSetStrokeColorWithColor(contentRef, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(contentRef, [UIColor whiteColor].CGColor);
    CGContextStrokeEllipseInRect(contentRef, rect);
}

/*空心圆 + 小圆*/
- (void)setEmptyWithSmallCircle:(CGContextRef)contextRef WithRect:(CGRect)rect
{
    rect = CGRectMake(1.0, 1.0, rect.size.width - 2, rect.size.height - 2);
    CGContextSetLineWidth(contextRef, 1);
    CGContextSetFillColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor blackColor].CGColor);
    CGContextAddEllipseInRect(contextRef, rect);
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
    CGFloat smallRoundWH = 15;
    CGContextSetFillColorWithColor(contextRef, [UIColor blackColor].CGColor);
    CGFloat x = (rect.size.width - smallRoundWH) / 2 + rect.origin.x;
    CGFloat y = (rect.size.height - smallRoundWH) / 2 + rect.origin.y;
    CGContextAddEllipseInRect(contextRef, CGRectMake(x, y, smallRoundWH, smallRoundWH));
    CGContextDrawPath(contextRef, kCGPathFillStroke);
}

- (void)setErrorStateCircle:(CGContextRef)contentRef WithRect:(CGRect)rect
{
    rect = CGRectMake(1.0, 1.0, rect.size.width - 2, rect.size.height - 2);
    CGContextSetLineWidth(contentRef, 1);
    CGContextSetFillColorWithColor(contentRef, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(contentRef, [UIColor redColor].CGColor);
    CGContextAddEllipseInRect(contentRef, rect);
    CGContextDrawPath(contentRef, kCGPathFillStroke);
    
    CGFloat smallRoundWH = 15;
    CGContextSetFillColorWithColor(contentRef, [UIColor redColor].CGColor);
    CGFloat x = (rect.size.width - smallRoundWH) / 2 + rect.origin.x;
    CGFloat y = (rect.size.height - smallRoundWH) / 2 + rect.origin.y;
    CGContextAddEllipseInRect(contentRef, CGRectMake(x, y, smallRoundWH, smallRoundWH));
    CGContextDrawPath(contentRef, kCGPathFillStroke);
}

@end
