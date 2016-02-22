//
//  YSLockSudoView.m
//  UnLock
//
//  Created by chenfenglong on 16/2/19.
//  Copyright © 2016年 YS. All rights reserved.
//

#import "YSLockSudoView.h"
#import "YSLockCircle.h"

@interface YSLockSudoView ()

@property (nonatomic,strong) NSMutableArray *arraySudoView;

@property (nonatomic,strong) NSMutableArray *arraySelectSudoView;

@property (nonatomic,assign) CGPoint currentPoint;

@property (nonatomic,assign) BOOL isError;

@end

@implementation YSLockSudoView

- (NSMutableArray *)arraySudoView
{
    if (_arraySudoView == nil) {
        _arraySudoView = [NSMutableArray array];
    }
    return _arraySudoView;
}

- (NSMutableArray *)arraySelectSudoView
{
    if (_arraySelectSudoView == nil) {
        _arraySelectSudoView = [NSMutableArray array];
    }
    return _arraySelectSudoView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initCircle];
    }
    return self;
}

- (void)initCircle
{
    CGFloat lockCircleWH = 50;
    CGFloat lockCircleMarginHorizontal = (self.frame.size.width - lockCircleWH * 3) / 4;
    CGFloat lockCircleMarginVertical = (self.frame.size.height - lockCircleWH * 3) / 4;
    for (int i = 0; i < 9; i ++)
    {
        NSInteger row = i / 3;
        NSInteger column = i % 3;
        CGFloat lockCircleX = lockCircleMarginHorizontal * (column + 1) + lockCircleWH * column;
        CGFloat lockCircleY = lockCircleMarginVertical * (row + 1) + lockCircleWH * row;
        YSLockCircle *lockCircle = [[YSLockCircle alloc] initWithFrame:CGRectMake(lockCircleX, lockCircleY, lockCircleWH, lockCircleWH)];
        lockCircle.tag = i + 1;
        lockCircle.backgroundColor = [UIColor clearColor];
        [self addSubview:lockCircle];
        [self.arraySudoView addObject:lockCircle];
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.arraySelectSudoView.count == 0) {
        return;
    }
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(contextRef, 4.0);
    UIColor *color = self.isError ? [UIColor redColor] : [UIColor blackColor];
    CGContextSetStrokeColorWithColor(contextRef, color.CGColor);
    
    __block CGPoint points[9];
    for (int i = 0 ; i < self.arraySelectSudoView.count; i++)
    {
        YSLockCircle *circelView = self.arraySelectSudoView[i];
        points[i] = circelView.center;
    }

    CGContextAddLines(contextRef, points, self.arraySelectSudoView.count);
    CGContextDrawPath(contextRef, kCGPathStroke);
    
    if (!self.isError) {
        YSLockCircle *lastCircelView = self.arraySelectSudoView.lastObject;
        CGContextMoveToPoint(contextRef, lastCircelView.center.x, lastCircelView.center.y);
        CGContextAddLineToPoint(contextRef, self.currentPoint.x, self.currentPoint.y);
        CGContextDrawPath(contextRef, kCGPathStroke);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self updateTrack:point];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self updateTrack:point];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endTrack];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endTrack];
}

- (void)updateTrack:(CGPoint)localPoint
{
    __block BOOL isContain = NO;
    __weak typeof(self) _weakSelf = self;
    [self.arraySudoView enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YSLockCircle *circle = (YSLockCircle *)obj;
        if (![self.arraySelectSudoView containsObject:circle]) {
            if (CGRectContainsPoint(circle.frame, localPoint) ) {
                isContain = YES;
                [circle updateCircleState:LockCircleStateSelected];
                [_weakSelf.arraySelectSudoView addObject:circle];
                *stop = YES;
            }
        }
    }];
    self.currentPoint = localPoint;
}

- (void)endTrack
{
    //开始循环取出结果
    NSString *result = @"";
    for (int i = 0; i < self.arraySelectSudoView.count; i++)
    {
        YSLockCircle *circle = [self.arraySelectSudoView objectAtIndex:i];
        NSInteger index = circle.tag;
        result = [NSString stringWithFormat:@"%@%ld",result,(long)index];
    }
    NSLog(@"result - %@",result);
    
    //判断结果
    if (![result isEqualToString:@"1359"]) {
        self.isError = YES;
    }
    else
    {
        self.isError = NO;
    }
    
    for (int i = 0; i < self.arraySelectSudoView.count ; i++)
    {
        YSLockCircle *circle = [self.arraySelectSudoView objectAtIndex:i];
        [circle updateCircleState:self.isError ? LockCircleStateError : LockCircleStateNormal];
    }
    
    //重新绘制线条
    [self setNeedsDisplay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < self.arraySelectSudoView.count ; i++) {
            YSLockCircle *circle = [self.arraySelectSudoView objectAtIndex:i];
            [circle updateCircleState:LockCircleStateNormal];
        }
        [self.arraySelectSudoView removeAllObjects];
        [self setNeedsDisplay];
        self.isError = NO;
    });
}

- (void)reset
{
    for (int i = 0; i < self.arraySelectSudoView.count ; i++)
    {
        YSLockCircle *circle = [self.arraySelectSudoView objectAtIndex:i];
        [circle updateCircleState:LockCircleStateNormal];
    }
    [self.arraySelectSudoView removeAllObjects];
    [self setNeedsDisplay];
}

@end
