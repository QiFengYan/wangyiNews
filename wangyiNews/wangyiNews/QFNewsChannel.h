//
//  QFNewsChannel.h
//  wangyiNews
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import <Foundation/Foundation.h>




//template	:	manual
//
//topicid	:	00040BGE
//
//hasCover	:	false
//
//alias	:	The Truth
//
//subnum	:	6.1万
//
//recommendOrder	:	0
//
//isNew	:	0
//
//img	:	http://img2.cache.netease.com/m/newsapp/banner/zhenhua.png
//
//isHot	:	0
//
//hasIcon	:	true
//
//cid	:	C1348654575297
//
//recommend	:	0
//
//headLine	:	false
//
//color	:
//
//bannerOrder	:	105
//
//tname	:	原创
//
//ename	:	zhenhua
//
//showType	:	comment
//
//special	:	0
//
//tid	:	T1370583240249

@interface QFNewsChannel : NSObject
/**
 *  标题名称
 */
@property (nonatomic, copy) NSString *tname;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *URLString;

+ (instancetype)newsChannelWithDict:(NSDictionary *)dict;

+ (NSArray *)newsChannel;

@end
