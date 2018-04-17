//
//  XCShopViewController.m
//  testApp
//
//  Created by Melody on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//
#define kaddPhotoCellID @"addPhotoCellID"

#import "XCShopViewController.h"
#import "BaseNavigationBar.h"
#import "priceCIQChangeView.h"
#import "XCCheckoutDetailPhotoCell.h"
#import "LYZAlertView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "XCShopAMapViewController.h"
#import "XCShopServiceModel.h"
#import "XCShopServiceDetailListViewController.h"
@interface XCShopViewController ()<UITableViewDelegate,
UITableViewDataSource,priceCIQChangeViewDelegate,BaseNavigationBarDelegate,
XCDistributionFooterViewDelegate,XCCheckoutDetailPhotoCellDelegate,
UINavigationControllerDelegate,UIImagePickerControllerDelegate,XCShopAMapViewControllerDelegate>
@property (nonatomic, strong) UIView *contenView;
@property (nonatomic, strong) priceCIQChangeView *CIQChangeView;
@property (nonatomic, strong) UIView *viewBear;
@property (nonatomic, strong) UIView *viewLastY;
@property (nonatomic, strong) UIView *viewPriceRecord;
@property (nonatomic, strong) UITableView *serviceTableView;
@property (nonatomic, strong) UITableView *storeTableView;
@property (nonatomic, strong) UIView *viewSegment;

/** 门店信息tableViewTitle数据 */
@property (nonatomic, strong) NSArray * storeTitleArr;
/** 预设 */
@property (nonatomic, strong) NSArray * placeHolderArr ;
/** 服务tableViewTitle数据 */
@property (nonatomic, strong) NSArray * serviceTitleArr ;
/** 选中当前的Cell */
@property (nonatomic, strong) XCCheckoutDetailPhotoCell * currentPhotoCell ;
/** 证书图片保存 */
@property (nonatomic, strong) UIImage * lincesPhoto ;
/** 4张图片保存 */
@property (nonatomic, strong) NSMutableArray * storePhotoArrM ;

/** <# 注释 #> */
@property (nonatomic, strong) NSArray * services;

@end

@implementation XCShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _storePhotoArrM = [[NSMutableArray alloc] init];
    _services = [[NSMutableArray alloc] init];
    [self configureData];
    [self createUI];
}

#pragma mark - lifeCycle

#pragma mark - Init Method
#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.contenView];
    [self.contenView addSubview:self.viewBear];
    [self.contenView addSubview:self.CIQChangeView];
    [self.viewBear addSubview:self.viewLastY];
    [self.viewBear addSubview:self.viewPriceRecord];
    [self.viewLastY addSubview:self.storeTableView];
    [self.viewPriceRecord addSubview:self.serviceTableView];
    [self.contenView addSubview:self.viewSegment];
}

