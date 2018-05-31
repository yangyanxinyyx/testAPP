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
#import "ProgressControll.h"
#import "XCPhotoPreViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "UIImage+imageHelper.h"
#import "SelectStateView.h"
#import "XCPickerCityHandler.h"
#import <TZImagePickerController.h>
#import "XCShopRejectView.h"
#import "XCShopLabelAlertView.h"
#import <AMapSearchKit/AMapSearchKit.h>
#define ktableViewH SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom + 160 * ViewRateBaseOnIP6)
#define kshopStatusDaiShenHe @"审核中"
#define kshopStatusShenHeTongGuo @""
@interface XCShopViewController ()<UITableViewDelegate,
UITableViewDataSource,priceCIQChangeViewDelegate,BaseNavigationBarDelegate,
XCDistributionFooterViewDelegate,XCCheckoutDetailPhotoCellDelegate,
UINavigationControllerDelegate,UIImagePickerControllerDelegate,
XCShopAMapViewControllerDelegate,XCCheckoutDetailTextFiledCellDelegate,UIActionSheetDelegate,
TZImagePickerControllerDelegate,XCDistributionPicketCellDelegate,AMapSearchDelegate>
{
    dispatch_semaphore_t _videoTrackSynLoadSemaphore;
    dispatch_time_t _maxVideoLoadTrackTimeConsume ;
}
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
/** 选中当前CellTitle */
@property (nonatomic, strong) NSString * selectedTitle ;
/** 选中当前的Cell */
@property (nonatomic, strong) XCCheckoutDetailPhotoCell * currentPhotoCell ;
/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * lincePhotoArrM ;
/** 4张图片保存 */
@property (nonatomic, strong) NSMutableArray * storePhotoArrM ;
/** 服务信息数据 */
@property (nonatomic, strong) NSArray * services;
/** 定位记录省份 */
@property (nonatomic, strong) NSString *storeProvence ;
@property (nonatomic, strong) NSString *storeCity ;
@property (nonatomic, strong) NSString *storeArea ;

/** 上传成功图片URL */
@property (nonatomic, strong) NSMutableArray * networkURLArrM ;
/** tmp保存即将删除图片的数组 */
@property (nonatomic, strong) NSMutableArray *tmpDeleteURLArrM  ;

@property (nonatomic, strong) AMapSearchAPI * searchAPI ;


@end

@implementation XCShopViewController

#pragma mark - lifeCycle
- (void)dealloc {
    
    for (NSString *filePath in self.lincePhotoArrM) {
        if (isUsable(filePath, [NSString class])) {
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            }
            unlink([filePath  UTF8String]);
        }
    }
    for (NSString *filePath in self.storePhotoArrM) {
        if (isUsable(filePath, [NSString class])) {
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            }
            unlink([filePath  UTF8String]);
        }
    }
    [self removeObserverKeyBoard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _storePhotoArrM = [[NSMutableArray alloc] init];
    _lincePhotoArrM = [[NSMutableArray alloc] init];
    _networkURLArrM = [[NSMutableArray alloc] init];
    _tmpDeleteURLArrM = [[NSMutableArray alloc] init];
    _services = [[NSMutableArray alloc] init];
    _storeModel = [[XCShopModel alloc] init];
    _searchAPI = [[AMapSearchAPI alloc] init];
    _searchAPI.delegate = self;
    [self addObserverKeyboard];
    [self configureData];
    [self createUI];
}

#pragma mark - Init Method

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
- (void)configureData
{
    self.storeTitleArr = @[@"门店名称:",@"门店电话:",@"负责人:",
                           @"负责人电话:",@"所属城市",@"所在地区",
                           @"详细地址",@"门店标签",@"门店审核状态",
                           @"营业执照上传,1张",@"门店图片,最多4张"];
    self.placeHolderArr = @[@"请输入门店名称",@"请输入联系方式",@"请输入负责人",
                            @"请输入负责人电话",@"城市",@"地区",
                            @"",@"",@"待审核",
                            @"1张",@"4张"];
}
#pragma mark - Action Method

- (void)deleteAllTmpPhoto
{
    dispatch_semaphore_t videoTrackSynLoadSemaphore;
    videoTrackSynLoadSemaphore = dispatch_semaphore_create(0);
    dispatch_time_t maxVideoLoadTrackTimeConsume = dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC);
    __weak __typeof(self) weakSelf = self;
    if (self.tmpDeleteURLArrM.count > 0 ) {
        __block NSInteger finishCount = 0;
        for (NSString *fileURLPath in self.tmpDeleteURLArrM) {
            NSDictionary *param = @{
                                    @"url":fileURLPath,
                                    };
            [RequestAPI deletePictureByUrl:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                __strong __typeof__(weakSelf)strongSelf = weakSelf;
                if ([response[@"result"] boolValue] == 1) {
                    finishCount ++ ;
                    NSLog(@"=======>deleteNewWorkPhoto %ld",finishCount);
                    if (finishCount == self.tmpDeleteURLArrM.count) {
                        [strongSelf showAlterInfoWithNetWork:@"提交成功" complete:nil];
                    }
                }
                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                dispatch_semaphore_signal(videoTrackSynLoadSemaphore);
            } fail:^(id error) {
                dispatch_semaphore_signal(videoTrackSynLoadSemaphore);
            }];
            dispatch_semaphore_wait(videoTrackSynLoadSemaphore, maxVideoLoadTrackTimeConsume);
        }
    }else {
        [self showAlterInfoWithNetWork:@"提交成功" complete:nil];
    }
}

