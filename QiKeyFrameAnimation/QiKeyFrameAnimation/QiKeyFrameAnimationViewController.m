//
//  QiKeyFrameAnimationViewController.m
//  QiKeyFrameAnimation
//
//  Created by QiShare on 2018/8/24.
//  Copyright © 2018年 QiShare. All rights reserved.
/** 参考学习网址：
* https://developer.apple.com/documentation/quartzcore/cakeyframeanimation?language=objc
* http://www.16xx8.com/photoshop/jiaocheng/2014/133973.html
* https://www.jianshu.com/p/51c417a1a60b
* https://blog.csdn.net/Cloudox_/article/details/64924176
* https://blog.csdn.net/zhouleizhao/article/details/38224189
 */

#import "QiKeyFrameAnimationViewController.h"

@implementation QiKeyFrameAnimationViewController {
    
    UIImageView *_topCameraImageView;
    UIImageView *_centerCameraImageView;
    UIImageView *_bottomBasketBallImageView;
    CFTimeInterval _topAnimaStartPauseTime;
    CFTimeInterval _centerAnimaStartPauseTime;
    CFTimeInterval _bottomAnimaStartPauseTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)dealloc {
    
    NSLog(@"%s",__func__);
}


#pragma mark - Private functions

- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    
    UIView *barBackgroundView = [[self.navigationController.navigationBar subviews] objectAtIndex:0];
    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];
    if (self.navigationController.navigationBar.isTranslucent) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            barBackgroundView.alpha = alpha;
        } else {
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
            }
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

- (void)setupUI {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"CAKeyframeAnimation";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self setNeedsNavigationBackground:0.2];
    
    [self drawCircle];
    [self setupCameraBasketballUI];
}

- (void)drawCircle {
    
    CGFloat topRadius = 80.0;
    CAShapeLayer *topCircleLayer = [CAShapeLayer layer];
    topCircleLayer.strokeColor = [UIColor yellowColor].CGColor;
    topCircleLayer.lineWidth = 8.0;
    topCircleLayer.fillColor = [UIColor clearColor].CGColor;
    BOOL clockWise = YES;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.view.frame), 90.0) radius:topRadius startAngle:.0 endAngle:M_PI * 2.0 clockwise:clockWise];
    topCircleLayer.path = circlePath.CGPath;
    [self.view.layer addSublayer:topCircleLayer];
    
    CGFloat centerRadius = 80.0;
    CAShapeLayer *centerCircleLayer = [CAShapeLayer layer];
    centerCircleLayer.strokeColor = [UIColor blueColor].CGColor;
    centerCircleLayer.lineWidth = 8.0;
    centerCircleLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *centerCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.view.frame), 280.0) radius:centerRadius startAngle:.0 endAngle:M_PI * 2.0 clockwise:clockWise];
    centerCircleLayer.path = centerCirclePath.CGPath;
    [self.view.layer addSublayer:centerCircleLayer];
    
    CAShapeLayer *bottomCircleLayer = [CAShapeLayer layer];
    bottomCircleLayer.strokeColor = [UIColor redColor].CGColor;
    bottomCircleLayer.lineWidth = 8.0;
    bottomCircleLayer.fillColor = [UIColor clearColor].CGColor;
    
    CGPoint bottomPoint = self.view.center;
    bottomPoint.y += 150.0;
    CGFloat bottomRadius = 130;
    UIBezierPath *bottomCirclePath = [UIBezierPath bezierPathWithArcCenter:bottomPoint radius:bottomRadius startAngle:.0 endAngle:M_PI * 2.0 clockwise:clockWise];
    bottomCircleLayer.path = bottomCirclePath.CGPath;
    [self.view.layer addSublayer:bottomCircleLayer];
}

