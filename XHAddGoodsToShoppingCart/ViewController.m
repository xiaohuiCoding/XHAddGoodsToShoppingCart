//
//  ViewController.m
//  XHAddGoodsToShoppingCart
//
//  Created by xiaohui on 2017/11/10.
//  Copyright © 2017年 XIAOHUI. All rights reserved.
//

#import "ViewController.h"
#import "XHAddGoods.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _imageView.image = [UIImage imageNamed:@"fish"];
    [self.view addSubview:_imageView];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(240, 300, 40, 40);
    [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_button setTitle:@"add" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(addToShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

- (void)addToShoppingCart
{
    XHAddGoods *addGoods = [[XHAddGoods alloc] init];
    [addGoods startAnimationandView:_imageView withBeginRect:CGRectMake(100, 100, 0, 0) andEndPoint:CGPointMake(240, 300) completion:^(BOOL v) {
        [self shakeAnimation:_button];
    }];
}

/**
 *  摇晃动画
 *  @param shakeView   添加动画的view
 */
- (void)shakeAnimation:(UIView *)shakeView
{
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:5];
    shakeAnimation.autoreverses = YES;
    [shakeView.layer addAnimation:shakeAnimation forKey:nil];
}

@end
