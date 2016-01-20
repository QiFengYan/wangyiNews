//
//  QFNewsChannel.m
//  wangyiNews
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//   [NSTaggedPointerString countByEnumeratingWithState:objects:count:];

#import "QFNewsChannel.h"

@implementation QFNewsChannel

+ (instancetype)newsChannelWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
   
    return obj;
}

- (void)setTid:(NSString *)tid {
    _tid = tid;
    self.URLString = [NSString stringWithFormat:@"article/list/%@/0-140.html",tid];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}



+ (NSArray *)newsChannel {
    // 加载json文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    // 转换为data
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 解析 获取数组
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *channels = dict[@"tList"];
    // 创建可变数组模型
    NSMutableArray *tempArr = [NSMutableArray array];
    // 遍历数组
    for (NSDictionary *dict in channels) {
        QFNewsChannel *channel = [QFNewsChannel newsChannelWithDict:dict];
        // 字典转模型
        [tempArr addObject:channel];
    }
    
    // 排序
    return [tempArr sortedArrayUsingComparator:^NSComparisonResult(QFNewsChannel *  _Nonnull obj1, QFNewsChannel *  _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    
}

@end
