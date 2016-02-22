//
//  ViewController.m
//  UnLock
//
//  Created by chenfenglong on 16/2/19.
//  Copyright © 2016年 YS. All rights reserved.
//

#import "ViewController.h"
#import "YSLockCircle.h"
#import "YSLockSudoView.h"
#import "YSDrawImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat sudoViewH = 300;
    CGFloat sudoViewW = self.view.frame.size.width;
    CGFloat sudoViewY = (self.view.frame.size.height - sudoViewH) / 2;
    YSLockSudoView *sudoView = [[YSLockSudoView alloc] initWithFrame:CGRectMake(0, sudoViewY, sudoViewW, sudoViewH)];
    sudoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sudoView];
    
    YSDrawImageView *drawImageView = [[YSDrawImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [self.view addSubview:drawImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
