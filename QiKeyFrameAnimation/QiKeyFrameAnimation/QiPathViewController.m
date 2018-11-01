//
//  QiPathViewController.m
//  QiKeyFrameAnimation
//
//  Created by huangxianshuai on 2018/10/30.
//  Copyright © 2018年 qishare. All rights reserved.
//

#import "QiPathViewController.h"

@interface QiPathViewController () <CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CABasicAnimation *layerAnimation;

@end

@implementation QiPathViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGMutablePathRef animationPath = CGPathCreateMutable();
    
#if 0
    CGPathMoveToPoint(animationPath, NULL, self.imageView.center.x, self.imageView.center.y);
    CGPathAddLineToPoint(animationPath, NULL, self.squareSide * 2, self.squareSide * 2);
    CGPathAddLineToPoint(animationPath, NULL, self.squareSide * 2, self.squareSide * 4);
    CGPathAddLineToPoint(animationPath, NULL, self.squareSide * 4, self.squareSide * 4);
    CGPathAddLineToPoint(animationPath, NULL, self.squareSide * 4, self.squareSide * 6);
#endif
    
    self.animation.delegate = self;
    CGRect drawRect = (CGRect){self.squareSide, self.squareSide, self.squareSide * 8, self.squareSide * 6};
    self.imageView.center = CGPointMake(drawRect.origin.x + drawRect.size.width, drawRect.origin.y + drawRect.size.height / 2);
    CGPathAddEllipseInRect(animationPath, NULL, drawRect);
    self.animation.path = animationPath;
    CGPathRelease(animationPath);
    
    CALayer *bglayer = [CALayer layer];
    bglayer.frame = drawRect;
    bglayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer insertSublayer:bglayer atIndex:0];

    CGMutablePathRef layerPath = CGPathCreateMutable();
    CGPathAddEllipseInRect(layerPath, NULL, drawRect);
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.path = layerPath;
    _shapeLayer.lineWidth = 2.0;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    _layerAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _layerAnimation.fromValue = @.0;
    _layerAnimation.toValue = @1.0;
    _layerAnimation.delegate = self;
    _layerAnimation.duration = self.animation.duration;
    _layerAnimation.timingFunction = self.animation.timingFunction;
}


#pragma mark - Overwrite functions

- (void)startAnimation:(BOOL)start {
    
    [super startAnimation:start];
    
    if (start) {
        [self.view.layer insertSublayer:_shapeLayer atIndex:1];
        [_shapeLayer addAnimation:_layerAnimation forKey:@"animation"];
    }
    else {
        [_shapeLayer removeFromSuperlayer];
        [_shapeLayer removeAnimationForKey:@"animation"];
    }
}



#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    
    NSLog(@"%s", __func__);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"%s", __func__);
}

@end
