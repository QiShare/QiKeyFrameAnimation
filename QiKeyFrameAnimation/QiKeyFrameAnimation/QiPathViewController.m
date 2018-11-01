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
    
    
    CGPathMoveToPoint(path, NULL, self.imageView.center.x, self.imageView.center.y);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 2, self.squareSide * 2);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 2, self.squareSide * 5);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 5, self.squareSide * 5);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 5, self.squareSide * 7);
#if 0
    CGRect drawRect = (CGRect){self.squareSide, self.squareSide, self.squareSide * 8, self.squareSide * 8};
    CGPathAddArc(path, NULL, CGRectGetMidX(drawRect), CGRectGetMidY(drawRect), drawRect.size.width / 2, 0, 2 * M_PI, NO);
#endif
    
    
    self.animation.path = path;
    CGPathRelease(path);
    
    self.shapeLayer.path = path;
}

@end