- (void)postModifyShopInfo
{
    _storeModel.url1 = @"";
    _storeModel.url2 = @"";
    _storeModel.url3 = @"";
    _storeModel.url4 = @"";
    
    for (int i = 0 ; i < self.storePhotoArrM.count; i++) {
        NSString *filePath = self.storePhotoArrM[i];
        if (i == 0) {
            _storeModel.url1 = filePath;
        }
        else if (i == 1) {
            _storeModel.url2 = filePath;
        }
        else if (i == 2) {
            _storeModel.url3 = filePath;
        }
        else if (i == 3) {
            _storeModel.url4 = filePath;
        }
    }
    
    _storeModel.licenseUrl = @"";
    if (self.lincePhotoArrM.count > 0) {
        if ([self.lincePhotoArrM firstObject]) {
            _storeModel.licenseUrl = [self.lincePhotoArrM firstObject];
        }
    }
    if (!isUsableNSString(_storeModel.city, @"")) {
        _storeModel.city = @"";
    }
    NSMutableString * cityStrM = [NSMutableString stringWithString:_storeModel.city];
    NSArray *strArr = [cityStrM componentsSeparatedByString:@"市"];
    cityStrM = [strArr firstObject];
    
    if (!isUsableNSString(_storeModel.tel, @"")) {
        _storeModel.tel = @"";
    }
    if (!isUsableNSString(_storeModel.name, @"")) {
        _storeModel.name = @"";
    }
    if (!isUsableNSString(_storeModel.corporateName, @"")) {
        _storeModel.corporateName = @"";
    }
    if (!isUsableNSString(_storeModel.address, @"")) {
        _storeModel.address = @"";
    }
    if (!isUsableNSString(_storeModel.longitude,@"")) {
        _storeModel.longitude = @"";
    }
    if (!isUsableNSString(_storeModel.latitude, @"")) {
        _storeModel.latitude = @"";
    }
    if (!isUsableNSString(_storeModel.type, @"")) {
        _storeModel.type = @"";
    }
    if (!isUsableNSString(_storeModel.area, @"")) {
        _storeModel.area = @"";
    }
    if (!isUsable(_storeModel.salesmanCommission, [NSNumber class])) {
        _storeModel.salesmanCommission = [NSNumber numberWithDouble:0.00];
    }
    if (!isUsable(_storeModel.managerCommission, [NSNumber class])) {
        _storeModel.managerCommission = [NSNumber numberWithDouble:0.00];
    }
    
    if (!isUsableNSString(_storeModel.label1, @"")) {
        _storeModel.label1 = @"";
    }
    if (!isUsableNSString(_storeModel.label2, @"")) {
        _storeModel.label2 = @"";
    }
    if (!isUsableNSString(_storeModel.label3, @"")) {
        _storeModel.label3 = @"";
    }
    if (!isUsableNSString(_storeModel.label4, @"")) {
        _storeModel.label4 = @"";
    }
    if (!isUsableNSString(_storeModel.label5, @"")) {
        _storeModel.label5 = @"";
    }
    
    dispatch_semaphore_t videoTrackSynLoadSemaphore;
    videoTrackSynLoadSemaphore = dispatch_semaphore_create(0);
    dispatch_time_t maxVideoLoadTrackTimeConsume = dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC);
    __weak __typeof(self) weakSelf = self;
    NSDictionary *param = @{
                            @"id":[UserInfoManager shareInstance].storeID,
                            @"tel":_storeModel.tel,
                            @"name":_storeModel.name,
                            @"corporateName":_storeModel.corporateName,
                            @"corporateCellphone":_storeModel.corporateCellphone,
                            @"address":_storeModel.address,
                            @"longitude":_storeModel.longitude,
                            @"latitude":_storeModel.latitude,
                            @"type":_storeModel.type,
                            @"city":cityStrM,
                            @"area":_storeModel.area,
                            @"salesmanCommission":_storeModel.salesmanCommission,
                            @"managerCommission":_storeModel.managerCommission,
                            @"licenseUrl":_storeModel.licenseUrl,
                            @"url1":_storeModel.url1,
                            @"url2":_storeModel.url2,
                            @"url3":_storeModel.url3,
                            @"url4":_storeModel.url4,
                            @"label1":_storeModel.label1,
                            @"label2":_storeModel.label2,
                            @"label3":_storeModel.label3,
                            @"label4":_storeModel.label4,
                            @"label5":_storeModel.label5,
                            };
    [RequestAPI postUpdateStore:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if ([response[@"result"] integerValue] == 1) {
                [strongSelf.networkURLArrM  removeAllObjects];
                [strongSelf deleteAllTmpPhoto];
                [strongSelf refreshXCShopInfo];
        }else {
            [strongSelf showAlterInfoWithNetWork:response[@"errormsg"] complete:nil];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
        for (NSString *fileURLPath in strongSelf.networkURLArrM ) {
            NSDictionary *param = @{
                                    @"url":fileURLPath,
                                    };
            [RequestAPI deletePictureByUrl:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                if ([response[@"result"] boolValue] == 1) {
                }
                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                dispatch_semaphore_signal(videoTrackSynLoadSemaphore);
            } fail:^(id error) {
                dispatch_semaphore_signal(videoTrackSynLoadSemaphore);
            }];
            dispatch_semaphore_wait(videoTrackSynLoadSemaphore, maxVideoLoadTrackTimeConsume);
        }
    }];
}

- (void)refreshXCShopInfo
{
    NSDictionary *param = @{
                            @"id":[UserInfoManager shareInstance].storeID,
                            };
    __weak __typeof(self) weakSelf = self;
    [RequestAPI getShopsInfo:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"] && isUsable(response[@"data"], [NSDictionary class])) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            XCShopModel *shopModel = [XCShopModel yy_modelWithJSON:response[@"data"]];
            strongSelf.storeModel = shopModel;
            [strongSelf.storeTableView reloadData];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
    
    }];
}

- (void)postUpLoadLocalPhoto //上传1
{
    __weak __typeof(self) weakSelf = self;
    __block NSMutableArray *uploadlinceDataArrM = [[NSMutableArray alloc] init];
    __block NSMutableArray *uploadlincePathArrM = [[NSMutableArray alloc] init];
    
    for (NSString *filePath in self.lincePhotoArrM) {
        if (![self isUsefulURLWith:filePath]) {
            NSData *uploadData = [NSData dataWithContentsOfURL:[NSURL URLWithString:filePath]];
            if (uploadData) {
                [uploadlinceDataArrM addObject:uploadData];
                [uploadlincePathArrM addObject:filePath];
            }
            
        }
    }
    if (uploadlincePathArrM.count > 0) {
        /// 上传图片
        NSDictionary *param = @{
                                @"file":uploadlinceDataArrM,
                                };
        [RequestAPI appUploadPicture:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if ([response[@"result"] integerValue] == 1 ) {
                dispatch_async(dispatch_get_main_queue(), ^{

                for (NSString *filePath in uploadlincePathArrM) {
                    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                    }
                    unlink([filePath  UTF8String]);
                }
                [strongSelf.lincePhotoArrM removeAllObjects];
                NSArray *urlStrArr  = response[@"data"];
                for (NSString *urlPath in urlStrArr) {
                    if (isUsable(urlPath, [NSString class])) {
                        [strongSelf.lincePhotoArrM addObject:urlPath];
                        [strongSelf.networkURLArrM addObject:urlPath];
                    }
                }
                    [strongSelf postStorePhoto]; //上传2
                });
            }else {
                [strongSelf showAlterInfoWithNetWork:@"提交失败" complete:nil];
                return ;
                
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
            return ;
        }];
    }else {
        [self postStorePhoto];
    }

}

