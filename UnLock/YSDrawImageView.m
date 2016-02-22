//
//  YSDrawImageView.m
//  UnLock
//
//  Created by chenfenglong on 16/2/22.
//  Copyright © 2016年 YS. All rights reserved.
//

#import "YSDrawImageView.h"

@implementation YSDrawImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    UIImage *image = [UIImage imageNamed:@"a@2x.jpeg"];
    NSLog(@"%@",NSStringFromCGSize(image.size));
    
    CGContextSetStrokeColorWithColor(contextRef, [UIColor redColor].CGColor);
    CGContextSetLineWidth(contextRef, 3.0);
    CGFloat rectWH = 66;
    CGFloat rectX = (rect.size.width - rectWH) / 2;
    CGFloat rectY = (rect.size.height - rectWH) / 2;
    CGRect newRect = CGRectMake(rectX, rectY, rectWH, rectWH);
    CGContextAddEllipseInRect(contextRef, newRect);
    CGContextDrawPath(contextRef, kCGPathStroke);
    
    CGFloat edgeWidth = 3;
    newRect = CGRectMake(rectX + edgeWidth, rectY + edgeWidth, rectWH - 2 * edgeWidth, rectWH - 2 * edgeWidth);
    CGContextAddEllipseInRect(contextRef, newRect);
    CGContextSaveGState(contextRef);
//    CGContextDrawPath(contextRef, kCGPathStroke);
    
    CGContextRestoreGState(contextRef);
    CGContextClip(contextRef);
    
    CGContextDrawImage(contextRef, rect, image.CGImage);
    
//
//    
//    CGContextDrawImage(contextRef, rect, image.CGImage);
    
//    CGContextDrawPath(contextRef, kCGPathStroke);
    
}

@end
