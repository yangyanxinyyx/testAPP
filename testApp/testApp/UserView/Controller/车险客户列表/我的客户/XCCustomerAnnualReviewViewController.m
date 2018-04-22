//
//  XCCustomerAnnualReviewViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerAnnualReviewViewController.h"
#import "XCCheckoutDetailPhotoCell.h"
#import "SelectTimeView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define kPhotoCellID @"PhotoCellID"
#import "XCCheckoutPhotoPreViewController.h"
#import "LYZSelectView.h"
@interface XCCustomerAnnualReviewViewController ()<XCDistributionFooterViewDelegate,XCCheckoutDetailPhotoCellDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>
{
    NSString *_pathToPhoto;
}
/** 预约时间 */
@property (nonatomic, copy) NSString * appointmentTime ;
/** 类型选择 */
@property (nonatomic, copy) NSString * onlineType ;
/** 年审费用 */
@property (nonatomic, copy) NSNumber * orderPrice ;

/** <# 注释 #> */
@property (nonatomic, copy) NSString * url1 ;
@property (nonatomic, copy) NSString * url2 ;
@property (nonatomic, copy) NSString * url3 ;
@property (nonatomic, copy) NSString * url4 ;

@end

@implementation XCCustomerAnnualReviewViewController

#pragma mark - lifeCycle


- (void)dealloc {
    if ([[NSFileManager defaultManager] fileExistsAtPath:_pathToPhoto]) {
        [[NSFileManager defaultManager] removeItemAtPath:_pathToPhoto error:nil];
    }
    unlink([_pathToPhoto  UTF8String]);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCDistributionPicketCell class] forCellReuseIdentifier:kPicketCellID];
    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID ];
    [self.tableView registerClass:[XCCheckoutDetailPhotoCell class] forCellReuseIdentifier:kPhotoCellID];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
    
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doc_l_path = [NSString stringWithFormat:@"%@/", [docPaths firstObject]];
    _pathToPhoto = [doc_l_path stringByAppendingPathComponent:@"Annuallience.jpg"];
    
}

#pragma mark - Init Method

- (void)configureData
{
    self.dataArrM = [[NSMutableArray alloc] initWithArray:@[@"预约时间",@"类型选择",@"年审费用:",@"行驶证拍照"]];
}
- (void)initUI
{
    
}
#pragma mark - Action Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak __typeof(self) weakSelf = self;
    if (indexPath.section == 0 && indexPath.row == 0) {
        SelectTimeView *selectView = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        selectView.block = ^(NSString *string) {
            weakSelf.appointmentTime = string;
            XCDistributionPicketCell *cell = (XCDistributionPicketCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell setTitleValue:string];
        };
        [self.view addSubview:selectView];
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        //类选择
        if (self.dataArr) {
            
            NSMutableArray *titleArrM = [[NSMutableArray alloc] init];
            NSMutableArray *moneyArrM = [[NSMutableArray alloc] init];
            for (NSDictionary *info in self.dataArr) {
                NSString *title = info[@"onlineType"];
                NSNumber *money = info[@"money"];
                [titleArrM addObject:title];
                [moneyArrM addObject:[money stringValue]];
            }
            
            LYZSelectView *selectView =[LYZSelectView alterViewWithArray:titleArrM confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                XCDistributionPicketCell *cell = (XCDistributionPicketCell *)[tableView cellForRowAtIndexPath:indexPath];
                XCCheckoutDetailTextFiledCell *moneyCell = (XCCheckoutDetailTextFiledCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                NSUInteger index = [titleArrM indexOfObject:selectStr];
                NSString *selectMoney = [moneyArrM objectAtIndex:index];
                [moneyCell setTitlePlaceholder:selectMoney];
                [cell setTitleValue:selectStr];
                
                weakSelf.onlineType = selectStr;
                weakSelf.orderPrice = [NSNumber numberWithDouble:[selectMoney doubleValue]];
            }];
            [self.view addSubview:selectView];
        }
    }
}

