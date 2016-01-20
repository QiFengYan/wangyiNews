//
//  QFHomeViewController.m
//  wangyiNews
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Yan Qi Feng. All rights reserved.
//

#import "QFHomeViewController.h"
#import "QFNewsChannel.h"
#import "QFChannelLable.h"
#import "QFChannelCell.h"
#import "QFNewsController.h"

@interface QFHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayerout;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/**
 *  控制器缓存池
 */
@property (nonatomic, strong) NSMutableDictionary *controllerCache;
/**
 *  头条模型
 */
@property (nonatomic, strong) NSArray *channels;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation QFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载头条数据
    [self setupChannels];
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
/**
 *  加载数据
 */
- (void)setupChannels {
    
    // 设置Lable 坐标
    __block CGFloat lableX = 5;
    CGFloat marginX = 5;
    CGFloat lableY = 0;
    CGFloat lableH = self.scrollView.bounds.size.height;
    // 取消内间距
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSInteger index = 0;
    // 遍历数组  创建Lable
    for (QFNewsChannel *channel in self.channels) {
        // 创建标题
        QFChannelLable *lable = [QFChannelLable lableWithTitle:channel.tname];
        lable.tag = index++;
        
        __weak typeof(lable) weakLable = lable;
        __weak typeof(self) weakSelf = self;
        //Block 回调
        [lable setLableSelectedBlock:^{
//            NSLog(@"%zd",weakLable.tag);
            // 判断当前选中的头条下标 是否和当前记录的下标 一样
            if (weakSelf.currentIndex == weakLable.tag) return;
            // 如果不相等，获取当前头条
            QFChannelLable *currentLable = weakSelf.scrollView.subviews[weakSelf.currentIndex];
            currentLable.scale = 0.0;
            weakLable.scale = 1.0;
            // 1. 滚动到指定的新闻页面
            [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:weakLable.tag inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            // 2. 重新复制currentIndex
            weakSelf.currentIndex = weakLable.tag;
            // 计算偏移量
            [weakSelf setupContentOffsetWithSelectedLable:weakLable];
        }];
        
        // 设置frame
        lable.frame = CGRectMake(lableX, lableY, lable.frame.size.width, lableH);
        // 添加到父控件
        [weakSelf.scrollView addSubview:lable];
        // 修改x值
        lableX += marginX + lable.frame.size.width;
    }
    // 设置滚动范围
    self.scrollView.contentSize = CGSizeMake(lableX, 0);
    // 去除滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 默认下标为0
    self.currentIndex = 0;
    // 获得当前标签
    QFChannelLable *lable = self.scrollView.subviews[self.currentIndex];
    // 设置scale
    lable.scale = 1;
}


-(void)setupContentOffsetWithSelectedLable:(QFChannelLable *)lable {
     __weak typeof(self) weakSelf = self;
    // 根据当前选中的下标 计算scroll的偏移量
    CGFloat offsetX = lable.center.x - weakSelf.scrollView.bounds.size.width * 0.5;
    // 计算最大滚动范围
    CGFloat maxOffset = weakSelf.scrollView.contentSize.width - weakSelf.scrollView.bounds.size.width;
    
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > maxOffset) {
        offsetX = maxOffset;
    }
    // 设置偏移量量
    [weakSelf.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - UISctollView 代理方法
// 一滚动 就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 获得当前选中的标签
    QFChannelLable *currentLable = self.scrollView.subviews[self.currentIndex];
    
   
//    NSInteger index = 0;
    // 获得当前可见cell 的标签  // MARK:mark 可见cell 的下标 从 A到B
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    // 声明下一个标签
    QFChannelLable *nextLable = nil;
    // 遍历 数组  获得下一个cell 的标签
    for (NSIndexPath *indexPath in indexPaths) {
        // 判断 如果标签不等于当前标签 即为下一个
        if (indexPath.item != self.currentIndex) {
            nextLable = self.scrollView.subviews[indexPath.item];
//            index = indexPath.item;
            break;
        }
    }
    if (nextLable == nil) return;

    // 找到下一个标签
    // 计算比例     //FIXME:比例值的算法
    CGFloat nextScale = ABS((CGFloat)scrollView.contentOffset.x / scrollView.bounds.size.width - self.currentIndex);
    // 获得当前比例
    CGFloat currentScale = 1 - nextScale;
    currentLable.scale = currentScale;
    nextLable.scale = nextScale;
//    self.currentIndex = index;
//    NSLog(@"index = %zd",index);
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    for (id subLable in self.scrollView.subviews) {
        if ([subLable isKindOfClass:[QFChannelLable class]]) {
            QFChannelLable *lable = (QFChannelLable *)subLable;
            lable.scale = 0;
        }
    }
    
    QFChannelLable *lable = self.scrollView.subviews[self.currentIndex];
    lable.scale = 1;

    [self setupContentOffsetWithSelectedLable:lable];
//    NSLog(@"current = %zd",self.currentIndex);
}

#pragma mark -
#pragma mark -- UIScrollView 实现数据源方法
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QFChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"channelCell" forIndexPath:indexPath];
    QFNewsChannel *channel =self.channels[indexPath.item];
    
    // 将上一个控制器的View 移除
    [cell.newsVc.view removeFromSuperview];
    
    QFNewsController *newsVC = [self newsVCWith:channel];
    cell.newsVc = newsVC;
    
    if (![self.childViewControllers containsObject:newsVC]) {
        [self addChildViewController:newsVC];
    }
    return cell;
}

- (QFNewsController *)newsVCWith:(QFNewsChannel *)channel {
    QFNewsController *newsVc = [self.controllerCache objectForKey: channel.tid];
    if (newsVc == nil) {
        // 加载sb
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        newsVc = sb.instantiateInitialViewController;
        newsVc.URLString = channel.URLString;
        // 将控制器添加到缓存池中
        [self.controllerCache setObject:newsVc forKey:channel.tid];
    }
   
    return newsVc;
}


#pragma mark - 
#pragma mark -- 模型数据懒加载 --
- (NSArray *)channels
{
    if (_channels == nil) {
        _channels = [QFNewsChannel newsChannel];
    }
    return _channels;
}

#pragma mark -
#pragma mark -- 控制器缓存池懒加载 --

- (NSMutableDictionary *)controllerCache {
    if (_controllerCache == nil) {
        _controllerCache = [NSMutableDictionary dictionary];
    }
    return _controllerCache;
}


@end
