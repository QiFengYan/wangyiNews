//
//  QFHeadLineCell.m
//  wangyiNews
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import "QFHeadLineCell.h"
#import <UIImageView+WebCache.h>
#import "QFHeadNew.h"
@interface QFHeadLineCell ()
/**
 *  图片
 */
@property (nonatomic, weak) IBOutlet UIImageView *iconView;

@end

@implementation QFHeadLineCell

- (void)setHeadLine:(QFHeadNew *)headLine {
    _headLine = headLine;
    // 设置图片 
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:headLine.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
}



@end
