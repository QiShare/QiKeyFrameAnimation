//
//  QiViewController.h
//  QiKeyFrameAnimation
//
//  Created by huangxianshuai on 2018/10/30.
//  Copyright © 2018年 qishare. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QiViewController : UIViewController

@property (nonatomic, strong) CAKeyframeAnimation *animation;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat squareSide;

@property (nonatomic, strong) UIBezierPath *bezierPath;

@end

NS_ASSUME_NONNULL_END
