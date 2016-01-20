//
//  QFChannelCell.m
//  wangyiNews
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import "QFChannelCell.h"
#import "QFNewsController.h"
#import "QFNewsChannel.h"
@interface QFChannelCell ()



@end

@implementation QFChannelCell



- (void)setNewsVc:(QFNewsController *)newsVc {
    _newsVc = newsVc;
    [self addSubview:newsVc.view];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置控制器的frame
    self.newsVc.view.frame = self.bounds;
}


@end
