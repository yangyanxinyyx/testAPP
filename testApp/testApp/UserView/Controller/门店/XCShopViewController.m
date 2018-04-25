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
#import "XCCheckoutPhotoPreViewController.h"
@interface XCShopViewController ()<UITableViewDelegate,
UITableViewDataSource,priceCIQChangeViewDelegate,BaseNavigationBarDelegate,
XCDistributionFooterViewDelegate,XCCheckoutDetailPhotoCellDelegate,
UINavigationControllerDelegate,UIImagePickerControllerDelegate,
XCShopAMapViewControllerDelegate,XCCheckoutDetailTextFiledCellDelegate>
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
/** 证书图片URLPath */
@property (nonatomic, copy) NSString * lincesPhotoPath ;
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
  
    if ([[NSFileManager defaultManager] fileExistsAtPath:_lincesPhotoPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:_lincesPhotoPath error:nil];
    }
    unlink([_lincesPhotoPath  UTF8String]);
    
    for (NSString *filePath in self.storePhotoArrM) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        unlink([filePath  UTF8String]);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _storePhotoArrM = [[NSMutableArray alloc] init];
    _networkURLArrM = [[NSMutableArray alloc] init];
    _tmpDeleteURLArrM = [[NSMutableArray alloc] init];
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
#pragma mark - Action Method

- (void)deleteAllTmpPhoto
{
    dispatch_semaphore_t videoTrackSynLoadSemaphore;
    videoTrackSynLoadSemaphore = dispatch_semaphore_create(0);
    dispatch_time_t maxVideoLoadTrackTimeConsume = dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC);
    for (NSString *fileURLPath in self.tmpDeleteURLArrM) {
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
            errStr = @"提交成功";
            [strongSelf.networkURLArrM  removeAllObjects];
            [strongSelf deleteAllTmpPhoto];
        }
        [strongSelf showAlterInfoWithNetWork:errStr];
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
        [strongSelf showAlterInfoWithNetWork:errStr];
        for (NSString *fileURLPath in _networkURLArrM) {
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

- (void)postUpLoadLocalPhoto
{
    __weak __typeof(self) weakSelf = self;
    
    if (![self isUsefulURLWith:_lincesPhotoPath]) {
        NSData *uploadData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:_lincesPhotoPath]];
        if (!uploadData) {
            return;
        }
        //上传图片
        NSDictionary *param = @{
                                @"file":@[uploadData],
                                };
        [RequestAPI appUploadPicture:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;

            if ([response[@"result"] integerValue] == 1&&response[@"data"]) {
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:strongSelf.lincesPhotoPath]) {
                    [[NSFileManager defaultManager] removeItemAtPath:strongSelf.lincesPhotoPath error:nil];
                }
                unlink([strongSelf.lincesPhotoPath  UTF8String]);
                NSArray *urlStrArr  = response[@"data"];
                strongSelf.lincesPhotoPath = [urlStrArr firstObject];
                [_networkURLArrM addObject:urlStrArr];
            }else {
                [strongSelf showAlterInfoWithNetWork:@"提交失败"];
                return ;
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
            [strongSelf showAlterInfoWithNetWork:errStr];
            return ;
        }];
    }
    
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
        //上传图片
        NSDictionary *param = @{
                                @"file":uploadDataArrM,
                                };
        [RequestAPI appUploadPicture:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if ([response[@"result"] integerValue] == 1 &&response[@"data"]) {
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
                //提交修改门店
                [strongSelf postModifyShopInfo];
            }else {
                [strongSelf showAlterInfoWithNetWork:@"提交失败"];
                return ;            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
            [strongSelf showAlterInfoWithNetWork:errStr];
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
            [strongSelf showAlterInfoWithNetWork:errStr];
        }];
        self.viewBear.frame = CGRectMake(-SCREEN_WIDTH, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
    }
}