- (void)postStorePhoto
{
    __weak __typeof(self) weakSelf = self;
    __block NSMutableArray *uploadDataArrM = [[NSMutableArray alloc] init];
    __block NSMutableArray *uploadPathArrM = [[NSMutableArray alloc] init];
    for (NSString *filePath in self.storePhotoArrM) {
        if (![self isUsefulURLWith:filePath]) {
            NSData *uploadData = [NSData dataWithContentsOfURL:[NSURL URLWithString:filePath]];
            if (uploadData) {
                [uploadDataArrM addObject:uploadData];
                [uploadPathArrM addObject:filePath];
            }
            
        }
    }
    if (uploadPathArrM.count > 0) {
        /// 上传图片
        NSDictionary *param = @{
                                @"file":uploadDataArrM,
                                };
        [RequestAPI appUploadPicture:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if ([response[@"result"] integerValue] == 1 &&response[@"data"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                for (NSString *filePath in uploadPathArrM) {
                    if(isUsableNSString(filePath, @""))
                    {
                        if([strongSelf.storePhotoArrM containsObject:filePath])
                        {
                            [strongSelf.storePhotoArrM removeObject:filePath];
                        }
                        
                    }
                    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                    }
                    unlink([filePath  UTF8String]);
                }
                NSArray *urlStrArr  = response[@"data"];
                for (NSString *urlPath in urlStrArr) {
                    if (isUsable(urlPath, [NSString class])) {
                        [strongSelf.storePhotoArrM addObject:urlPath];
                        [strongSelf.networkURLArrM addObject:urlPath];
                    }else {
                        
                    }
                }
                /// 提交修改门店
                    [strongSelf postModifyShopInfo]; //上传3
                });
            }else {
                __strong __typeof__(weakSelf)strongSelf = weakSelf;
                [strongSelf showAlterInfoWithNetWork:@"提交失败" complete:nil];
                return ;            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
            return ;
        }];
    }else {
        [self postModifyShopInfo];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.serviceTableView) {
        NSDictionary *servicesInfo = self.services[indexPath.row];
        if (isUsable(servicesInfo, [NSDictionary class])) {
            NSString *titleName = @"";
            NSString *categoryName = @"";
            NSMutableArray * serviceDataArrM = [[NSMutableArray alloc] init];
            titleName = servicesInfo[@"categoryServie"];
            categoryName = servicesInfo[@"category"];
            NSArray  *services = servicesInfo[@"list"];
            for (NSDictionary *dataInfo in services) {
                XCShopServiceModel *serviceModel = [XCShopServiceModel yy_modelWithJSON:dataInfo];
                if (serviceModel) {
                    [serviceDataArrM addObject:serviceModel];
                }
            }
            XCShopServiceDetailListViewController *serviceDetailVC = [[XCShopServiceDetailListViewController alloc] initWithTitle:titleName];
            serviceDetailVC.titleTypeStr = categoryName;
            serviceDetailVC.dataArr = serviceDataArrM;
            [self.navigationController pushViewController:serviceDetailVC animated:YES];
        }else {
            [self showAlterInfoWithNetWork:@"网络数据错误" complete:nil];
        }
    }
    else if (tableView == self.storeTableView) {
         if (indexPath.row == 4) {
             [self clickEditedStoreAddressWithCityCell];
        }
        else if (indexPath.row == 5) {
            [self clickEditedStoreAddressWithAreaCell];
        }
        else if (indexPath.row == 6) {
            // 跳转地图
            XCShopAMapViewController *mapVC = [[XCShopAMapViewController alloc] initWithTitle:@"地图定位"];
            mapVC.delegate = self;
            [self.navigationController pushViewController:mapVC animated:YES];
        }
        else if(indexPath.row == 7) {
        // 标签
            NSMutableArray *selectArr = [self getXCShopSelectLabelArr];
            NSArray *titleArr = @[@"维修",@"洗车",@"美容",@"保养"];
            __weak __typeof(self) weakSelf = self;
            [XCShopLabelAlertView alterViewWithDataArr:titleArr selectArr:selectArr confirmClick:^(XCShopLabelAlertView *alertView, NSArray *selectArr) {
                weakSelf.storeModel.label1 = @"";
                weakSelf.storeModel.label2 = @"";
                weakSelf.storeModel.label3 = @"";
                weakSelf.storeModel.label4 = @"";
                weakSelf.storeModel.label5 = @"";
                for (int i = 0; i < selectArr.count; i++) {
                    NSString *selectTitle = selectArr[i];
                    switch (i) {
                        case 0:
                        {
                            weakSelf.storeModel.label1 = selectTitle;
                        }
                            break;
                        case 1:
                        {
                             weakSelf.storeModel.label2 = selectTitle;
                        }
                             break;
                        case 2:
                        {
                            weakSelf.storeModel.label3 = selectTitle;
                        }
                            break;
                        case 3:
                        {
                            weakSelf.storeModel.label4 = selectTitle;
                        }
                            break;
                        case 4:
                        {
                            weakSelf.storeModel.label5 = selectTitle;
                        }
                            break;
                        default:
                            break;
                    }
                }
                [weakSelf.storeTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:7 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }];
            
        }
    }
}
- (void)clickEditedStoreAddressWithCityCell
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    if (isUsableNSString(self.storeProvence, @"")) {
        NSArray *cityArr = [XCPickerCityHandler  pickerCityWithIndexStr:self.storeProvence];
        __weak __typeof(self) weakSelf = self;
        SelectStateView *selectView = [[SelectStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) datArray:cityArr indexName:self.storeModel.city WithCompletionHandler:^(NSString *string) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            strongSelf.storeModel.city = string;
            self.storeCity = string;
            XCCheckoutDetailTextFiledCell *cell =  [strongSelf.storeTableView cellForRowAtIndexPath:indexPath];
            cell.textField.text = string;
        }];
        [self.view addSubview:selectView];
    }
}

