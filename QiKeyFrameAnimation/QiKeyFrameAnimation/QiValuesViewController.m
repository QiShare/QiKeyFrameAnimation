//
//  QiValuesViewController.m
//  QiKeyFrameAnimation
//
//  Created by huangxianshuai on 2018/10/30.
//  Copyright © 2018年 qishare. All rights reserved.
//

#import "QiValuesViewController.h"

@interface QiValuesViewController ()

@end

@implementation QiValuesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.animation.values = @[[NSValue valueWithCGPoint:self.imageView.center],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 2, self.squareSide * 1}],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 2, self.squareSide * 5}],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 5, self.squareSide * 5}],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 5, self.squareSide * 7}]];
    self.animation.keyTimes = @[@.0, @.1, @.5, @.8, @1.0];
    // self.animation.calculationMode = kCAAnimationPaced;// 可以替代上面的keyTimes实现匀速效果
}

@end