#pragma mark - XCDistributionFooterViewDelegate

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    
    BOOL configureSuccess = YES;
    NSString *errorStr = @"未知错误";

    if (!isUsableNSString(_storeModel.tel, @"")) {
        errorStr = @"请输入联系方式";
        configureSuccess = NO;
    }
    if (![self valiMobile:_storeModel.corporateCellphone]) {
        errorStr = @"请输入正确负责人电话";
        configureSuccess = NO;
    }
    if (!isUsableNSString(_storeModel.name, @"")) {
        errorStr = @"请输入门店名称";
        configureSuccess = NO;
    }
    if (!isUsableNSString(_storeModel.corporateName,@"")) {
        errorStr = @"请输入负责人名称";
        configureSuccess = NO;
    }
    if (!isUsable(_storeModel.storeID, [NSNumber class])) {
        configureSuccess = NO;
    }
    if (!isUsable(_storeModel.salesmanCommission, [NSNumber class])) {
        errorStr = @"请输入团体经理提成";
        configureSuccess = NO;
    }
    if (!isUsable(_storeModel.managerCommission, [NSNumber class])) {
        errorStr = @"请输入业务员提成";
        configureSuccess = NO;
    }
    if (!isUsableNSString(_storeModel.latitude, @"")) {
        errorStr = @"定位信息错误";
        configureSuccess = NO;
    }
    if (!isUsableNSString(_storeModel.longitude, @"")) {
        errorStr = @"定位信息错误";
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
        [self showAlterInfoWithNetWork:errorStr];
    }
}

#pragma mark - XCCheckoutDetailTextFiledCellDelegate

- (void)XCCheckoutDetailTextFiledSubmitTextField:(UITextField *)textField title:(NSString *)title
{
    if ([title isEqualToString:@"门店名称:"]) {
        _storeModel.name = textField.text;
    }
    else if ([title isEqualToString:@"联系方式:"]) {
            [textField setText:[textField.text areaCodeFormat]];
        if ([textField.text isAreaCode]) {
            _storeModel.tel = [textField.text areaCodeFormat];

        }else {
            [self showAlterInfoWithNetWork:@"请输入正确格式联系方式"];
        }
    }
    else if ([title isEqualToString:@"负责人:"]) {
        _storeModel.corporateName = textField.text;
    }
    else if ([title isEqualToString:@"负责人电话:"]) {
        if ([self valiMobile:textField.text]) {
            _storeModel.corporateCellphone = textField.text;
        }else {
            [self showAlterInfoWithNetWork:@"请输入正确格式电话"];
        }
    }
    else if ([title isEqualToString:@"业务员提成:"]) {
        if ([textField.text doubleValue] < 100) {
            double num = [textField.text doubleValue];
            NSString *numStr = [NSString stringWithFormat:@"%.2f%%",num];
            textField.text = numStr;
            _storeModel.salesmanCommission = [NSNumber numberWithDouble:num];
            
        }else {
            [self showAlterInfoWithNetWork:@"请输入正确百分比"];
        }
    }
    else if ([title isEqualToString:@"团队经理提成:"]) {
        if ([textField.text doubleValue] < 100) {
            double num = [textField.text doubleValue];
            NSString *numStr = [NSString stringWithFormat:@"%.2f%%",num];
            textField.text = numStr;
            _storeModel.managerCommission = [NSNumber numberWithDouble:num];
            
        }else {
            [self showAlterInfoWithNetWork:@"请输入正确百分比"];
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

#pragma  mark - XCCheckoutDetailPhotoCellDelegate
- (void)XCCheckoutDetailPhotoCellClickphotoWithURL:(NSURL *)photoURL
                                             index:(NSInteger)index
                                              cell:(XCCheckoutDetailPhotoCell *)cell
{
    if (photoURL) {
        XCCheckoutPhotoPreViewController *previewVC = [[XCCheckoutPhotoPreViewController alloc] initWithTitle:@"照片预览"];
        previewVC.sourceURL = photoURL;
        previewVC.deleteHandler = ^{
            
            if ([[photoURL absoluteString] isEqualToString:_lincesPhotoPath]) {
                //lince
                if ([self isUsefulURLWith:_lincesPhotoPath]) {
                    //网络删除
                        NSDictionary *param = @{
                                                @"url":_lincesPhotoPath,
                                                };
                        [RequestAPI deletePictureByUrl:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                            if ([response[@"result"] integerValue] == 1) {
                                _lincesPhotoPath = @"";
                            }
                            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                        } fail:^(id error) {

                        }];
                    
                }else {
                    //本地删除
                    if ([[NSFileManager defaultManager] fileExistsAtPath:_lincesPhotoPath]) {
                        [[NSFileManager defaultManager] removeItemAtPath:_lincesPhotoPath error:nil];
                    }
                    unlink([_lincesPhotoPath  UTF8String]);
                }
//                NSIndexPath *lincePhotoIndex = [NSIndexPath indexPathForRow:9 inSection:0];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.storeTableView reloadData];
                });
                
            }else {
                //门店图片
                NSUInteger index = [self.storePhotoArrM indexOfObject:[photoURL absoluteString]];
                NSString *filePath = self.storePhotoArrM[index];
                
                if ([self isUsefulURLWith:filePath]) {
                    //网络删除
                    [self.storePhotoArrM removeObjectAtIndex:index];
                    [self.tmpDeleteURLArrM addObject:filePath];
                }else {
                    //本地删除
                    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                    }
                    unlink([filePath  UTF8String]);
                    [self.storePhotoArrM removeObjectAtIndex:index];
                }
//                NSIndexPath *shopPhotoIndex = [NSIndexPath indexPathForRow:10 inSection:0];
                [self.storeTableView reloadData];
            }
        };
        [self.navigationController pushViewController:previewVC animated:YES];
    }
}