#pragma mark - Action Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.serviceTableView) {
        
        switch (indexPath.row) {
            case 0:{ //洗车项目
                NSArray *arr = self.services[indexPath.row];
                NSMutableArray * serviceDataArrM = [[NSMutableArray alloc] init];
                for (NSDictionary *dataInfo in arr) {
                    XCShopServiceModel *serviceModel = [XCShopServiceModel yy_modelWithJSON:dataInfo];
                    if (serviceModel) {
                        [serviceDataArrM addObject:serviceModel];
                    }
                }
                XCShopServiceDetailListViewController *serviceDetailVC = [[XCShopServiceDetailListViewController alloc] initWithTitle:@"洗车项目"];
                serviceDetailVC.dataArr = serviceDataArrM;
                [self.navigationController pushViewController:serviceDetailVC animated:YES];
            }
                break;
            case 1: { //美容项目
                NSArray *arr = self.services[indexPath.row];
                NSMutableArray * serviceDataArrM = [[NSMutableArray alloc] init];
                for (NSDictionary *dataInfo in arr) {
                    XCShopServiceModel *serviceModel = [XCShopServiceModel yy_modelWithJSON:dataInfo];
                    if (serviceModel) {
                        [serviceDataArrM addObject:serviceModel];
                    }
                }
                XCShopServiceDetailListViewController *serviceDetailVC = [[XCShopServiceDetailListViewController alloc] initWithTitle:@"美容项目"];
                serviceDetailVC.dataArr = serviceDataArrM;
                [self.navigationController pushViewController:serviceDetailVC animated:YES];
            }
                break;
            case 2: { //保养项目
                NSArray *arr = self.services[indexPath.row];
                NSMutableArray * serviceDataArrM = [[NSMutableArray alloc] init];
                for (NSDictionary *dataInfo in arr) {
                    XCShopServiceModel *serviceModel = [XCShopServiceModel yy_modelWithJSON:dataInfo];
                    if (serviceModel) {
                        [serviceDataArrM addObject:serviceModel];
                    }
                }
                XCShopServiceDetailListViewController *serviceDetailVC = [[XCShopServiceDetailListViewController alloc] initWithTitle:@"保养项目"];
                serviceDetailVC.dataArr = serviceDataArrM;
                [self.navigationController pushViewController:serviceDetailVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else if (tableView == self.storeTableView) {
        if (indexPath.row == 6) {
            // 跳转地图
            XCShopAMapViewController *mapVC = [[XCShopAMapViewController alloc] initWithTitle:@"地图定位"];
            mapVC.delegate = self;
            [self.navigationController pushViewController:mapVC animated:YES];
        }
        
    }
}

#pragma mark - Delegates & Notifications

#pragma mark -priceCIQChangeViewDelegate
- (void)changeModel:(BOOL)isLaseY{
    if (isLaseY) {
        self.viewBear.frame = CGRectMake(0, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
    } else {
        NSDictionary *param = @{
                                @"storeId":[UserInfoManager shareInstance].storeID,
                                };
        __weak typeof (self)weakSelf = self;
        [RequestAPI getStoreService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if (response[@"data"]) {
                NSDictionary *dataInfo = response[@"data"];
                NSArray *xcServicesArr = dataInfo[@"xcServiceList"];
                NSArray *mrServicesArr = dataInfo[@"mrServiceList"];
                NSArray *byServicesArr = dataInfo[@"byServiceList"];
                self.services = [[NSMutableArray alloc] initWithArray:@[xcServicesArr,mrServicesArr,byServicesArr]];
        
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            [weakSelf requestFailureHandler];
        }];
        self.viewBear.frame = CGRectMake(-SCREEN_WIDTH, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
    }
}

#pragma mark - XCDistributionFooterViewDelegate

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    LYZAlertView *alterView = [LYZAlertView alterViewWithTitle:nil content:@"是否确认要提交审核" confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
        
        NSDictionary *parma = [self.storeModel getUpdateStoreDictionary];
        [RequestAPI postUpdateStore:parma header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            
        } fail:^(id error) {
            
        }];
    }];
    [self.view addSubview:alterView];
}

#pragma  mark - XCCheckoutDetailPhotoCellDelegate

- (void)XCCheckoutDetailPhotoCellClickphotoImageView:(UIImage *)image
                                               index:(NSInteger)index
                                                cell:(XCCheckoutDetailPhotoCell *)cell
{
    
}
- (void)XCCheckoutDetailPhotoCellClickAddPhotosImageView:(UIImageView *)imageView
                                                    cell:(XCCheckoutDetailPhotoCell *)cell
{
    self.currentPhotoCell = cell;
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    pickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - navigationDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSURL *imageAssetUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    __weak __typeof(self) weakSelf = self;
    [assetLibrary assetForURL:imageAssetUrl resultBlock:^(ALAsset *asset)  {
        ALAssetRepresentation* representation = [asset defaultRepresentation];
        // 创建一个buffer保存图片数据
        uint8_t *buffer = (Byte*)malloc(representation.size);
        NSUInteger length = [representation getBytes:buffer fromOffset: 0.0  length:representation.size error:nil];
        // 将buffer转换为NSData object，然后释放buffer内存
        NSData *imageData = [[NSData alloc] initWithBytesNoCopy:buffer length:representation.size freeWhenDone:YES];
        UIImage *image = [UIImage imageWithData:imageData scale:1.0];
        
        if ([weakSelf.currentPhotoCell.title isEqualToString:@"营业执照上传,1张"]) {
            weakSelf.lincesPhoto = image;
            [weakSelf.currentPhotoCell setPhotoArr:@[weakSelf.lincesPhoto]];
            [weakSelf.currentPhotoCell updateLocalPhotoArr:@[weakSelf.lincesPhoto]];
        }
        else if ([weakSelf.currentPhotoCell.title isEqualToString:@"门店图片,最多4张"]) {
            [weakSelf.storePhotoArrM addObject:image];
            [weakSelf.currentPhotoCell updateLocalPhotoArr:weakSelf.storePhotoArrM];
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } failureBlock:^(NSError *error) {
        //失败的处理
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - XCShopAMapViewControllerDelegate

-(void)XCShopAMapViewControllerDidConfirmAddressCity:(NSString *)city area:(NSString *)area coordinate:(CLLocationCoordinate2D)coordiante
{
    if (isUsableNSString(city, @"")) {
        [self.storeModel setCity:city];
    }
    if (isUsableNSString(area,@"")) {
        [self.storeModel setArea:area];
    }
    if (coordiante.latitude != 0.0 && coordiante.longitude != 0.0) {
        [self.storeModel setLatitude:[NSString stringWithFormat:@"%f",coordiante.latitude]];
        [self.storeModel setLongitude:[NSString stringWithFormat:@"%f",coordiante.longitude]];
    }
    NSIndexPath * cityIndexpath = [NSIndexPath indexPathForRow:6 inSection:0];
    NSIndexPath * areaIndexpath = [NSIndexPath indexPathForRow:7 inSection:0];
    
    
    [self.storeTableView reloadRowsAtIndexPaths:@[cityIndexpath,areaIndexpath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.storeTableView) {
        return self.storeTitleArr.count;
    }else { //服务信息
        return self.serviceTitleArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.storeTableView) {
        NSString *title = self.storeTitleArr[indexPath.row];
        if ([self isPhotoCellWithIndex:indexPath]) {
            XCCheckoutDetailPhotoCell *photoCell = (XCCheckoutDetailPhotoCell *)[tableView dequeueReusableCellWithIdentifier:kaddPhotoCellID];
            photoCell.delegate = self;
            [photoCell setTitle:title];
            [photoCell setMaxPhoto:1];
            if (indexPath.row == 10) {
                [photoCell setMaxPhoto:4];
            }
            [photoCell setupCellWithShopModel:self.storeModel];
            return photoCell;
        }else if ([self isPicketCellWithIndex:indexPath]) {
            NSString *holderStr = self.placeHolderArr[indexPath.row];
            XCDistributionPicketCell *picketCell =(XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID];
            picketCell.title = title;
            [picketCell setTitleValue:holderStr];
            [picketCell setupCellWithShopModel:self.storeModel];
            return picketCell;
        }else {
            NSString *holderStr = self.placeHolderArr[indexPath.row];
            XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID];
            textFiledCell.title = title;
            [textFiledCell setTextFiledBGColor:[UIColor whiteColor]];
            [textFiledCell setTitlePlaceholder:holderStr];
            if (self.storeModel) {
                [textFiledCell setupCellWithShopModel:self.storeModel];
            }
            return textFiledCell;
        }
    }else  {
        NSString *title = nil;
        if (self.serviceTitleArr.count > indexPath.row) {
            title = self.serviceTitleArr[indexPath.row];
        }
        XCDistributionPicketCell *picketCell =(XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID];
        picketCell.title = title;
        if (picketCell == nil) {
            picketCell =[[XCDistributionPicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPicketCellID];
            picketCell.title = title;
        }
        return picketCell;
    }
  
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewID];
    [headerView.contentView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView == self.storeTableView) {
        XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
        [footerView setTitle:@"提交审核"];
        footerView.delegate = self;
        return footerView;
    }
    UITableViewHeaderFooterView *fotterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
    [fotterView.contentView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    return fotterView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.storeTableView) {
        if ([self isPhotoCellWithIndex:indexPath]) {
            return [XCCheckoutDetailPhotoCell getCellHeight];
        }else if ([self isPicketCellWithIndex:indexPath]) {
            return [XCDistributionPicketCell getCellHeight];
        }else {
            return [XCCheckoutDetailTextFiledCell getCellHeight];
        }
    }
    return 88 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.storeTableView) {
        return [XCDistributionFooterView getFooterViewHeight];
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  20 * ViewRateBaseOnIP6;
}

#pragma mark - Privacy Method
- (void)configureData
{
    self.storeTitleArr = @[@"门店名称:",@"联系方式:",@"负责人:",
                          @"负责人电话:",@"业务员提成:",@"团队经理提成:",
                          @"所属城市",@"所在地区",@"门店审核状态",
                          @"营业执照上传,1张",@"门店图片,最多4张"];
    self.placeHolderArr = @[@"请输入名称",@"请输入联系方式",@"请输入负责人姓名",
                            @"请输入电话",@"请输入百分比",@"请输入百分比",
                            @"广州市",@"天河区",@"审核中"];
    
    self.serviceTitleArr = @[@"洗车项目",@"美容项目",@"保养项目"];
}

- (BOOL)isPicketCellWithIndex:(NSIndexPath *)indexpath
{
    if ( indexpath.row == 6|| indexpath.row == 7 ) {
        return YES;
    }
    return NO;
}

- (BOOL)isPhotoCellWithIndex:(NSIndexPath *)indexpath
{
    if ( indexpath.row == 9|| indexpath.row == 10 ) {
        return YES;
    }
    return NO;
}

- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}
#pragma mark - Setter&Getter

- (void)setStoreModel:(XCShopModel *)storeModel
{
    if (!storeModel) {
        return;
    }
    _storeModel = storeModel;
    
    
}

- (UIView *)contenView{
    if (!_contenView) {
        _contenView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation)];
    }
    return _contenView;
}

- (priceCIQChangeView *)CIQChangeView{
    if (!_CIQChangeView) {
        _CIQChangeView = [[priceCIQChangeView alloc] initWithFrame:CGRectMake(0, 20 * ViewRateBaseOnIP6, SCREEN_WIDTH, 160 * ViewRateBaseOnIP6)];
        _CIQChangeView.delegate = self;
        [_CIQChangeView setleftTitle:@"门店信息" rightTitle:@"服务信息"];
    }
    return _CIQChangeView;
}

- (UITableView *)serviceTableView{
    if (!_serviceTableView) {
        _serviceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.contenView.frame.size.height - self.CIQChangeView.frame.size.height - 20 * ViewRateBaseOnIP6 ) style:UITableViewStyleGrouped];
        _serviceTableView.delegate = self;
        _serviceTableView.dataSource = self;
        _serviceTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _serviceTableView.showsVerticalScrollIndicator = NO;
        _serviceTableView.bounces = YES;
        _serviceTableView.separatorColor = [UIColor purpleColor];
        _serviceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_serviceTableView registerClass:[XCDistributionPicketCell class] forCellReuseIdentifier:kPicketCellID];
        [_serviceTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID];
    }
    return _serviceTableView;
}

