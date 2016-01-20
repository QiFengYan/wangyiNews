//
//  QFContentNews.m
//  wangyiNews
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import "QFContentNews.h"
#import "QFTool.h"

@implementation QFContentNews


+ (instancetype)contentNewsWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

/**
 *  加载新闻数据
 *
 *  @param succeses 完成回调
 *  @param error    错误回调
 */
+ (void)contentNewsWithURLString:(NSString *)URLString Success:(void(^)(NSArray *contentNews))succeses error:(void (^)(NSError *error))error {
    //@"article/headline/T1348647853363/0-140.html"
    [[QFTool shareTool] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        // 获得数组
        NSString *rootKet = responseObject.keyEnumerator.nextObject;
        NSArray *newsArr = responseObject[rootKet];
        // 创建可变模型数组
        NSMutableArray *tempArr = [NSMutableArray array];
        // 遍历数组
        [newsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           // 字典转模型
            [tempArr addObject:[QFContentNews contentNewsWithDict:obj]];
        }];
        // 将结果传递给调用方
        if (succeses) {
            succeses(tempArr);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull er) {
        // 将错误结果返回
        if (error) {
            error(er);
        }
        NSLog(@"%@",er);
    }];
}

@end