- (void)XCCheckoutDetailPhotoCellClickAddPhotosImageView:(UIImageView *)imageView
                                                    cell:(XCCheckoutDetailPhotoCell *)cell
{
    self.currentPhotoCell = cell;
    [ProgressControll showProgressNormal];

    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    pickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
    [ProgressControll dismissProgress];

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
            NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *doc_l_path = [NSString stringWithFormat:@"%@/", [docPaths firstObject]];
            _lincesPhotoPath = [doc_l_path stringByAppendingPathComponent:@"lincePhoto.jpg"];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:_lincesPhotoPath]) {
                [[NSFileManager defaultManager] removeItemAtPath:_lincesPhotoPath error:nil];
            }
            unlink([_lincesPhotoPath  UTF8String]);
            [UIImagePNGRepresentation(image) writeToFile:_lincesPhotoPath atomically:YES];
            NSURL *lincePhotoURL = [NSURL fileURLWithPath:_lincesPhotoPath];
            _lincesPhotoPath = [lincePhotoURL absoluteString];
            [weakSelf.currentPhotoCell setPhotoArr:@[lincePhotoURL]];
        }
        else if ([weakSelf.currentPhotoCell.title isEqualToString:@"门店图片,最多4张"]) {
          
            NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *doc_l_path = [NSString stringWithFormat:@"%@/", [docPaths firstObject]];
            NSString * tmpPath = [doc_l_path stringByAppendingPathComponent:[NSString stringWithFormat:@"shopPhoto%lu.jpg",(unsigned long)weakSelf.storePhotoArrM.count]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:tmpPath]) {
                [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
            }
            unlink([tmpPath  UTF8String]);
            [UIImagePNGRepresentation(image) writeToFile:tmpPath atomically:YES];
            NSURL *tmpFileURL = [NSURL fileURLWithPath:tmpPath];
            [weakSelf.storePhotoArrM addObject:[tmpFileURL absoluteString]];
            [weakSelf.currentPhotoCell setPhotoArr:weakSelf.storePhotoArrM];
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
            photoCell.isAnnualType = YES;
            if ([title isEqualToString:@"营业执照上传,1张"]&& isUsableNSString(_storeModel.licenseUrl, @"")) {
                if (_lincesPhotoPath) {
                    [photoCell setPhotoArr:@[_lincesPhotoPath]];
                }else {
                    [photoCell setPhotoArr:@[]];
                }
            }
            if ([title isEqualToString:@"门店图片,最多4张"]) {
                [photoCell setMaxPhoto:4];
                photoCell.isAnnualType = NO;
                [photoCell setPhotoArr:self.storePhotoArrM];
            }
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
            textFiledCell.delegate = self;
            textFiledCell.title = title;
            [textFiledCell setTextFiledBGColor:[UIColor whiteColor]];
            [textFiledCell setTitlePlaceholder:holderStr];
            if ([self isInputNumKeyBoardCellWithTitle:title]) {
                [textFiledCell setIsNumField:YES];
                textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            }else if ([title isEqualToString:@"业务员提成:"]||[title isEqualToString:@"团队经理提成:"]) {
                  textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            }
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
- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [_viewBear removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)showAlterInfoWithNetWork:(NSString *)titleStr
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:titleStr complete:nil];
    [self.view addSubview:tipsView];
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

#pragma mark - Setter&Getter

- (void)setStoreModel:(XCShopModel *)storeModel
{
    if (!storeModel) {
        return;
    }
    _storeModel = storeModel;
    self.storePhotoArrM = [self getOrigianShopPhotoWithModel:_storeModel]; //获取线上图片数组
    if ([self isUsefulURLWith: _storeModel.licenseUrl]) {
        self.lincesPhotoPath = _storeModel.licenseUrl;
    }else {
        self.lincesPhotoPath = @"";
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
