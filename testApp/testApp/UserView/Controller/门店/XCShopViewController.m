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
#import "JFImagePickerController.h"
#import "XCPhotoPreViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "UIImage+imageHelper.h"
#define ktableViewH SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom + 160 * ViewRateBaseOnIP6)

@interface XCShopViewController ()<UITableViewDelegate,
UITableViewDataSource,priceCIQChangeViewDelegate,BaseNavigationBarDelegate,
XCDistributionFooterViewDelegate,XCCheckoutDetailPhotoCellDelegate,
UINavigationControllerDelegate,UIImagePickerControllerDelegate,
XCShopAMapViewControllerDelegate,XCCheckoutDetailTextFiledCellDelegate,UIActionSheetDelegate,JFImagePickerDelegate>
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
/** 服务tableViewTitle数据 */
@property (nonatomic, strong) NSArray * serviceTitleArr ;
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


/** 上传成功图片URL */
@property (nonatomic, strong) NSMutableArray * networkURLArrM ;
/** tmp保存即将删除图片的数组 */
@property (nonatomic, strong) NSMutableArray *tmpDeleteURLArrM  ;
@end

@implementation XCShopViewController
- (void)dealloc {
  
    for (NSString *filePath in self.lincePhotoArrM) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        unlink([filePath  UTF8String]);
    }
    for (NSString *filePath in self.storePhotoArrM) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        unlink([filePath  UTF8String]);
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
    [self addObserverKeyboard];
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
- (void)configureData
{
    self.storeTitleArr = @[@"门店名称:",@"联系方式:",@"负责人:",
                           @"负责人电话:",@"业务员提成:",@"团队经理提成:",
                           @"所属城市",@"所在地区",@"详细地址:",@"门店审核状态",
                           @"营业执照上传,1张",@"门店图片,最多4张"];
    self.placeHolderArr = @[@"请输入门店名称",@"请输入联系方式",@"请输入负责人",
                            @"请输入负责人电话",@"请输入百分比",@"请输入百分比",@"城市",@"地区",@"",@"待审核",@"1张",@"4张"];
    self.serviceTitleArr = @[@"洗车项目",@"美容项目",@"保养项目"];
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
    
    dispatch_semaphore_t videoTrackSynLoadSemaphore;
    videoTrackSynLoadSemaphore = dispatch_semaphore_create(0);
    dispatch_time_t maxVideoLoadTrackTimeConsume = dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC);
    __weak __typeof(self) weakSelf = self;
    NSDictionary *param = @{
                            @"id":_storeModel.storeID,
                            @"tel":_storeModel.tel,
                            @"name":_storeModel.name,
                            @"corporateName":_storeModel.corporateName,
                            @"corporateCellphone":_storeModel.corporateCellphone,
                            @"address":_storeModel.address,
                            @"longitude":_storeModel.longitude,
                            @"latitude":_storeModel.latitude,
                            @"type":_storeModel.type,
                            @"city":_storeModel.city,
                            @"area":_storeModel.area,
                            @"salesmanCommission":_storeModel.salesmanCommission,
                            @"managerCommission":_storeModel.managerCommission,
                            @"licenseUrl":_storeModel.licenseUrl,
                            @"url1":_storeModel.url1,
                            @"url2":_storeModel.url2,
                            @"url3":_storeModel.url3,
                            @"url4":_storeModel.url4,
                            };
    [RequestAPI postUpdateStore:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        NSString *errStr = response[@"errormsg"];
        if ([response[@"result"] integerValue] == 1) {
//            [strongSelf showAlterInfoWithNetWork:@"提交成功" complete:^{

                [strongSelf.networkURLArrM  removeAllObjects];
                [strongSelf deleteAllTmpPhoto];
//            }];
        }else {
            [strongSelf showAlterInfoWithNetWork:errStr complete:nil];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
        [strongSelf showAlterInfoWithNetWork:errStr complete:nil];
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
                strongSelf.storePhotoArrM = [strongSelf getOrigianShopPhotoWithModel:strongSelf.storeModel];
                [strongSelf.lincePhotoArrM removeAllObjects];
                NSArray *urlStrArr  = response[@"data"];
                for (NSString *urlPath in urlStrArr) {
                    [strongSelf.lincePhotoArrM addObject:urlPath];
                    [strongSelf.networkURLArrM addObject:urlPath];
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
            NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
            [strongSelf showAlterInfoWithNetWork:errStr complete:nil];
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
                    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                    }
                    unlink([filePath  UTF8String]);
                }
                strongSelf.storePhotoArrM = [strongSelf getOrigianShopPhotoWithModel:strongSelf.storeModel];
                NSArray *urlStrArr  = response[@"data"];
                for (NSString *urlPath in urlStrArr) {
                    [strongSelf.storePhotoArrM addObject:urlPath];
                    [strongSelf.networkURLArrM addObject:urlPath];
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
            NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
            [strongSelf showAlterInfoWithNetWork:errStr complete:nil];
            return ;
        }];
    }else {
        [self postModifyShopInfo];
    }
}

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
                serviceDetailVC.titleTypeStr = @"洗车";
                serviceDetailVC.storeID = self.storeModel.storeID;
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
                serviceDetailVC.titleTypeStr = @"美容";
                serviceDetailVC.storeID = self.storeModel.storeID;
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
                serviceDetailVC.titleTypeStr = @"保养";
                serviceDetailVC.storeID = self.storeModel.storeID;
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
//             [XCSelectCityView cityPickerViewWithSelectProvenceStr:@"广东省" CityBlock:^(NSString *city) {
//                 NSLog(@"====>%@",city);
//             }];
        }
        else if (indexPath.row == 7) {
            
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
        __weak __typeof(self) weakSelf = self;
        [RequestAPI getStoreService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if (response[@"data"]) {
                NSDictionary *dataInfo = response[@"data"];
                NSArray *xcServicesArr = dataInfo[@"xcServiceList"];
                NSArray *mrServicesArr = dataInfo[@"mrServiceList"];
                NSArray *byServicesArr = dataInfo[@"byServiceList"];
                strongSelf.services = [[NSMutableArray alloc] initWithArray:@[xcServicesArr,mrServicesArr,byServicesArr]];
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
            [strongSelf showAlterInfoWithNetWork:errStr complete:nil];
        }];
        self.viewBear.frame = CGRectMake(-SCREEN_WIDTH, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
    }
}