- (UITableView *)storeTableView{
    if (!_storeTableView) {
        _storeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.contenView.frame.size.height - self.CIQChangeView.frame.size.height - 20 * ViewRateBaseOnIP6) style:UITableViewStyleGrouped];
        _storeTableView.delegate = self;
        _storeTableView.dataSource = self;
        _storeTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _storeTableView.showsVerticalScrollIndicator = NO;
        _storeTableView.bounces = YES;
        _storeTableView.separatorColor = [UIColor purpleColor];
        _storeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_storeTableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID];
        [_storeTableView registerClass:[XCDistributionPicketCell class] forCellReuseIdentifier:kPicketCellID];
        [_storeTableView registerClass:[XCCheckoutDetailPhotoCell class] forCellReuseIdentifier:kaddPhotoCellID];
        [_storeTableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
        [_storeTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID
         ];    }
    return _storeTableView;
}

- (UIView *)viewBear{
    if (!_viewBear) {
        _viewBear = [[UIView alloc] initWithFrame:CGRectMake(0, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180)];
    }
    return _viewBear;
}

- (UIView *)viewLastY{
    if (!_viewLastY) {
        _viewLastY = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 180 * ViewRateBaseOnIP6)];
        _viewLastY.backgroundColor = [UIColor whiteColor];
    }
    return _viewLastY;
}

- (UIView *)viewPriceRecord{
    if (!_viewPriceRecord) {
        _viewPriceRecord = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 180 * ViewRateBaseOnIP6)];
        _viewPriceRecord.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    }
    return _viewPriceRecord;
}

- (UIView *)viewSegment{
    if (!_viewSegment) {
        _viewSegment = [[UIView alloc] initWithFrame:CGRectMake(0, 180 * ViewRateBaseOnIP6, SCREEN_WIDTH, 1 * ViewRateBaseOnIP6)];
        _viewSegment.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    }
    return _viewSegment;
}

@end
