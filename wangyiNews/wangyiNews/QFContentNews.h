//
//  QFContentNews.h
//  wangyiNews
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import <Foundation/Foundation.h>


//postid	:	BD70S60Q00234L7P
//
//url_3w	:	http://help.3g.163.com/16/0113/10/BD70S60Q00234L7P.html
//
//votecount	:	1528
//
//replyCount	:	3154
//
//skipID	:	S1451880983492
//
//digest	:	习近平的愿景和决心，尤其反腐工作他做得特别好。
//
//skipType	:	special
//
//url	:	http://3g.163.com/ntes/16/0113/10/BD70S60Q00234L7P.html
//
//specialID	:	S1451880983492
//
//docid	:	BD70S60Q00234L7P
//
//title	:	国际社会盛赞习近平从严治党
//
//source	:	中国日报网
//
//priority	:	220
//
//lmodify	:	2016-01-13 15:36:24
//
//boardid	:	news_gov_bbs
//
//subtitle	:
//
//imgsrc	:	http://img3.cache.netease.com/3g/2016/1/13/2016011310273334f7d.jpg
//
//ptime	:	2016-01-13 10:19:30

@interface QFContentNews : NSObject

//http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html

/**
 *  跟帖数
 */
@property (nonatomic, strong) NSNumber *replyCount;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  新闻图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  多图数组
 */
@property (nonatomic, strong) NSArray *imgextra;
/**
 *   显示大图
 */
@property (nonatomic, assign) BOOL imgType;



/**
 *  快速创建对象
 */
+ (instancetype)contentNewsWithDict:(NSDictionary *)dict;

/**
 *  加载新闻数据
 *
 *  @param succeses 完成回调
 *  @param error    错误回调
 */
+ (void)contentNewsWithURLString:(NSString *)URLString Success:(void(^)(NSArray *contentNews))succeses error:(void (^)(NSError *error))error;
@end
