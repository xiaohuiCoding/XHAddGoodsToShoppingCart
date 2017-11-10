//
//  XHAddGoods.h
//  XHAddToShoppingCart
//
//  Created by xiaohui on 2017/11/10.
//  Copyright © 2017年 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AnimationFinishBlock)(BOOL);

@interface XHAddGoods : NSObject

@property (nonatomic, copy) AnimationFinishBlock animationFinishBlock;

- (void)startAnimationandView:(UIView *)view withBeginRect:(CGRect)beginRect andEndPoint:(CGPoint)endPoint completion:(AnimationFinishBlock)animationFinishBlock;

@end
