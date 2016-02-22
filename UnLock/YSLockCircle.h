//
//  YSLockCircle.h
//  UnLock
//
//  Created by chenfenglong on 16/2/19.
//  Copyright © 2016年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LockCircleState)
{
    LockCircleStateNormal,
    LockCircleStateSelected,
    LockCircleStateError
};

@interface YSLockCircle : UIView

- (void)updateCircleState:(LockCircleState)state;

@end
