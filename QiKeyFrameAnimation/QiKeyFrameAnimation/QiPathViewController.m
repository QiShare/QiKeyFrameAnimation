//
//  QiPathViewController.m
//  QiKeyFrameAnimation
//
//  Created by huangxianshuai on 2018/10/30.
//  Copyright © 2018年 qishare. All rights reserved.
//

#import "QiPathViewController.h"

@interface QiPathViewController () 

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CABasicAnimation *layerAnimation;

@end

@implementation QiPathViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 背景layer
    CGRect drawRect = (CGRect){self.squareSide, self.squareSide, self.squareSide * 8, self.squareSide * 8};
    CALayer *bglayer = [CALayer layer];
    bglayer.frame = drawRect;
    bglayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer insertSublayer:bglayer atIndex:0];
    
    // imageview 的初始位置
    self.imageView.center = CGPointMake(drawRect.origin.x + drawRect.size.width, drawRect.origin.y + drawRect.size.height / 2);
#if 0
    CGPathMoveToPoint(animationPath, NULL, self.imageView.center.x, self.imageView.center.y);
    CGPathAddLineToPoint(animationPath, NULL, self.squareSide * 2, self.squareSide * 2);
    CGPathAddLineToPoint(animationPath, NULL, self.squareSide * 2, self.squareSide * 4);
    CGPathAddLineToPoint(animationPath, NULL, self.squareSide * 4, self.squareSide * 4);
    CGPathAddLineToPoint(animationPath, NULL, self.squareSide * 4, self.squareSide * 6);
#endif
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddEllipseInRect(path, NULL, drawRect);
//    CGPathAddArc(path, NULL, CGRectGetMidX(drawRect), CGRectGetMidY(drawRect), drawRect.size.width/2, 0, 2*M_PI, NO);
    
    
    {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.path = path;
        _shapeLayer.lineWidth = 2.0;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    
    self.animation.path = path;
    CGPathRelease(path);
    
    {
        _layerAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _layerAnimation.fromValue = @.0;
        _layerAnimation.toValue = @1.0;
        _layerAnimation.delegate = self;
        _layerAnimation.duration = self.animation.duration;
        _layerAnimation.timingFunction = self.animation.timingFunction;
    }
}


#pragma mark - Overwrite functions

- (void)startAnimation:(BOOL)start {
    
    [super startAnimation:start];
    
    if (start) {
        [self.view.layer addSublayer:_shapeLayer];
        [_shapeLayer addAnimation:_layerAnimation forKey:@"animation"];
    }
    else {
        [_shapeLayer removeFromSuperlayer];
        [_shapeLayer removeAnimationForKey:@"animation"];
    }
}


@end