#pragma mark - XCDistributionFooterViewDelegate

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    
    BOOL configureSuccess = YES;
    NSString *errorStr = @"门店ID信息错误";

    if (!isUsableNSString(_storeModel.name,@"")) {
        _storeModel.name = @"";
    }
    if (!isUsableNSString(_storeModel.tel,@"")) {
        _storeModel.tel = @"";
    }
    if (!isUsableNSString(_storeModel.corporateName,@"")) {
        _storeModel.corporateName = @"";
    }
    if (![self valiMobile:_storeModel.corporateCellphone]) {
        errorStr = @"请输入正确负责人电话";
        configureSuccess = NO;
    }
    if (!isUsable(_storeModel.salesmanCommission, [NSNumber class])) {
        _storeModel.salesmanCommission = @(0.00);
    }
    if (!isUsable(_storeModel.managerCommission, [NSNumber class])) {
        _storeModel.managerCommission = @(0.00);
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
    if (!isUsable(_storeModel.storeID, [NSNumber class])) {
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

#pragma mark - XCCheckoutDetailTextFiledCellDelegate

- (void)XCCheckoutDetailTextFiledBeginEditing:(UITextField *)textField title:(NSString *)title
{
    self.selectedTitle = title;
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
    else if ([title isEqualToString:@"联系方式:"]) {
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
    else if ([title isEqualToString:@"业务员提成:"]) {
        if ([textField.text doubleValue] < 100) {
            double num = [textField.text doubleValue];
            NSString *numStr = [NSString stringWithFormat:@"%.2f%%",num];
            textField.text = numStr;
            _storeModel.salesmanCommission = [NSNumber numberWithDouble:num];
            
        }else {
            [self showAlterInfoWithNetWork:@"请输入正确百分比" complete:nil];
        }
    }
    else if ([title isEqualToString:@"团队经理提成:"]) {
        if ([textField.text doubleValue] < 100) {
            double num = [textField.text doubleValue];
            NSString *numStr = [NSString stringWithFormat:@"%.2f%%",num];
            textField.text = numStr;
            _storeModel.managerCommission = [NSNumber numberWithDouble:num];
            
        }else {
            [self showAlterInfoWithNetWork:@"请输入正确百分比" complete:nil];
        }
    }
}

- (BOOL)XCCheckoutDetailTextFiledShouldChangeCharactersInRange:(NSRange)range
                                             replacementString:(NSString *)string
                                                         title:(NSString *)title
                                                     textFiled:(UITextField *)textFiled
{
    if ([title isEqualToString:@"业务员提成:"]||[title isEqualToString:@"团队经理提成:"]) {
        if (range.location > 4 ) {
            return NO;
        }
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
    // 跳转地图
    XCShopAMapViewController *mapVC = [[XCShopAMapViewController alloc] initWithTitle:@"地图定位"];
    mapVC.delegate = self;
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma  mark - XCCheckoutDetailPhotoCellDelegate
//点击图片预览
- (void)XCCheckoutDetailPhotoCellClickphotoWithURL:(NSURL *)photoURL
                                             index:(NSInteger)index
                                              cell:(XCCheckoutDetailPhotoCell *)cell
{
    if (photoURL) {
        __weak __typeof(self) weakSelf = self;
        if ([cell.title isEqualToString:@"营业执照上传,1张"]) {
            XCPhotoPreViewController *previewVC = [[XCPhotoPreViewController alloc] initWithTitle:@"照片预览" sources:self.lincePhotoArrM];
            previewVC.shouldShowDeleBtm = YES;
            previewVC.completion = ^(NSArray<NSURL *> *deleArray) {
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
            };
            [self.navigationController pushViewController:previewVC animated:YES];
        }
        else if([cell.title isEqualToString:@"门店图片,最多4张"]) {
            
            XCPhotoPreViewController *previewVC = [[XCPhotoPreViewController alloc] initWithTitle:@"照片预览" sources:self.storePhotoArrM];
            previewVC.shouldShowDeleBtm = YES;
            [previewVC updatePositionWithIndex:index];
            previewVC.completion = ^(NSArray<NSURL *> *deleArray) {
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
                    [cell setPhotoArr:self.storePhotoArrM];
                }
                NSIndexPath *indexPath = [strongSelf.storeTableView indexPathForCell:cell];
                [strongSelf.storeTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:previewVC animated:YES];
        }
    }

}
//添加图片
- (void)XCCheckoutDetailPhotoCellClickAddPhotosImageView:(UIImageView *)imageView
                                                    cell:(XCCheckoutDetailPhotoCell *)cell
{
    self.currentPhotoCell = cell;
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
    [action showInView:self.navigationController.view];
    
}

#pragma mark - JFImagePickerDelegate 选择照片回调

- (void)imagePickerDidFinished:(JFImagePickerController *)picker
{
   _videoTrackSynLoadSemaphore = dispatch_semaphore_create(0);
    __weak __typeof(self) weakSelf = self;
    [ProgressControll showProgressNormal];
    __block NSInteger sloveCount = 0;
    __block NSInteger photoNum = 0;
    [picker.assets enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [[JFImageManager sharedManager] imageWithAsset:asset resultHandler:^(CGImageRef imageRef, BOOL longImage) {
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            // =================== modify by Liangyz 处理图片
            if ([strongSelf.currentPhotoCell.title isEqualToString:@"营业执照上传,1张"]) {
                
                NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingString:
                                     [NSString stringWithFormat:@"linceImage%@.jpg",[NSString getNowTimeTimestamp]]];
                if ([[NSFileManager defaultManager] fileExistsAtPath:tmpPath]) {
                    [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
                }
                unlink([tmpPath  UTF8String]);
                [UIImageJPEGRepresentation(image, 1.0) writeToFile:tmpPath atomically:YES];
                NSURL *tmpFileURL = [NSURL fileURLWithPath:tmpPath];
                [strongSelf.lincePhotoArrM addObject:[tmpFileURL absoluteString]];
            }
            else if ([strongSelf.currentPhotoCell.title isEqualToString:@"门店图片,最多4张"]) {
                NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingString:
                                     [NSString stringWithFormat:@"storeImage%@%lu.jpg",[NSString getNowTimeTimestamp],(unsigned long)photoNum]];
                NSLog(@"%@",tmpPath);
                if ([[NSFileManager defaultManager] fileExistsAtPath:tmpPath]) {
                    [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
                }
                unlink([tmpPath  UTF8String]);
                photoNum ++;
                [UIImageJPEGRepresentation(image, 1.0) writeToFile:tmpPath atomically:YES];
                NSURL *tmpFileURL = [NSURL fileURLWithPath:tmpPath];
                [strongSelf.storePhotoArrM addObject:[tmpFileURL absoluteString]];
            }
//            dispatch_semaphore_signal(_videoTrackSynLoadSemaphore);

            // ===================
            sloveCount++;
            NSLog(@"=======>%ld",(long)sloveCount); /// 线程0000000？(TODO)
            if (sloveCount == picker.assets.count) {
                //完成
                NSLog(@"=========>D");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ProgressControll dismissProgress];
                    [strongSelf imagePickerDidCancel:picker];
                    if ([strongSelf.currentPhotoCell.title isEqualToString:@"营业执照上传,1张"]) {
                        if (strongSelf.lincePhotoArrM.count == 1) {
                            [strongSelf.currentPhotoCell setPhotoArr:strongSelf.lincePhotoArrM];
                        }else {
                            NSLog(@"===========>Error lincePhotoArrM");
                        }
                    }
                    else if ([strongSelf.currentPhotoCell.title isEqualToString:@"门店图片,最多4张"]) {
                        [strongSelf.currentPhotoCell setPhotoArr:strongSelf.storePhotoArrM];
                    }
                    [JFImagePickerController clear];

                });
            
            }
        }];

    }];
}



- (void)imagePickerDidCancel:(JFImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma  mark - imagePickerController Delegate - 照片
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
    NSIndexPath *indexpath = [self.tableView indexPathForCell:self.currentPhotoCell];
    [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [picker dismissViewControllerAnimated:YES completion:^{}];
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
            NSInteger maxCount = 4;
            if ([self.currentPhotoCell.title isEqualToString:@"营业执照上传,1张"]) {
                maxCount = 1;
                NSInteger count = maxCount - self.lincePhotoArrM.count;
                if (count < 0) {
                    count = 0 ;
                }
                [JFImagePickerController setMaxCount:count];
                JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:[UIViewController new]];
                picker.pickerDelegate = self;
                [self.navigationController presentViewController:picker animated:YES completion:nil];
            }else {
                NSInteger count = maxCount - self.storePhotoArrM.count;
                if (count < 0) {
                    count = 0 ;
                }
                [JFImagePickerController setMaxCount:count];
                JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:[UIViewController new]];
                picker.pickerDelegate = self;
                [self.navigationController presentViewController:picker animated:YES completion:nil];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - XCShopAMapViewControllerDelegate 地图

- (void)XCShopAMapViewControllerDidConfirmWithAMapAddressComponent:(AMapAddressComponent *)selectComponent
                                                        coordinate:(CLLocationCoordinate2D)coordiante
{
    if (isUsable(selectComponent, [AMapAddressComponent class])) {
        NSString *city = selectComponent.city;
        NSString *area = selectComponent.district;
        NSString *address = [NSString stringWithFormat:@"%@%@%@ %@",selectComponent.city,selectComponent.district,selectComponent.township,selectComponent.building];
        if (isUsableNSString(city, @"")) {
            [self.storeModel setCity:city];
        }
        if (isUsableNSString(area,@"")) {
            [self.storeModel setArea:area];
        }
        if (isUsableNSString(address,@"")) {
            [self.storeModel setAddress:address];
        }
        if (coordiante.latitude != 0.0 && coordiante.longitude != 0.0) {
            [self.storeModel setLatitude:[NSString stringWithFormat:@"%f",coordiante.latitude]];
            [self.storeModel setLongitude:[NSString stringWithFormat:@"%f",coordiante.longitude]];
        }
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
        return self.serviceTitleArr.count;
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
                photoCell.isAnnualType = YES;
                [photoCell setPhotoArr:self.lincePhotoArrM];
            }
            if ([title isEqualToString:@"门店图片,最多4张"]) {
                [photoCell setMaxPhoto:4];
                photoCell.isAnnualType = NO;
                [photoCell setPhotoArr:self.storePhotoArrM];
            }
            return photoCell;
        }else if ([self isPicketCellWithIndex:indexPath]) {
            XCDistributionPicketCell *picketCell =(XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID];
            picketCell.title = title;
            [picketCell setTitleValue:holderStr];
            [picketCell setupCellWithShopModel:self.storeModel];
            return picketCell;
        }else if ([title isEqualToString:@"门店审核状态"]) {
            XCCheckoutDetailTextCell *textCell = (XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID];
            textCell.title = title;
            textCell.shouldTPRightMargin = YES;
            textCell.titlePlaceholder = holderStr;
            textCell.shouldShowSeparator = YES;
            return textCell;
        }else {
            XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID];
            textFiledCell.delegate = self;
            textFiledCell.title = title;
            [textFiledCell setTextFiledBGColor:[UIColor whiteColor]];
            [textFiledCell setTitlePlaceholder:holderStr];
            textFiledCell.shouldShowSeparator = YES;
            textFiledCell.shouldShowClickView = NO;

            if ([self isInputNumKeyBoardCellWithTitle:title]) {
                [textFiledCell setIsNumField:YES];
                textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            }else if ([title isEqualToString:@"业务员提成:"]||[title isEqualToString:@"团队经理提成:"]) {
                  textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            }else if([title isEqualToString:@"详细地址:"]) {
                textFiledCell.shouldShowClickView = YES;
            }
            if (self.storeModel) {
                [textFiledCell setupCellWithShopModel:self.storeModel];
            }
            return textFiledCell;
        }
    }else  {
        //服务TableView
        NSString *title = nil;
        if (self.serviceTitleArr.count > indexPath.row) {
            title = self.serviceTitleArr[indexPath.row];
        }
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
    if ( indexpath.row == 6|| indexpath.row == 7 ) {
        return YES;
    }
    return NO;
}

- (BOOL)isPhotoCellWithIndex:(NSIndexPath *)indexpath
{
    if ( indexpath.row == 10|| indexpath.row == 11) {
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
    if ([title isEqualToString:@"联系方式:"]) {
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
        [self.lincePhotoArrM addObject:_storeModel.licenseUrl];
    }
    
    
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
