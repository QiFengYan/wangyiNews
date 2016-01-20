//
//  QFTool.m
//  wangyiNews
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import "QFTool.h"

@implementation QFTool
/**
 *  返回一个单例对象
 */
+ (instancetype)shareTool {
    static QFTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /*
         http://c.m.163.com/nc/ad/headline/0-4.html
         http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html
         */
        // 设置基地址
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        // 创建会话配置对象
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 设置请求时长
        config.timeoutIntervalForRequest = 15.0;
        instance = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:nil];
        
        // 设置响应解析数据的类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return instance;
}

@end
