//
//  QiViewController.m
//  QiKeyFrameAnimation
//
//  Created by huangxianshuai on 2018/10/30.
//  Copyright © 2018年 qishare. All rights reserved.
//

#import "QiViewController.h"

@interface QiViewController ()

@property (nonatomic, strong) CABasicAnimation *layerAnimation;

@end

@implementation QiViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 初始化网格
    CGFloat minSide = fminf(self.view.bounds.size.width, self.view.bounds.size.height);
    _squareSide = minSide / 10;
    
    NSUInteger rowCount = (NSUInteger)(self.view.bounds.size.height / _squareSide);
    NSUInteger columnCount = (NSUInteger)(self.view.bounds.size.width / _squareSide);
    
    for (NSUInteger i = 0; i < rowCount; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(.0, i * _squareSide, self.view.bounds.size.width, .5)];
        line.backgroundColor = [UIColor blackColor];
        [self.view addSubview:line];
    }
    for (NSUInteger i = 0; i < columnCount; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(i * _squareSide, .0, .5, self.view.bounds.size.height)];
        line.backgroundColor = [UIColor blackColor];
        [self.view addSubview:line];
    }
    
    // 初始化imageView
    _imageView = [[UIImageView alloc] initWithFrame:(CGRect){.0, .0, _squareSide, _squareSide}];
    _imageView.center = CGPointMake(.0, .0);
    _imageView.image = [UIImage imageNamed:@"logo_qishare"];
    [self.view addSubview:_imageView];
    
    // 初始化动画
    _animation = [CAKeyframeAnimation animation];
    _animation.keyPath = @"position";
    _animation.duration = 10.0;
    _animation.repeatCount = 1.0;
    _animation.removedOnCompletion = NO;
    _animation.fillMode = kCAFillModeForwards;
    _animation.delegate = self;
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // shape layer
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.lineWidth = 2.0;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    // shape layer的动画
    _layerAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _layerAnimation.fromValue = @.0;
    _layerAnimation.toValue = @1.0;
    _layerAnimation.delegate = self;
    _layerAnimation.duration = self.animation.duration;
    _layerAnimation.timingFunction = self.animation.timingFunction;
}


#pragma mark - Public functions

- (void)startAnimation:(BOOL)start {
    
    if (start) {
        [_imageView.layer addAnimation:_animation forKey:@"animation"];
    }
    else {
        [_imageView.layer removeAnimationForKey:@"animation"];
    }
    
    if (start) {
        [self.view.layer addSublayer:_shapeLayer];
        [_shapeLayer addAnimation:_layerAnimation forKey:@"animation"];
    }
    else {
        [_shapeLayer removeFromSuperlayer];
        [_shapeLayer removeAnimationForKey:@"animation"];
    }
}


#pragma mark - Action functions

- (IBAction)startAnimationButtonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;

    [self startAnimation:sender.selected];
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    
    NSLog(@"%s", __func__);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"%s", __func__);
}

@end
