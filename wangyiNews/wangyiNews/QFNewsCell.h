//
//  QFNewsCell.h
//  wangyiNews
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QFContentNews;
@interface QFNewsCell : UITableViewCell

@property (nonatomic, strong) QFContentNews *contentNews;

/**
 *  返回cell 对应的从用标示
 */
+ (NSString *)cellIdentifier:(QFContentNews *)contentNews;

/**
 *  返回cell 对应的高度
 */
+ (CGFloat)cellHeight:(QFContentNews *)contentNews;

@end
