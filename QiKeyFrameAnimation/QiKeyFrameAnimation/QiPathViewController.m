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
}


#pragma mark - Overwrite functions

- (void)startAnimation:(BOOL)start {
    
    if (start) {
        NSUInteger r = arc4random() % 2;
        if (r < 0) {
            self.shapeLayer.path = [self setupLinePathAnimation];
        } else {
            self.shapeLayer.path = [self setupEllipsePathAnimation];
        }
    }
    
    [super startAnimation:start];
}


#pragma mark - Private functions

- (CGMutablePathRef)setupLinePathAnimation {
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, self.imageView.center.x, self.imageView.center.y);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 2, self.squareSide * 1);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 2, self.squareSide * 5);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 5, self.squareSide * 5);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 5, self.squareSide * 7);
    
    // self.animation.keyTimes = @[@.0, @.1, @.5, @.8, @1.0];
    self.animation.calculationMode = kCAAnimationPaced;
    self.animation.path = path;
    CGPathRelease(path);

    return path;
}

- (CGMutablePathRef)setupEllipsePathAnimation {
    
    CGRect drawRect = (CGRect){self.squareSide, self.squareSide, self.squareSide * 8, self.squareSide * 6};
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, drawRect);
    
    self.animation.keyTimes = @[@.0, @.25, @0.5, @0.75, @1.0];
    // self.animation.calculationMode = kCAAnimationPaced;
    self.animation.path = path;
    
    return path;
}

@end