- (void)postAnnualNetworkBill
{
    __weak __typeof(self) weakSelf = self;
    //提交
    BOOL configureSuccess = YES;
    if (!self.model.customerId) {
        configureSuccess = NO ;
    }
    if (!self.model.customerName) {
        configureSuccess = NO ;
    }
    if (!self.model.phoneNo) {
        configureSuccess = NO ;
    }
    if (!self.model.customerName) {
        configureSuccess = NO ;
    }
    if (!self.model.carId) {
        configureSuccess = NO ;
    }
    if (!self.model.plateNo) {
        configureSuccess = NO ;
    }
    if (!self.orderPrice) {
        configureSuccess = NO ;
    }
    if (!self.appointmentTime) {
        configureSuccess = NO ;
    }
    if (!self.onlineType) {
        configureSuccess = NO ;
    }
    if (!self.url1) {
        configureSuccess = NO ;
    }
    NSDictionary *param = @{
                            @"customerId":self.model.customerId,
                            @"customerName":self.model.customerName,
                            @"phone":self.model.phoneNo,
                            @"contacts":self.model.customerName,
                            @"carId":self.model.carId,
                            @"plateNo":self.model.plateNo,
                            @"type":@"年审",
                            @"orderPrice":self.orderPrice,
                            @"appointmentTime":self.appointmentTime,
                            @"onlineType":self.onlineType,
                            @"url1":self.url1,
                            //                            @"url2":self.url2,
                            //                            @"url3":self.url3,
                            //                            @"url4":self.url4
                            };
    [RequestAPI addOrderByAuditAndRules:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if (response[@"result"]) {
            [strongSelf requestSuccessHandler];
        }else {
            [strongSelf requestFailureHandler];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf requestFailureHandler];
    }];

}

#pragma mark - Delegates & Notifications
#pragma mark - XCDistributionFooterViewDelegate
- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    __weak __typeof(self) weakSelf = self;
 
    //上传图片
    if (_url1) {
        NSLog(@"%@",_url1);
    }
    NSMutableString *urlStr = [NSMutableString stringWithString:_url1];
    //本地图片需要上传
    if (![urlStr hasPrefix:@"http://"]||[urlStr hasPrefix:@"https://"]) {
        NSData *uploadData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:_url1]];
        NSDictionary *param = @{
                                @"file":@[uploadData],
                                };
        [RequestAPI appUploadPicture:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if (response[@"result"]&&response[@"data"]) {
                NSArray *urlStrArr  = response[@"data"];
                weakSelf.url1 = [urlStrArr firstObject];
//                [strongSelf requestSuccessHandler];
                [strongSelf postAnnualNetworkBill];
            }else {
                [strongSelf requestFailureHandler];
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [strongSelf requestFailureHandler];
            
        }];

    }
    
    

}

#pragma mark - XCCheckoutDetailPhotoCellDelegate

//- (void)XCCheckoutDetailPhotoCellClickphotoImageView:(UIImage *)image index:(NSInteger)index cell:(XCCheckoutDetailPhotoCell *)cell
//{
//    if (image) {
//        XCCheckoutPhotoPreViewController *previewVC = [[XCCheckoutPhotoPreViewController alloc] initWithTitle:@"照片预览"];
////        previewVC.sourceImage = image;
//       __block NSURL *fileURL = [NSURL fileURLWithPath:_pathToPhoto];
//        previewVC.sourceURL = fileURL;
//        __weak __typeof(self) weakSelf = self;
//        previewVC.deleteHandler = ^{
//            __strong __typeof__(weakSelf)strongSelf = weakSelf;
//            XCCheckoutDetailPhotoCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
//            if ([[NSFileManager defaultManager] fileExistsAtPath:_pathToPhoto]) {
//                [[NSFileManager defaultManager] removeItemAtPath:_pathToPhoto error:nil];
//            }
//            unlink([_pathToPhoto  UTF8String]);
//            [cell setPhotoArr:@[]];
//
//        };
//        [self.navigationController pushViewController:previewVC animated:YES];
//    }
//
//
//}
- (void)XCCheckoutDetailPhotoCellClickphotoWithURL:(NSURL *)photoURL
                                             index:(NSInteger)index
                                              cell:(XCCheckoutDetailPhotoCell *)cell
{
    if (photoURL) {
        __weak __typeof(self) weakSelf = self;
        XCCheckoutPhotoPreViewController *previewVC = [[XCCheckoutPhotoPreViewController alloc] initWithTitle:@"照片预览"];
        previewVC.sourceURL = photoURL;
        previewVC.deleteHandler = ^{
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            XCCheckoutDetailPhotoCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:_pathToPhoto]) {
                [[NSFileManager defaultManager] removeItemAtPath:_pathToPhoto error:nil];
            }
            unlink([_pathToPhoto  UTF8String]);
            [cell setPhotoArr:@[]];
        };
        [self.navigationController pushViewController:previewVC animated:YES];
    }
}


