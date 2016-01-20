//
//  QFHeadNew.h
//  wangyiNews
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFHeadNew : NSObject
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  快速创建对象
 */
+ (instancetype)headNewWithDict:(NSDictionary *)dict;


+ (void)headLineWithSuccess:(void(^)(NSArray *headLines))succeses error:(void (^)(NSError *error))error;

@end
