//
//  QFNewsCell.m
//  wangyiNews
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import "QFNewsCell.h"
#import "QFContentNews.h"
#import <UIImageView+WebCache.h>

@interface QFNewsCell ()
/**
 *  图片
 */
@property (nonatomic, weak) IBOutlet UIImageView *iconView;
/**
 *  标题
 */
@property (nonatomic, weak) IBOutlet UILabel *titleLable;
/**
 *  摘要
 */
@property (nonatomic, weak) IBOutlet UILabel *digestLable;
/**
 *  点击数
 */
@property (nonatomic, weak) IBOutlet UILabel *replyCountLabel;
/**
 *   图片组
 */
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArr;


@end
@implementation QFNewsCell

- (void)setContentNews:(QFContentNews *)contentNews {
    _contentNews = contentNews;
    // 设置标题
    self.titleLable.text = contentNews.title;
    // 摘要
    self.digestLable.text = contentNews.digest;
    // 点击数
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@跟帖",contentNews.replyCount];
    // 设置图片
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:contentNews.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
    // 遍历多图数组
    [contentNews.imgextra enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        // 获取图片
        UIImageView *image = self.imageArr[idx];
        // 获取图片url字符串
        NSString *imageUrl = dict[@"imgsrc"];
        [image sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
    }];
}

/**
 *  返回cell 对应的从用标示
 */
+ (NSString *)cellIdentifier:(QFContentNews *)contentNews {
    if (contentNews.imgextra) {
        return @"cell2";
    } else if (contentNews.imgType){
        return @"cell3";
    } else {
        return @"cell1";
    }
}

/**
 *  返回cell 对应的高度
 */
+ (CGFloat)cellHeight:(QFContentNews *)contentNews {
    if (contentNews.imgextra ) {
        return 130.0;
    } else if (contentNews.imgType) {
        return 150.0;
    } else {
        return 80.0;
    }
}

@end
