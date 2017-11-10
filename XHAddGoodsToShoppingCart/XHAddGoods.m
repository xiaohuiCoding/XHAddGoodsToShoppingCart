//
//  XHAddGoods.m
//  XHAddToShoppingCart
//
//  Created by xiaohui on 2017/11/10.
//  Copyright © 2017年 XIAOHUI. All rights reserved.
//

#import "XHAddGoods.h"
#import "AppDelegate.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface XHAddGoods ()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *layer;

@end

@implementation XHAddGoods

/**
 *  开始动画
 *
 *  @param view        添加动画的view
 *  @param beginRect        view的绝对frame
 *  @param endPoint 动画终点位置
 *  @param animationFinishBlock 动画完成回调
 */

- (void)startAnimationandView:(UIView *)view withBeginRect:(CGRect)beginRect andEndPoint:(CGPoint)endPoint completion:(AnimationFinishBlock)animationFinishBlock
{
    //创建一个图层
    _layer = [CALayer layer];
    _layer.contents = view.layer.contents;
    _layer.contentsGravity = kCAGravityResizeAspect;
    
    beginRect.size.width = 60;
    beginRect.size.height = 60;
    _layer.bounds = beginRect; //设置图层动画初始时的大小
//    _layer.cornerRadius = beginRect.size.width/2;
//    _layer.masksToBounds = YES;
    _layer.position = CGPointMake(beginRect.origin.x+view.frame.size.width/2, CGRectGetMidY(beginRect)); //位置
    UIBezierPath *path = [UIBezierPath bezierPath]; //路径
    [path moveToPoint:_layer.position];
    [path addQuadCurveToPoint:endPoint controlPoint:CGPointMake(ScreenWidth/2 , beginRect.origin.y-80)]; //设置抛物线的最高点
    
    //动画1：关键帧
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;
    
    //动画2：变小
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)]; //设置 X 轴和 Y 轴缩放比例都为1.0，而 Z 轴不变
    
    //动画3：旋转
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:12];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //动画组（包含几个子动画）
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathAnimation,transformAnimation,rotateAnimation]; //变小动画需加在旋转动画前面
    groups.duration = 1.0;
    groups.removedOnCompletion = NO; //设置之后做动画的layer不会回到一开始的位置
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self; //设置代理（指定本类作为代理）
    [_layer addAnimation:groups forKey:@"group"];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window.layer addSublayer:_layer];
    
    if (animationFinishBlock) {
        _animationFinishBlock = animationFinishBlock;
    }
}

#pragma mark - CAAnimationDelegate

//在动画结束的时候让layer消失
- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    if (animation == [_layer animationForKey:@"group"]) {
        
        [_layer removeFromSuperlayer];
        _layer = nil;
        
        if (_animationFinishBlock) {
            _animationFinishBlock(YES);
        }
    }
}

@end
