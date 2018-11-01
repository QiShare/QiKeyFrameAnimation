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
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 2, self.squareSide * 2}],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 2, self.squareSide * 4}],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 4, self.squareSide * 4}],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 4, self.squareSide * 6}]];
    // self.animation.keyTimes = @[@.0, @.2, @.5, @.9, @1.0];
}

@end
