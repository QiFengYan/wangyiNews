//
//  QFChannelLable.h
//  wangyiNews
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFChannelLable : UILabel


+ (instancetype)lableWithTitle:(NSString *)title;

/**
 *   缩放比例
 */
@property (nonatomic, assign) CGFloat scale;


@property (nonatomic, copy) void (^lableSelectedBlock)();
@end