- (void)setupCameraBasketballUI {
    
    _topAnimaStartPauseTime = .0;
    _centerAnimaStartPauseTime = .0;
    _bottomAnimaStartPauseTime = .0;
    
    _topCameraImageView = [UIImageView new];
    [self.view addSubview:_topCameraImageView];
    _topCameraImageView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"360cameraGood"].CGImage);
    _topCameraImageView.frame = CGRectMake(.0, .0, 80.0, 80.0);
    _topCameraImageView.center = CGPointMake(self.view.center.x, 80.0);
    
    _centerCameraImageView = [UIImageView new];
    [self.view addSubview:_centerCameraImageView];
    _centerCameraImageView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"360cameraGood"].CGImage);
    _centerCameraImageView.frame = CGRectMake(.0, .0, 80.0, 80.0);
    _centerCameraImageView.center = CGPointMake(self.view.center.x, 290.0);
    
    _bottomBasketBallImageView = [UIImageView new];
    [self.view addSubview:_bottomBasketBallImageView];
    _bottomBasketBallImageView.frame = CGRectMake(.0, .0, 80.0, 80.0);
    _bottomBasketBallImageView.center = CGPointMake(self.view.center.x + 130, self.view.center.y);
    _bottomBasketBallImageView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"basketball"].CGImage);
    _bottomBasketBallImageView.image = [UIImage imageNamed:@"basketball"];
    
    UIButton *startAnimationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startAnimationBtn];
    startAnimationBtn.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 50.0, CGRectGetMidY(self.view.frame) + 100.0, 100.0, 40.0);
    [startAnimationBtn setTitle:@"开始动画" forState:UIControlStateNormal];
    startAnimationBtn.backgroundColor = [UIColor grayColor];
    [startAnimationBtn addTarget:self action:@selector(startAnimationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *stopAnimationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:stopAnimationBtn];
    stopAnimationBtn.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 50.0, CGRectGetMidY(self.view.frame) + 150.0, 100.0, 40.0);
    [stopAnimationBtn setTitle:@"暂停动画" forState:UIControlStateNormal];
    [stopAnimationBtn setTitle:@"继续动画" forState:UIControlStateSelected];
    stopAnimationBtn.backgroundColor = [UIColor grayColor];
    [stopAnimationBtn addTarget:self action:@selector(pauseContinueAnimationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *removeAnimationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:removeAnimationBtn];
    removeAnimationBtn.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 50.0, CGRectGetMidY(self.view.frame) + 200.0, 100.0, 40.0);
    [removeAnimationBtn setTitle:@"移除动画" forState:UIControlStateNormal];
    removeAnimationBtn.backgroundColor = [UIColor grayColor];
    [removeAnimationBtn addTarget:self action:@selector(removeAnimationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}


/**开始动画*/
- (void)animateCameraBasketball {
    
    if ([_topCameraImageView.layer animationForKey:@"orbit"] || [_centerCameraImageView.layer animationForKey:@"orbit"] || [_bottomBasketBallImageView.layer animationForKey:@"position"]) {
        return;
    }
    
    CGRect topboundingRect = CGRectMake(-80.0, -80.0, 170.0, 170.0);
    CAKeyframeAnimation *topCircleAnima = [CAKeyframeAnimation animation];
    topCircleAnima.keyPath = @"position";
    topCircleAnima.path = CFAutorelease(CGPathCreateWithEllipseInRect(topboundingRect, NULL));
    topCircleAnima.duration = 4;
     topCircleAnima.additive = YES; // 控制是参考当前位置的情况来说 还是参考着(0,0)的位置来说
    topCircleAnima.repeatCount = CGFLOAT_MAX;
    topCircleAnima.calculationMode = kCAAnimationPaced;
    topCircleAnima.rotationMode = kCAAnimationRotateAuto;

    [_topCameraImageView.layer addAnimation:topCircleAnima forKey:@"orbit"];

    CGRect centerBoundingRect = CGRectMake(-80.0, -80.0, 170.0, 170.0);
    CAKeyframeAnimation *centerCircleAnima = [CAKeyframeAnimation animation];
    centerCircleAnima.keyPath = @"position";
    centerCircleAnima.path = CFAutorelease(CGPathCreateWithEllipseInRect(centerBoundingRect, NULL));
    centerCircleAnima.duration = 4;
    centerCircleAnima.additive = YES;
    centerCircleAnima.repeatCount = CGFLOAT_MAX;
    centerCircleAnima.calculationMode = kCAAnimationPaced;
    centerCircleAnima.rotationMode = kCAAnimationRotateAutoReverse;

    [_centerCameraImageView.layer addAnimation:centerCircleAnima forKey:@"orbit"];

    CGPoint bottomPoint = self.view.center;
    bottomPoint.y += 150.0;
    CGMutablePathRef arcPathM = CGPathCreateMutable();
    CGPathMoveToPoint(arcPathM, NULL, bottomPoint.x + 130, bottomPoint.y);
    CGPathAddCurveToPoint(arcPathM, NULL, bottomPoint.x + 130, bottomPoint.y, bottomPoint.x, bottomPoint.y - 360.0, bottomPoint.x - 130, bottomPoint.y);
    CGPathAddCurveToPoint(arcPathM, NULL, bottomPoint.x - 130, bottomPoint.y, bottomPoint.x, bottomPoint.y - 360.0, bottomPoint.x + 130, bottomPoint.y);
    CAKeyframeAnimation *keyframeAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframeAnim.rotationMode = kCAAnimationRotateAutoReverse;
    keyframeAnim.repeatCount = CGFLOAT_MAX;
    keyframeAnim.path = arcPathM;
    keyframeAnim.duration = 4.0;
    keyframeAnim.removedOnCompletion = NO;
    keyframeAnim.fillMode = kCAFillModeForwards;
    [_bottomBasketBallImageView.layer addAnimation:keyframeAnim forKey:@"position"];
    
    _topCameraImageView.layer.speed = 1.0;
    _centerCameraImageView.layer.speed = 1.0;
    _bottomBasketBallImageView.layer.speed = 1.0;
}


/**暂停动画*/
- (void)pauseCameraBasketballAnima {
    
    if ((_topCameraImageView.layer.speed == .0 || _centerCameraImageView.layer.speed == .0 || _bottomBasketBallImageView.layer.speed == .0)) {
        return;
    }
  
    _topAnimaStartPauseTime = [_topCameraImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    _centerAnimaStartPauseTime = [_centerCameraImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    _bottomAnimaStartPauseTime = [_bottomBasketBallImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    _topCameraImageView.layer.timeOffset = _topAnimaStartPauseTime;
    _centerCameraImageView.layer.timeOffset = _centerAnimaStartPauseTime;
    _bottomBasketBallImageView.layer.timeOffset = _bottomAnimaStartPauseTime;

    _topCameraImageView.layer.speed = .0;
    _centerCameraImageView.layer.speed = .0;
    _bottomBasketBallImageView.layer.speed = .0;
}

/**继续动画*/
- (void)continueCameraBasketballAnima {
    
    if ((_topCameraImageView.layer.speed == 1.0 || _centerCameraImageView.layer.speed == 1.0 || _bottomBasketBallImageView.layer.speed == 1.0)) {
        return;
    }
    _topCameraImageView.layer.beginTime = _topAnimaStartPauseTime;
    _centerCameraImageView.layer.beginTime = _centerAnimaStartPauseTime;
    _bottomBasketBallImageView.layer.beginTime = _bottomAnimaStartPauseTime;
    _topCameraImageView.layer.speed = 1.0;
    _centerCameraImageView.layer.speed = 1.0;
    _bottomBasketBallImageView.layer.speed = 1.0;

}

/**移除动画*/
- (void)removeCameraBasketballAnima {
    
    [self continueCameraBasketballAnima];
    [_topCameraImageView.layer removeAnimationForKey:@"orbit"];
    [_centerCameraImageView.layer removeAnimationForKey:@"orbit"];
    [_bottomBasketBallImageView.layer removeAnimationForKey:@"position"];
}


#pragma mark - Action functions

- (void)startAnimationButtonClicked:(UIButton *)sender {
    
    [self animateCameraBasketball];
}

- (void)pauseContinueAnimationButtonClicked:(UIButton *)sender {
    
    if (![_topCameraImageView.layer animationForKey:@"orbit"] || ![_centerCameraImageView.layer animationForKey:@"orbit"] || ![_bottomBasketBallImageView.layer animationForKey:@"position"]) {
        return;
    }
    if (!sender.selected) {
        [self pauseCameraBasketballAnima];
    } else {
        [self continueCameraBasketballAnima];
    }
    sender.selected = !sender.selected;
    
}

- (void)removeAnimationButtonClicked:(UIButton *)sender {

    [self removeCameraBasketballAnima];
}

@end






