- (void)XCCheckoutDetailPhotoCellClickAddPhotosImageView:(UIImageView *)imageView cell:(XCCheckoutDetailPhotoCell *)cell
{
    [ProgressControll showProgressNormal];
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    pickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
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
        if ([[NSFileManager defaultManager] fileExistsAtPath:_pathToPhoto]) {
            [[NSFileManager defaultManager] removeItemAtPath:_pathToPhoto error:nil];
        }
        unlink([_pathToPhoto  UTF8String]);
        [UIImagePNGRepresentation(image) writeToFile:_pathToPhoto atomically:YES];

        XCCheckoutDetailPhotoCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
//        NSURL *fileURL = [NSURL fileURLWithPath:_pathToPhoto];
         [cell setPhotoArr:@[_pathToPhoto]];

        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } failureBlock:^(NSError *error) {
        //失败的处理
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.dataArrM[indexPath.row];

    if (indexPath.row == 2) {
      
        XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID forIndexPath:indexPath];
        textFiledCell.isNumField = YES;
        textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        [textFiledCell setTitle:title];
        textFiledCell.shouldShowSeparator = YES;
            if (self.dataArr.count == 1) {
                NSNumber *money  = [self.dataArr firstObject][@"money"];
                self.orderPrice = money;
                [textFiledCell setTitlePlaceholder:[money stringValue]];
            }
//        [textFiledCell setTitlePlaceholder:placetext];
        return textFiledCell;
        
    }else if(indexPath.row == 3) {
        XCCheckoutDetailPhotoCell *photoCell = (XCCheckoutDetailPhotoCell *)[tableView dequeueReusableCellWithIdentifier:kPhotoCellID forIndexPath:indexPath];
        photoCell.delegate = self;
        photoCell.maxPhoto = 1;
        [photoCell setTitle:title];
        photoCell.isAnnualType = YES;
        if ([[NSFileManager defaultManager] fileExistsAtPath:_pathToPhoto]) {
//            NSURL *photoUrl = [NSURL fileURLWithPath:_pathToPhoto];
            [photoCell setPhotoArr:@[_pathToPhoto]];

        }else {
            [photoCell setPhotoArr:@[]];

        }
        return photoCell;
    }
    XCDistributionPicketCell *cell = (XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID forIndexPath:indexPath];
    if (indexPath.row == self.dataArrM.count - 1) {
        cell.shouldShowSeparator = NO;
    }
    [cell setTitle:title];
    
    if (indexPath.row == 1) {
        if (self.dataArr.count == 1) {
            NSString *onlineType  = [self.dataArr firstObject][@"onlineType"];
            [cell setTitleValue:onlineType];
            self.onlineType = onlineType;
        }
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
    [footerView setTitle:@"预约"];
    footerView.delegate = self;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return [XCCheckoutDetailPhotoCell getCellHeight];
    }
    return 88 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerViewHeigth;
    footerViewHeigth = (60 + 88 + 60) * ViewRateBaseOnIP6;
    return footerViewHeigth;
}

#pragma mark - Privacy Method
- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}
- (void)requestSuccessHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"预约成功" complete:nil];
    [self.view addSubview:tipsView];
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
#pragma mark - Setter&Getter
- (void)setModel:(XCCustomerDetailModel *)model
{
    _model = model;
    
}
@end