- (void)clickEditedStoreAddressWithAreaCell
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    if (isUsableNSString(self.storeModel.city,@"") && isUsableNSString(self.storeProvence, @"")) {
        NSArray *cityArr = [XCPickerCityHandler  pickerCityWithIndexStr:self.storeProvence cityStr:self.storeCity];
        __weak __typeof(self) weakSelf = self;
        SelectStateView *selectView = [[SelectStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) datArray:cityArr indexName:self.storeArea WithCompletionHandler:^(NSString *string) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            strongSelf.storeModel.area = string;
            strongSelf.storeArea = string;
            XCCheckoutDetailTextFiledCell *cell =  [strongSelf.storeTableView cellForRowAtIndexPath:indexPath];
            cell.textField.text = string;
        }];
        [self.view addSubview:selectView];
    }else {
        [self showAlterInfoWithNetWork:@"请先进行详细地址定位" complete:nil];
    }
}

#pragma mark - Delegates & Notifications

#pragma mark - AMapSearchDelegate

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response;
{
//    AMapGeocodeSearchRequest *req = [[AMapGeocodeSearchRequest alloc] init];
//    req.address = response.regeocode.formattedAddress;
//    [self.searchAPI AMapGeocodeSearch:req];
//
//    AMapReGeocode *regeocode = response.regeocode;
//    AMapAddressComponent *addressComponent = regeocode.addressComponent;
    if (self.storeModel) {
        if (response.geocodes.count > 0) {
            AMapGeocode *geoCode = [response.geocodes firstObject];
            self.storeModel.latitude =  [NSString stringWithFormat:@"%f",geoCode.location.latitude];
            self.storeModel.longitude = [NSString stringWithFormat:@"%f",geoCode.location.longitude];
            self.storeProvence = geoCode.province;
            self.storeCity = geoCode.city;
            self.storeArea = geoCode.district;
            NSLog(@"=======>latitude:%f",geoCode.location.latitude);
            NSLog(@"=======>longitude:%f",geoCode.location.longitude);
            
        }
    }
   
}


#pragma mark -priceCIQChangeViewDelegate
- (void)changeModel:(BOOL)isLaseY{
    if (isLaseY) {
        self.viewBear.frame = CGRectMake(0, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
        self.viewLastY.hidden = NO ;
    } else {
        self.viewLastY.hidden = YES ;
        self.services = [[NSArray alloc] init];
        NSDictionary *param = @{
                                @"storeId":[UserInfoManager shareInstance].storeID,
                                };
        __weak __typeof(self) weakSelf = self;
        [RequestAPI getStoreService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if (isUsable(response[@"data"], [NSArray class])) {
                NSArray *dataInfoArr = response[@"data"];
                strongSelf.services = dataInfoArr;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.serviceTableView reloadData];
            });
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
        }];
        self.viewBear.frame = CGRectMake(-SCREEN_WIDTH, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
    }
}

#pragma mark - XCDistributionFooterViewDelegate

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    
    BOOL configureSuccess = YES;
    NSString *errorStr = @"门店信息错误,请联系客服！";

    if (!isUsableNSString(_storeModel.name,@"")) {
        _storeModel.name = @"";
    }
    if (!isUsableNSString(_storeModel.tel,@"")) {
        _storeModel.tel = @"";
    }
    if (!isUsableNSString(_storeModel.type,@"")) {
//        configureSuccess = NO;
//        errorStr = @"未知门店类型,请联系客服!";
        _storeModel.type = @"";
    }
    if (!isUsableNSString(_storeModel.corporateName,@"")) {
        _storeModel.corporateName = @"";
    }
    if (![self valiMobile:_storeModel.corporateCellphone]) {
        errorStr = @"请输入正确负责人电话";
        configureSuccess = NO;
    }
    if (!isUsable(_storeModel.salesmanCommission, [NSNumber class])) {
        _storeModel.salesmanCommission = [NSNumber numberWithDouble:0.00];
    }
    if (!isUsable(_storeModel.managerCommission, [NSNumber class])) {
        _storeModel.managerCommission = [NSNumber numberWithDouble:0.00];
    }
    if (!isUsableNSString(_storeModel.longitude, @"")) {
        _storeModel.longitude = @"";
    }
    if (!isUsableNSString(_storeModel.latitude, @"")) {
        _storeModel.longitude = @"";
    }
    if (!isUsableNSString(_storeModel.city, @"")) {
        _storeModel.city = @"";
    }
    if (!isUsableNSString(_storeModel.area, @"")) {
        _storeModel.area = @"";
    }
    if (!isUsableNSString(_storeModel.address, @"")) {
        _storeModel.address = @"";
    }
    if (!isUsable([UserInfoManager shareInstance].storeID, [NSNumber class])) {
        configureSuccess = NO;
    }
    
    if (configureSuccess) {
        __weak __typeof(self) weakSelf = self;
        LYZAlertView *alterView = [LYZAlertView alterViewWithTitle:@"是否修改门店信息" content:nil confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [strongSelf postUpLoadLocalPhoto];
        }];
        [self.view addSubview:alterView];
    }else {
        [self showAlterInfoWithNetWork:errorStr complete:nil];
    }
}

#pragma mark - XCDistributionPicketCellDelegate

-(void)XCDistributionPicketCellClickArrowBtn:(UIButton *)button title:(NSString *)title cell:(XCDistributionPicketCell *)cell
{
    if ([title isEqualToString:@"门店审核状态"]) {
        [XCShopRejectView alterViewWithTitle:@"拒绝原因"
                                     content:self.storeModel.repulseRemark
                                confirmClick:nil];
    }
}

#pragma mark - XCCheckoutDetailTextFiledCellDelegate

