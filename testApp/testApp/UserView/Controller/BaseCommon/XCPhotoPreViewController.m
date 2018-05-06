//
//  XCPhotoPreViewController.m
//  testApp
//
//  Created by Melody on 2018/4/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCPhotoPreViewController.h"
#import "UILabel+createLabel.h"
#import "WSImageBroserCell.h"
#import "LYZAlertView.h"
@interface XCPhotoPreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<WSImageModel *>* imageArray;
/** 即将删除ArrM */
@property (nonatomic, strong) NSMutableArray * tmpDeleArr ;
@property (nonatomic, assign) NSInteger showIndex;

@end

@implementation XCPhotoPreViewController



#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureSubViews];
    [self configureData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}

#pragma mark - Init Method
- (instancetype)initWithTitle:(NSString *)title
                      sources:(NSArray<NSString *> *)imageArrM{
    if (self = [super init]) {
//        self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);
        self.view.backgroundColor = [UIColor whiteColor];
        _topBar = [[BaseNavigationBar alloc] init];
        _topBar.delegate  = self;
        _topBar.title = title;
        self.navTitle = title;
        [self.view addSubview:_topBar];
        
        NSMutableArray *tmpArray = [NSMutableArray new];
        for (NSString *imagePath in imageArrM) {
            WSImageModel *model = [WSImageModel new];
            if (isUsableNSString(imagePath, @"")) {
                model.imageUrl = imagePath;
                [tmpArray addObject:model];
            }
        }
        self.imageArray = tmpArray;
        self.tmpDeleArr = [[NSMutableArray alloc] init];
        _shouldShowDeleBtm = NO;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      sources:(NSArray<NSString *> *)imageArrM
              comlectionBlock:(completionBlock)completionBlock
{
    self = [self initWithTitle:title sources:imageArrM];
    self.completion = completionBlock;
    
    return self;
}


- (void)configureData
{
    if(_showIndex > 0 && _showIndex < _imageArray.count) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView setContentOffset:CGPointMake(_showIndex * self.collectionView.frame.size.width,0) animated:NO];
        });
    }
    else {
        [self refreshTitle];
    }
}

- (void)configureSubViews
{

    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation - safeAreaBottom) collectionViewLayout:layout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[WSImageBroserCell class] forCellWithReuseIdentifier:NSStringFromClass([WSImageBroserCell class])];
}

#pragma mark - Action Method
- (void)updatePositionWithIndex:(NSUInteger)index
{
    if(index > 0 && index < _imageArray.count) {
        _showIndex = index;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView setContentOffset:CGPointMake(_showIndex * self.collectionView.frame.size.width,- kHeightForNavigation) animated:NO];
        });
    }
    else {
        [self refreshTitle];
    }
}

- (void)onClickBack
{
    //返回删除过的数组
    if(self.completion) {
        NSMutableArray *array = [NSMutableArray new];
        for (WSImageModel *model in self.tmpDeleArr) {
            [array addObject:model.imageUrl];
        }
        self.completion(array);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onClickDel
{
    __weak __typeof(self) weakSelf = self;
    LYZAlertView *alterView = [LYZAlertView alterViewWithTitle:@"确认要删除吗?" content:nil confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if(strongSelf.showIndex >= 0 && strongSelf.showIndex < strongSelf.imageArray.count) {
            [strongSelf.tmpDeleArr addObject:strongSelf.imageArray[strongSelf.showIndex]];
            [strongSelf.imageArray removeObjectAtIndex:strongSelf.showIndex];
            [strongSelf.collectionView reloadData];
        }
        [strongSelf refreshTitle];
        if(strongSelf.imageArray.count == 0) {
            [strongSelf onClickBack];
        }
    }];
    [self.view addSubview:alterView];

}

#pragma mark - Delegates & Notifications
#pragma mark - collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WSImageBroserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WSImageBroserCell class]) forIndexPath:indexPath];
    if(indexPath.row < _imageArray.count) {
        cell.model = _imageArray[indexPath.row];
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self refreshTitle];
}


#pragma mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self onClickBack];
    }
}

- (void)baseNavigationDidPressDeleteBtn:(BOOL)isCancel
{
    [self onClickDel];
}

#pragma mark - Privacy Method
- (void)refreshTitle {
    NSInteger index = self.collectionView.contentOffset.x/self.collectionView.frame.size.width;
    _showIndex = index;
    index += 1;
    if(index >= 0 && index <= _imageArray.count) {
        self.topBar.title = [NSString stringWithFormat:@"%@/%@",@(index),@(_imageArray.count)];
    }
}
#pragma mark - Setter&Getter

- (void)setShowIndex:(NSInteger)showIndex
{
    _showIndex = showIndex;
}

- (void)setShouldShowDeleBtm:(BOOL)shouldShowDeleBtm
{
    _shouldShowDeleBtm = shouldShowDeleBtm;

    /// 设置过一个删除按钮永远hidden = NO，不是我的锅
    if (shouldShowDeleBtm) {
        [_topBar setFinishBtnTitle:@"删除"];
    }
}

@end
