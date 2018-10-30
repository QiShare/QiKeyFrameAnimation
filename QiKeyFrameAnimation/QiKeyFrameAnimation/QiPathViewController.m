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
    
#if 0
    CGPathMoveToPoint(path, NULL, self.imageView.center.x, self.imageView.center.y);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 2, self.squareSide * 2);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 2, self.squareSide * 4);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 4, self.squareSide * 4);
    CGPathAddLineToPoint(path, NULL, self.squareSide * 4, self.squareSide * 6);
#endif
    
    CGRect drawRect = (CGRect){self.squareSide, self.squareSide, self.squareSide * 8, self.squareSide * 8};
    
    CGPathAddEllipseInRect(path, NULL, drawRect);
    self.animation.path = path;
    CGPathRelease(path);
    [self.imageView.layer addAnimation:self.animation forKey:@"animation"];
    
    
    CALayer *bglayer = [CALayer layer];
    bglayer.frame = drawRect;
    bglayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer insertSublayer:bglayer atIndex:0];

    CGFloat side = drawRect.size.width;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(drawRect.size.width / 2, drawRect.size.width / 2) radius:side / 2 startAngle:.0 endAngle:2 * M_PI clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.lineWidth = 5.0;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [bglayer insertSublayer:shapeLayer above:bglayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @.0;
    animation.toValue = @1.0;
    animation.duration = self.animation.duration * .8;
    [shapeLayer addAnimation:animation forKey:@"animation"];
}

@end