- (void)XCCheckoutDetailTextFiledBeginEditing:(UITextField *)textField title:(NSString *)title
{
    self.selectedTitle = title;
    NSMutableString *tmpTitleM = [NSMutableString stringWithString:title];
    NSArray *strArr = [tmpTitleM componentsSeparatedByString:@" "];
    if (strArr.count > 1) {
        title = strArr[1];
    }
    
    if ([title isEqualToString:@"门店电话:"]) {
        if (isUsableNSString(_storeModel.tel, @"")) {
            NSMutableString *mutalStr = [NSMutableString stringWithString:_storeModel.tel];
            textField.text = [mutalStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
    }
    
}

- (void)XCCheckoutDetailTextFiledSubmitTextField:(UITextField *)textField title:(NSString *)title
{
    NSMutableString *tmpTitleM = [NSMutableString stringWithString:title];
    NSArray *strArr = [tmpTitleM componentsSeparatedByString:@" "];
    if (strArr.count > 1) {
        title = strArr[1];
    }
    
    if ([title isEqualToString:@"门店名称:"]) {
        _storeModel.name = textField.text;
    }
    else if ([title isEqualToString:@"门店电话:"]) {
            [textField setText:[textField.text areaCodeFormat]];
        if (isUsableNSString(textField.text, @"")) {
            _storeModel.tel = [textField.text areaCodeFormat];
        }else {
            [self showAlterInfoWithNetWork:@"请输入正确固话格式" complete:nil];
        }
    }
    else if ([title isEqualToString:@"负责人:"]) {
        _storeModel.corporateName = textField.text;
    }
    else if ([title isEqualToString:@"负责人电话:"]) {
        if ([self valiMobile:textField.text]) {
            _storeModel.corporateCellphone = textField.text;
        }else {
            [self showAlterInfoWithNetWork:@"请输入正确格式电话" complete:nil];
        }
    }
    else if ([title isEqualToString:@"所属城市"]) {
        self.storeCity = textField.text;
        self.storeModel.city = textField.text;
    }
    else if ([title isEqualToString:@"所在地区"]) {
        self.storeArea = textField.text;
        self.storeModel.area = textField.text;
    }
    else if ([title isEqualToString:@"详细地址"]) {
        self.
        self.storeModel.address = textField.text;
        [self mapSearch];
    }
    
    
}

- (BOOL)XCCheckoutDetailTextFiledShouldChangeCharactersInRange:(NSRange)range
                                             replacementString:(NSString *)string
                                                         title:(NSString *)title
                                                     textFiled:(UITextField *)textFiled
{
    if ([title isEqualToString:@"业务员提成:"]||[title isEqualToString:@"团队经理提成:"]) {
//        if (range.location > 4 ) {
//            return NO;
//        }
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890."] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)  {
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)XCCheckoutDetailTextFiledClickBtn:(UITextField *)textField title:(NSString *)title
{
    NSMutableString *tmpTitleM = [NSMutableString stringWithString:title];
    NSArray *strArr = [tmpTitleM componentsSeparatedByString:@" "];
    if (strArr.count > 1) {
        title = strArr[1];
    }
    if ([title isEqualToString:@"所属城市"]) {
        [self clickEditedStoreAddressWithCityCell];
    }
    else if ([title isEqualToString:@"所在城市"]) {
        [self clickEditedStoreAddressWithAreaCell];
    }
    else if ([title isEqualToString:@"详细地址"]) {
        // 跳转地图
        XCShopAMapViewController *mapVC = [[XCShopAMapViewController alloc] initWithTitle:@"地图定位"];
        mapVC.delegate = self;
        [self.navigationController pushViewController:mapVC animated:YES];
    }

}

#pragma  mark - XCCheckoutDetailPhotoCellDelegate
//点击图片预览
- (void)XCCheckoutDetailPhotoCellClickphotoWithURL:(NSURL *)photoURL
                                             index:(NSInteger)index
                                              cell:(XCCheckoutDetailPhotoCell *)cell
{
    
    __weak __typeof(self) weakSelf = self;
    if ([cell.title isEqualToString:@"营业执照上传,1张"]) {
//            XCPhotoPreViewController *previewVC = [[XCPhotoPreViewControll≥er alloc] initWithTitle:@"照片预览" sources:self.lincePhotoArrM];
        XCPhotoPreViewController *previewVC = [[XCPhotoPreViewController alloc] initWithTitle:@"照片预览" sources:self.lincePhotoArrM comlectionBlock:^(NSArray<NSURL *> *deleArray) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if (deleArray.count > 0) {
                for (NSString *imagePath in deleArray) {
                    if ([strongSelf isUsefulURLWith:imagePath]) {
                        //网络删除
                        [strongSelf.tmpDeleteURLArrM addObject:imagePath];
                    }else {
                        //本地删除
                        if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
                            [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
                        }
                        unlink([imagePath  UTF8String]);
                    }
                    [strongSelf.lincePhotoArrM removeObject:imagePath];
                }
            }
            NSIndexPath *indexPath = [strongSelf.storeTableView indexPathForCell:cell];
            [strongSelf.storeTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        if ([self.storeModel.storeStatus isEqualToString:kshopStatusDaiShenHe]) {
            previewVC.shouldShowDeleBtm = NO;
        }else {
            previewVC.shouldShowDeleBtm = YES;
        }
        [self.navigationController pushViewController:previewVC animated:YES];
    }
    else if([cell.title isEqualToString:@"门店图片,最多4张"]) {
        
        XCPhotoPreViewController *previewVC = [[XCPhotoPreViewController alloc] initWithTitle:@"照片预览" sources:self.storePhotoArrM comlectionBlock:^(NSArray<NSURL *> *deleArray) {
            
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if (deleArray.count > 0) {
                for (NSString *imagePath in deleArray) {
                    if ([strongSelf isUsefulURLWith:imagePath]) {
                        //网络删除
                        [strongSelf.tmpDeleteURLArrM addObject:imagePath];
                    }else {
                        //本地删除
                        if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
                            [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
                        }
                        unlink([imagePath  UTF8String]);
                    }
                    [strongSelf.storePhotoArrM removeObject:imagePath];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                [cell setPhotoArr:strongSelf.storePhotoArrM];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexPath *indexPath = [strongSelf.storeTableView indexPathForCell:cell];
                [strongSelf.storeTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            });
           
        }];
        if ([self.storeModel.storeStatus isEqualToString:kshopStatusDaiShenHe]) {
            previewVC.shouldShowDeleBtm = NO;
        }else {
            previewVC.shouldShowDeleBtm = YES;
        }
        [previewVC updatePositionWithIndex:index];
        [self.navigationController pushViewController:previewVC animated:YES];
    }

}
//添加图片
- (void)XCCheckoutDetailPhotoCellClickAddPhotosImageView:(UIImageView *)imageView
                                                    cell:(XCCheckoutDetailPhotoCell *)cell
{
    self.currentPhotoCell = cell;
//    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
//    [action showInView:self.navigationController.view];
    TZImagePickerController *imagePickerVc = [self createPickerPhotoViewController];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)XCCheckoutDetailPhotoCellChangePhotoArr:(NSArray *)photoArr cell:(XCCheckoutDetailPhotoCell *)cell
{
    NSString *title = cell.titleLabel.text;
    NSMutableString *tmpTitleM = [NSMutableString stringWithString:title];
    NSArray *strArr = [tmpTitleM componentsSeparatedByString:@" "];
    if (strArr.count > 1) {
        title = strArr[1];
    }
    if([title isEqualToString:@"门店图片,最多4张"])
    {
        if(photoArr.count > 0) {
            self.storePhotoArrM = [NSMutableArray arrayWithArray:photoArr];
        }
    }
}

#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *vc = [UIImagePickerController new];
            vc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
            vc.delegate = self;
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 1:
        {
        
            if ([self.currentPhotoCell.title isEqualToString:@"营业执照上传,1张"]) {
//                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
//                imagePickerVc.allowPickingVideo = NO;
//                imagePickerVc.allowCrop = YES ;
//                imagePickerVc.cropRect = CGRectMake(0, clip_Y, clipWidth, clipHeight);
//                imagePickerVc.sortAscendingByModificationDate = YES;
                TZImagePickerController *imagePickerVc = [self createPickerPhotoViewController];
                [self presentViewController:imagePickerVc animated:YES completion:nil];
            }else {
//                NSInteger maxCount = 4;
//                NSInteger count = maxCount - self.storePhotoArrM.count;
//                if (count < 0) {
//                    count = 0 ;
//                }
//                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
//                imagePickerVc.allowPickingVideo = NO;
//                imagePickerVc.allowCrop = YES ;
//                imagePickerVc.cropRect = CGRectMake(0, clip_Y, clipWidth, clipHeight);
//                imagePickerVc.sortAscendingByModificationDate = YES;
//                [self presentViewController:imagePickerVc animated:YES completion:nil];
                TZImagePickerController *imagePickerVc = [self createPickerPhotoViewController];
                [self presentViewController:imagePickerVc animated:YES completion:nil];
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark - TZImagePickerControllerDelegate - 新照片

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    
    if ([self.currentPhotoCell.title isEqualToString:@"营业执照上传,1张"]) {
        if(photos.count == 1) {
            UIImage *lienceImage = [photos firstObject];
            NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingString:
                                 [NSString stringWithFormat:@"linceImage%@.jpg",[NSString getNowTimeTimestamp]]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:tmpPath]) {
                [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
            }
            unlink([tmpPath  UTF8String]);
            [UIImageJPEGRepresentation(lienceImage, 1.0) writeToFile:tmpPath atomically:YES];
            NSURL *tmpFileURL = [NSURL fileURLWithPath:tmpPath];
            [self.lincePhotoArrM addObject:[tmpFileURL absoluteString]];
        }
        
    }
    else if ([self.currentPhotoCell.title isEqualToString:@"门店图片,最多4张"]) {
        for (UIImage *newImage  in photos) {
            NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingString:
                                 [NSString stringWithFormat:@"storeImage%@%ld.jpg",[NSString getNowTimeTimestamp],self.storePhotoArrM.count]];
            NSLog(@"%@",tmpPath);
            if ([[NSFileManager defaultManager] fileExistsAtPath:tmpPath]) {
                [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
            }
            unlink([tmpPath  UTF8String]);
            [UIImageJPEGRepresentation(newImage, 1.0) writeToFile:tmpPath atomically:YES];
            NSURL *tmpFileURL = [NSURL fileURLWithPath:tmpPath];
            [self.storePhotoArrM addObject:[tmpFileURL absoluteString]];
        }
    }
    //完成
    NSLog(@"=========>D");
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.currentPhotoCell.title isEqualToString:@"营业执照上传,1张"]) {
            if (self.lincePhotoArrM.count == 1) {
                [self.currentPhotoCell setPhotoArr:self.lincePhotoArrM];
            }else {
                NSLog(@"===========>Error lincePhotoArrM");
            }
        }
        else if ([self.currentPhotoCell.title isEqualToString:@"门店图片,最多4张"]) {
            [self.currentPhotoCell setPhotoArr:self.storePhotoArrM];
        }
    });
}

#pragma  mark - imagePickerController Delegate - 拍照
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self imageHandleWithpickerController:picker MdediaInfo:info];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imageHandleWithpickerController:(UIImagePickerController *)picker MdediaInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        imageToSave = [UIImage fixOrientation:imageToSave];
        // Save the new image (original or edited) to the Camera Roll
            [self photoCellHanderSelectImage:imageToSave];
    }
    NSIndexPath *indexpath = [self.storeTableView indexPathForCell:self.currentPhotoCell];
    [self.storeTableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - XCShopAMapViewControllerDelegate 地图

- (void)XCShopAMapViewControllerDidConfirmWithAMapAddressComponent:(AMapAddressComponent *)selectComponent
                                                        coordinate:(CLLocationCoordinate2D)coordiante
{
    if (isUsable(selectComponent, [AMapAddressComponent class])) {
        NSString *city = selectComponent.city;
        NSString *area = selectComponent.district;
        NSString *address = [NSString stringWithFormat:@"%@%@%@ %@",selectComponent.city,selectComponent.district,selectComponent.township,selectComponent.building];
        if (isUsableNSString(city,@"")) {
            self.storeCity = city;
            [self.storeModel setCity:city];
        }
        if (isUsableNSString(area,@"")) {
            self.storeArea = area;
            [self.storeModel setArea:area];
        }
        if (isUsableNSString(address,@"")) {
            [self.storeModel setAddress:address];
        }
        if (coordiante.latitude != 0.0 && coordiante.longitude != 0.0) {
            [self.storeModel setLatitude:[NSString stringWithFormat:@"%f",coordiante.latitude]];
            [self.storeModel setLongitude:[NSString stringWithFormat:@"%f",coordiante.longitude]];
        }
        self.storeProvence = selectComponent.province;
    }
    NSIndexPath * cityIndexpath = [NSIndexPath indexPathForRow:6 inSection:0];
    NSIndexPath * areaIndexpath = [NSIndexPath indexPathForRow:7 inSection:0];
    NSIndexPath * addressIndexpath = [NSIndexPath indexPathForRow:8 inSection:0];
    [self.storeTableView reloadRowsAtIndexPaths:@[cityIndexpath,areaIndexpath,addressIndexpath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.storeTableView) {
        return self.storeTitleArr.count;
    }else { //服务信息
        return self.services.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.storeTableView) {
        NSString *title = self.storeTitleArr[indexPath.row];
        NSString *holderStr = self.placeHolderArr[indexPath.row];

        if ([self isPhotoCellWithIndex:indexPath]) {
            XCCheckoutDetailPhotoCell *photoCell = (XCCheckoutDetailPhotoCell *)[tableView dequeueReusableCellWithIdentifier:kaddPhotoCellID];
            photoCell.delegate = self;
            [photoCell setTitle:title];
            if ([title isEqualToString:@"营业执照上传,1张"]) {
                [photoCell setMaxPhoto:1];
                [photoCell setPhotoArr:self.lincePhotoArrM];
            }
            if ([title isEqualToString:@"门店图片,最多4张"]) {
                [photoCell setMaxPhoto:4];
                [photoCell setPhotoArr:self.storePhotoArrM];
            }
            return photoCell;
        }else if ([self isPicketCellWithIndex:indexPath]) {
            XCDistributionPicketCell *picketCell =(XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID];
            picketCell.titleLabel.text = title;
            [picketCell setTitleValue:holderStr];
            [picketCell setupCellWithShopModel:self.storeModel];
            if ([self.storeModel.storeStatus isEqualToString:kshopStatusDaiShenHe]) {
                picketCell.userInteractionEnabled = NO;
            }else {
                picketCell.userInteractionEnabled = YES;
            }
            return picketCell;
        }else if ([title isEqualToString:@"门店审核状态"]) {
            XCDistributionPicketCell *pickerCell = (XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID];
            pickerCell.titleLabel.text = title;
            pickerCell.delegate = self;
            if (isUsableNSString(self.storeModel.storeStatus, @"")) {
                pickerCell.titleValue = self.storeModel.storeStatus;
            }else {
                pickerCell.titleValue = @"待审核";/// 写死了
            }
            if ([self.storeModel.storeStatus isEqualToString:kshopStatusDaiShenHe]) {
                pickerCell.userInteractionEnabled = NO;
            }else {
                pickerCell.userInteractionEnabled = YES;
            }
            if ([self.storeModel.storeStatus isEqualToString:@"已拒绝"]) {
                pickerCell.shouldShowArrow = YES;
                pickerCell.userInteractionEnabled = YES;
            }else {
                pickerCell.shouldShowArrow = NO;
                pickerCell.userInteractionEnabled = NO;
            }
            return pickerCell;
        }else {
            XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID];
            textFiledCell.delegate = self;
            textFiledCell.title = title;
            [textFiledCell setTextFiledBGColor:[UIColor whiteColor]];
            [textFiledCell setTitlePlaceholder:holderStr];
            textFiledCell.shouldShowSeparator = YES;
            textFiledCell.shouldShowClickView = NO;
            [textFiledCell.textField setTextAlignment:NSTextAlignmentLeft];

            if ([self isInputNumKeyBoardCellWithTitle:title]) {
                [textFiledCell setIsNumField:YES];
                textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            }
            else if([title isEqualToString:@"所属城市"]) {
                textFiledCell.shouldShowClickView = YES;
                [textFiledCell.textField setTextAlignment:NSTextAlignmentRight];
            }
            else if([title isEqualToString:@"所在地区"]) {
                textFiledCell.shouldShowClickView = YES;
                [textFiledCell.textField setTextAlignment:NSTextAlignmentRight];
            }
            else if([title isEqualToString:@"详细地址"]) {
                textFiledCell.shouldShowClickView = YES;
                [textFiledCell.textField setTextAlignment:NSTextAlignmentRight];
            }
            
            if (self.storeModel) {
                [textFiledCell setupCellWithShopModel:self.storeModel];
            }
            
            //判断审核状态决定是否能编辑
            if ([self.storeModel.storeStatus isEqualToString:kshopStatusDaiShenHe]) {
                textFiledCell.userInteractionEnabled = NO;
            }else {
                textFiledCell.userInteractionEnabled = YES;
            }
            return textFiledCell;
        }
    }else  {
        //服务TableView
        NSString *title = @"";
        NSDictionary *serviceInfo = self.services[indexPath.row];
        title = serviceInfo[@"categoryServie"];
//        if (self.serviceTitleArr.count > indexPath.row) {
//            title = self.serviceTitleArr[indexPath.row];
//        }
        XCDistributionPicketCell *picketCell =(XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID];
        picketCell.titleLabel.text = title;
        if (picketCell == nil) {
            picketCell =[[XCDistributionPicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPicketCellID];
            picketCell.titleLabel.text = title;

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
        if ([self.storeModel.storeStatus isEqualToString:kshopStatusDaiShenHe]) {
            [footerView.confirmBtn setBackgroundColor:COLOR_RGB_255(204, 204, 204)];
            footerView.userInteractionEnabled = NO ;
            [footerView setTitle:@"正在审核"];
        }else {
            footerView.userInteractionEnabled = YES ;
        }
        if ([self.storeModel.storeStatus isEqualToString:@"已拒绝"]) {
            [footerView setTitle:@"重新提交审核"];
        }
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
- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [_viewBear removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)showAlterInfoWithNetWork:(NSString *)titleStr complete:(void (^)(void))complete
{
    dispatch_async(dispatch_get_main_queue(), ^{
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:titleStr complete:complete];
        [self.view addSubview:tipsView];
    });
   
}

- (BOOL)isPicketCellWithIndex:(NSIndexPath *)indexpath
{
    if (indexpath.row == 7) {
        return YES;
    }
    return NO;
}

- (BOOL)isPhotoCellWithIndex:(NSIndexPath *)indexpath
{
    if ( indexpath.row == 9|| indexpath.row == 10) {
        return YES;
    }
    return NO;
}

- (BOOL)isUsefulURLWith:(NSString *)photoPath
{
    BOOL result = NO;
    if (isUsableNSString(photoPath, @"")) {
        if ([photoPath hasPrefix:@"http://"]||[photoPath hasPrefix:@"https://"]) {
            result = YES;
        }
    }
    return result;
}

//判断是否弹出数组键盘
- (BOOL)isInputNumKeyBoardCellWithTitle:(NSString *)title
{
    BOOL result = NO;
    if ([title isEqualToString:@"门店电话:"]) {
        result = YES;
    }
    else if ([title isEqualToString:@"负责人电话:"]){
        result = YES;
    }
//    else if ([title isEqualToString:@"业务员提成:"]) {
//        result = YES;
//    }
//    else if ([title isEqualToString:@"团队经理提成:"]) {
//        result = YES;
//    }
    
    return result;
}

//获取线上图片数组
- (NSMutableArray *)getOrigianShopPhotoWithModel:(XCShopModel *)storeModel
{
    NSMutableArray *photoURLArrM = [[NSMutableArray alloc] init];
    if ([self isUsefulURLWith:storeModel.url1]) {
        [photoURLArrM addObject:storeModel.url1];
    }
    if ([self isUsefulURLWith:storeModel.url2]) {
        [photoURLArrM addObject:storeModel.url2];
    }
    if ([self isUsefulURLWith:storeModel.url3]) {
        [photoURLArrM addObject:storeModel.url3];
    }
    if ([self isUsefulURLWith:storeModel.url4]) {
        [photoURLArrM addObject:storeModel.url4];
    }
    return photoURLArrM;
}

//处理选择图片
- (void)photoCellHanderSelectImage:(UIImage *)image
{
    if ([self.currentPhotoCell.title isEqualToString:@"营业执照上传,1张"]) {
        
        NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingString:
                             [NSString stringWithFormat:@"linceImage%@.jpg",[NSString getNowTimeTimestamp]]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:tmpPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
        }
        unlink([tmpPath  UTF8String]);
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:tmpPath atomically:YES];
        NSURL *tmpFileURL = [NSURL fileURLWithPath:tmpPath];
        [self.lincePhotoArrM addObject:[tmpFileURL absoluteString]];

    }
    else if ([self.currentPhotoCell.title isEqualToString:@"门店图片,最多4张"]) {
        
        NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingString:
                             [NSString stringWithFormat:@"storeImage%@%lu.jpg",[NSString getNowTimeTimestamp],(unsigned long)self.storePhotoArrM.count]];
        NSLog(@"%@",tmpPath);
        if ([[NSFileManager defaultManager] fileExistsAtPath:tmpPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
        }
        unlink([tmpPath  UTF8String]);
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:tmpPath atomically:YES];
        NSURL *tmpFileURL = [NSURL fileURLWithPath:tmpPath];
        [self.storePhotoArrM addObject:[tmpFileURL absoluteString]];
    }
    
}

- (void)mapSearch
{
    if (self.storeModel) {
        if(isUsableNSString(self.storeModel.address, @""))
        {
            AMapGeocodeSearchRequest *req = [[AMapGeocodeSearchRequest alloc] init];
            req.address = _storeModel.address;
            [self.searchAPI AMapGeocodeSearch:req];
        }
    }
}

- (TZImagePickerController *)createPickerPhotoViewController
{
    CGFloat rate = 35/18.0;
    NSInteger clipWidth = SCREEN_WIDTH;
    NSInteger clipHeight = SCREEN_WIDTH / rate;
    NSInteger clip_Y = (SCREEN_HEIGHT - clipHeight) * 0.5 ;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowCrop = YES ;
    imagePickerVc.cropRect = CGRectMake(0, clip_Y, clipWidth, clipHeight);
    imagePickerVc.sortAscendingByModificationDate = YES;
    return imagePickerVc;
}

- (NSMutableArray *)getXCShopSelectLabelArr
{
    NSMutableArray *labelArr = [[NSMutableArray alloc] init];
    XCShopModel *model = self.storeModel;
    if (isUsableNSString(model.label1, @"")) {
        [labelArr addObject:model.label1];
    }
    if (isUsableNSString(model.label2, @"")) {
        [labelArr addObject:model.label2];
    }
    if (isUsableNSString(model.label3, @"")) {
        [labelArr addObject:model.label3];
    }
    if (isUsableNSString(model.label4, @"")) {
        [labelArr addObject:model.label4];
    }
    if (isUsableNSString(model.label5, @"")) {
        [labelArr addObject:model.label5];
    }
    return labelArr;
}


#pragma mark -  ========== 添加键盘通知 ==========

- (void)addObserverKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)removeObserverKeyBoard {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

//键盘显示
- (void)keyboardShow:(NSNotification *)notification {
    
    if (isUsableNSString(self.selectedTitle, @"")) {
        if (!( [self.selectedTitle isEqualToString:@"详细地址:"])) {
            return;
        }
    }
    NSValue *keyboardEndFrameValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame;
    [keyboardEndFrameValue getValue:&keyboardEndFrame];
    //    NSLog(@"=====>:%d",(int)keyboardEndFrame.size.height);
    //向上移动
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = weakSelf.storeTableView.frame;
        frame.size.height = ktableViewH -  (keyboardEndFrame.size.height );
        weakSelf.storeTableView.frame = frame;
        [weakSelf scrollViewToBottom:NO];
    }];
    
}

