//
//  QFHeadNew.m
//  wangyiNews
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import "QFHeadNew.h"
#import "QFTool.h"
@implementation QFHeadNew
/**
 *  快速创建对象昂
 */
+ (instancetype)headNewWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}


+ (void)headLineWithSuccess:(void(^)(NSArray *headLines))succeses error:(void (^)(NSError *error))error {
    [[QFTool shareTool] GET:@"ad/headline/0-4.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        // 获得数组
        NSString *rootKet = responseObject.keyEnumerator.nextObject;
        NSArray *dictArr = responseObject[rootKet];
        // 创建可变模型数组
        NSMutableArray *headLines = [NSMutableArray array];
        // 遍历数组
        [dictArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 字典转模型
            QFHeadNew *headNew = [QFHeadNew headNewWithDict:obj];
            [headLines addObject:headNew];
            
        }];
        // 将结果传递给调用方
        if (succeses) {
            succeses(headLines.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull er) {
        // 错误回调
        if (error) {
            error(er);
        }
    }];
}

@end
