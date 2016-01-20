//
//  QFNewsController.m
//  wangyiNews
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import "QFNewsController.h"
#import "QFContentNews.h"
#import "QFNewsCell.h"

@interface QFNewsController ()

@property (nonatomic, strong) NSArray *newsArr;

@end

@implementation QFNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
}

- (void)setURLString:(NSString *)URLString {
    _URLString = URLString;
    
    // 加载数据
    [self loadData];
}

- (void)loadData {
    [QFContentNews contentNewsWithURLString:self.URLString Success:^(NSArray *contentNews) {
        // 接收模型数据
        self.newsArr = contentNews;
        // 刷新界面
        [self.tableView reloadData];
//        NSLog(@"%@",self.newsArr);
        
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取模型
    QFContentNews *contentNews = self.newsArr[indexPath.row];
    // 创建cell
    QFNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[QFNewsCell cellIdentifier:contentNews] forIndexPath:indexPath];
    
    cell.contentNews = contentNews;
    
    return cell;
}

#pragma mark --  TableView 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取模型
    QFContentNews *contentNews = self.newsArr[indexPath.row];
    return [QFNewsCell cellHeight:contentNews];
}

@end
