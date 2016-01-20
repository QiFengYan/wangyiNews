//
//  QFHeadLineController.m
//  wangyiNews
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import "QFHeadLineController.h"
#import "QFHeadNew.h"
#import "QFHeadLineCell.h"
@interface QFHeadLineController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  流水布局
 */
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayerout;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
/**
 *  分页
 */
@property (weak, nonatomic) IBOutlet UIPageControl *page;
/**
 *  模型数据
 */
@property (nonatomic, strong) NSArray *headLines;

@property (nonatomic, assign) long num;

@end

@implementation QFHeadLineController

static NSString * const reuseIdentifier = @"headCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.num = 30000;
   
    // 加载数据
    [self loadData];
    
}
/**
 *  当控制器的布局完成时候调用
 */
- (void) viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    // 布局
    [self setupLayerout];
}

/**
 *  加载数据
 */
- (void)loadData {
    [QFHeadNew headLineWithSuccess:^(NSArray *headLines) {
        // 接收模型数据
        self.headLines = headLines;
        // 刷新界面
        [self.collectionView reloadData];
        // 默认起始在第一张
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:(self.num*0.5)] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        // 设置标题
         //[self scrollViewDidScroll:self.collectionView];
    } error:^(NSError *error) {
        
    }];
    
}
/**
 *  布局
 */
- (void)setupLayerout {
//    NSLog(@"%@",NSStringFromCGSize(self.view.bounds.size));
    // 设置布局
    self.flowLayerout.itemSize = self.collectionView.bounds.size;
    // 设置滚动方向
    self.flowLayerout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置item之间的间隙
    self.flowLayerout.minimumLineSpacing = 0;
    // 设置分页
    self.collectionView.pagingEnabled = YES;
    // 去除弹簧效果
    self.collectionView.bounces = NO;
    // 隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.num;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.headLines.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获取模型
    QFHeadNew *headLine = self.headLines[indexPath.item];
    // 创建cell
    QFHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // 赋值
    cell.headLine = headLine;
    return cell;
}



#pragma mark -- UIScrollView 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 计算偏移值
    NSInteger page = (scrollView.contentOffset.x + (scrollView.bounds.size.width * 0.5)) / scrollView.bounds.size.width;
    page %= self.headLines.count;
//    NSLog(@"%zd",page);
    // 获取模型
    QFHeadNew *headLine = self.headLines[page];
    // 设置标题
    self.titleLable.text = headLine.title;
    // 设置分页
    self.page.currentPage = page;
    
}

@end
