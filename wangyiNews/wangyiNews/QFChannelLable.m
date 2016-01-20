//
//  QFChannelLable.m
//  wangyiNews
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//
#define QFBigFont 18
#define QFSmallFont 14
#import "QFChannelLable.h"

@implementation QFChannelLable

+ (instancetype)lableWithTitle:(NSString *)title {
    // 创建标题
    QFChannelLable *lable = [[QFChannelLable alloc] init];
    lable.text = title;
    // 设置字体大小
    lable.font = [UIFont systemFontOfSize:QFBigFont];
    // 自适应控件
    [lable sizeToFit];
    // 设置小字体
    lable.font = [UIFont systemFontOfSize:QFSmallFont];
    lable.userInteractionEnabled = YES;
    return lable;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.lableSelectedBlock) {
        self.lableSelectedBlock();
    }
}

-(void)setScale:(CGFloat)scale{
    _scale = scale;
    CGFloat percent = (CGFloat)(QFBigFont - QFSmallFont) / QFSmallFont;
    // 计算真实比例
    percent = percent * scale + 1;
    self.transform = CGAffineTransformMakeScale(percent, percent);
    // 设置颜色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    
//    NSLog(@"%f",scale);
}

@end
