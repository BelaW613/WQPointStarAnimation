//
//  ViewController.m
//  WQPointStarAnimation
//
//  Created by qian wan on 2017/5/8.
//  Copyright © 2017年 qian wan. All rights reserved.
//

#import "ViewController.h"

//ios10 以后需要遵守CAAnimationDelegate
#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface ViewController ()<CAAnimationDelegate>
{
    UIButton *btnZan;
    UILabel *labZanAddOne;
    NSInteger isSelect;
}
@end
#else
@interface ViewController ()
{
    UIButton *btnZan;
    UILabel *labZanAddOne;
    NSInteger isSelect;
}
@end
#endif



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initalizeUserInterface];
}


- (void)initalizeUserInterface
{
    //点赞
    btnZan = [UIButton buttonWithType:UIButtonTypeCustom];
    btnZan.frame = CGRectMake(100, 100, 80, 20);
    
    [btnZan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [btnZan setImage:[UIImage imageNamed:@"zan_g"] forState:UIControlStateNormal];
    [btnZan setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateHighlighted];
    [btnZan setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateSelected];
    [btnZan setTitle:@"0" forState:UIControlStateNormal];
    [btnZan setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [btnZan setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 0)];
    btnZan.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnZan addTarget:self action:@selector(btnZanClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZan];
    
    //点赞+1
    labZanAddOne = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 80, 20)];
    labZanAddOne.text = @"+ 1";
    labZanAddOne.textColor = [UIColor orangeColor];
    labZanAddOne.textAlignment = NSTextAlignmentCenter;
    labZanAddOne.font = [UIFont systemFontOfSize:15];
    labZanAddOne.alpha = 0;
    [self.view addSubview:labZanAddOne];
    
}

- (void)btnZanClick:(UIButton *)sender
{
    if (!isSelect) {
        isSelect = 1;
        sender.selected = !sender.selected;
    }
    
    [btnZan setTitle:[NSString stringWithFormat:@"%ld",[btnZan.titleLabel.text integerValue]+1] forState:UIControlStateNormal];
    //添加点赞动画
    [self addZanAnimation];
    
}

- (void)addZanAnimation
{
    //关键帧动画
    //用动画完成放大的效果
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //需要给他设置一个关键帧的值,这个值就是变化过程
    //values是一个数组
    animation.values=@[@(0.5),@(1.0),@(1.5)];
    //设置动画的时长
    animation.duration=0.2;
    //加到button上
    [btnZan.layer addAnimation:animation forKey:@"animation"];
    
    if (btnZan.selected == NO) {
        [btnZan setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    }else{
        [btnZan setImage:[UIImage imageNamed:@"zan_g"] forState:UIControlStateNormal];
    }
    
    labZanAddOne.alpha = 1;
    CAKeyframeAnimation *animation2=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //需要给他设置一个关键帧的值,这个值就是变化过程
    //values是一个数组
    animation2.values=@[@(0.4),@(0.6),@(1.0),@(1.4)];
    //设置动画的时长
    animation2.duration=0.4;
    animation2.delegate = self;
    //加到button上
    [labZanAddOne.layer addAnimation:animation2 forKey:@"animation"];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    //clearMemory
    //结束事件
    
    labZanAddOne.alpha = 0;
    
}

@end