//键盘隐藏
- (void)keyboardHide:(NSNotification *)notification {
    //往下移动
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = weakSelf.storeTableView.frame;
        frame.size.height = ktableViewH ;
        weakSelf.storeTableView.frame = frame;
    }];
    
}

- (void)scrollViewToBottom:(BOOL)animated
{
    if (self.storeTableView.contentSize.height > self.storeTableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.storeTableView.contentSize.height - self.storeTableView.frame.size.height  );
        [self.storeTableView setContentOffset:offset animated:animated];
        
    }
}

#pragma mark - Setter&Getter

- (void)setStoreModel:(XCShopModel *)storeModel
{
    if (!storeModel) {
        return;
    }
    _storeModel = storeModel;
    self.storePhotoArrM = [self getOrigianShopPhotoWithModel:_storeModel]; //获取线上图片数组
    if ([self isUsefulURLWith: _storeModel.licenseUrl]) {
        if (self.lincePhotoArrM.count > 0) {
            [self.lincePhotoArrM removeAllObjects];
        }
        [self.lincePhotoArrM addObject:_storeModel.licenseUrl];
    }
    [self mapSearch];
}

- (UIView *)contenView{
    if (!_contenView) {
        _contenView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation - safeAreaBottom)];
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
        _serviceTableView.bounces = NO;
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
        _storeTableView.bounces = NO;
        _storeTableView.separatorColor = [UIColor purpleColor];
        _storeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_storeTableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
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
