//
//  QiPathViewController.m
//  QiKeyFrameAnimation
//
//  Created by huangxianshuai on 2018/10/30.
//  Copyright © 2018年 qishare. All rights reserved.
//

#import "QiPathViewController.h"

@interface QiPathViewController ()

@end

@implementation QiPathViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddLineToPoint(path, NULL, self.squareSide * 2, self.squareSide * 2);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 2, self.squareSide * 4);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 4, self.squareSide * 4);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 4, self.squareSide * 6);
    
//    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
    self.animation.path = path;
    
    
    CGPathRelease(path);
}

@end
