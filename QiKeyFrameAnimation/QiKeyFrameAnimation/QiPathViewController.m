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
    
    // 为animation创建path
    CGMutablePathRef path = CGPathCreateMutable();
    
#if 0
    CGPathMoveToPoint(path, NULL, self.imageView.center.x, self.imageView.center.y);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 2, self.squareSide * 1);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 2, self.squareSide * 5);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 5, self.squareSide * 5);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 5, self.squareSide * 7);
    self.animation.keyTimes = @[@.0, @.1, @.5, @.8, @1.0];
#endif
    CGRect drawRect = (CGRect){self.squareSide, self.squareSide, self.squareSide * 8, self.squareSide * 8};
    CGPathAddEllipseInRect(path, NULL, drawRect);
    self.animation.keyTimes = @[@.0, @.25, @0.5, @0.75, @1.0];
    
    self.animation.path = path;
    CGPathRelease(path);
    
    self.shapeLayer.path = path;
}

@end
