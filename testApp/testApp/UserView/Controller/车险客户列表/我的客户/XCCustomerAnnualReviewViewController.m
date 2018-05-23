//
//  XCCustomerAnnualReviewViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerAnnualReviewViewController.h"
#import "XCCheckoutDetailPhotoCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define kPhotoCellID @"PhotoCellID"
#import "LYZSelectView.h"
#import "SelectTiemHoursView.h"
#import "XCPhotoPreViewController.h"
#import "UIImage+imageHelper.h"
#import <TZImagePickerController.h>
@interface XCCustomerAnnualReviewViewController ()<XCDistributionFooterViewDelegate,XCCheckoutDetailPhotoCellDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,XCCheckoutDetailTextFiledCellDelegate,TZImagePickerControllerDelegate>
{
    dispatch_semaphore_t _videoTrackSynLoadSemaphore;
    dispatch_time_t _maxVideoLoadTrackTimeConsume ;
}
/** 预约时间 */
@property (nonatomic, copy) NSString * appointmentTime ;
/** 类型选择 */
@property (nonatomic, copy) NSString * onlineType ;
/** 年审费用 */
@property (nonatomic, copy) NSNumber * orderPrice ;
/** 4张图片保存 */
@property (nonatomic, strong) NSMutableArray * storePhotoArrM ;
/** 上传成功图片URL */
@property (nonatomic, strong) NSMutableArray * networkURLArrM ;
/** 选中当前的Cell */
@property (nonatomic, strong) XCCheckoutDetailPhotoCell * currentPhotoCell ;
@end

@implementation XCCustomerAnnualReviewViewController

#pragma mark - lifeCycle


- (void)dealloc {
    
    NSLog(@"===========我的客户-年审预约 Dealloc");
    for (NSString *filePath in self.storePhotoArrM) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        unlink([filePath  UTF8String]);
    }
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
    
}

#pragma mark - Init Method

- (void)configureData
{
    _storePhotoArrM = [[NSMutableArray alloc] init];
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
        SelectTiemHoursView *selectView = [[SelectTiemHoursView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
                [moneyCell setTitlePlaceholder:[NSString stringWithMoneyNumber:[selectMoney doubleValue]]];
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
    
    NSString *url1Str = @"";
    NSString *url2Str = @"";
    NSString *url3Str = @"";
    NSString *url4Str = @"";
    for (int i = 0 ; i < self.storePhotoArrM.count; i++) {
        NSString *filePath = self.storePhotoArrM[i];
        if (i == 0) {
            url1Str = filePath;
        }
        else if (i == 1) {
            url2Str = filePath;
        }
        else if (i == 2) {
            url3Str = filePath;
        }
        else if (i == 3) {
            url4Str = filePath;
        }
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
                            @"url1":url1Str,
                            @"url2":url2Str,
                            @"url3":url3Str,
                            @"url4":url4Str,
                            };
    [RequestAPI addOrderByAuditAndRules:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
 
        if ([response[@"result"] integerValue] == 1) {
            [strongSelf showAlterInfoWithNetWork:@"预约成功" complete:^{
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }];
        }else {
            [strongSelf showAlterInfoWithNetWork:@"预约失败" complete:nil];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
    }];

}

#pragma mark - Delegates & Notifications

#pragma mark - XCCheckoutDetailTextFiledCellDelegate

-(void)XCCheckoutDetailTextFiledBeginEditing:(UITextField *)textField title:(NSString *)title
{
    if ([title isEqualToString:@"年审费用:"]) {
        self.orderPrice = [NSNumber numberWithDouble:[textField.text doubleValue]];
        textField.text = [NSString stringWithMoneyNumber:[textField.text doubleValue]];
    }
}

- (BOOL)XCCheckoutDetailTextFiledShouldChangeCharactersInRange:(NSRange)range
                                             replacementString:(NSString *)string
                                                         title:(NSString *)title
                                                     textFiled:(UITextField *)textFiled
{
    if ([title isEqualToString:@"年审费用:"]) {
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

#pragma mark - XCDistributionFooterViewDelegate
- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    __weak __typeof(self) weakSelf = self;
    //上传图片
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
                for (NSString *filePath in uploadPathArrM) {
                    if([strongSelf.storePhotoArrM containsObject:filePath])
                    {
                        [strongSelf.storePhotoArrM removeObject:filePath];
                    }
                    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                    }
                    unlink([filePath  UTF8String]);
                }
                NSArray *urlStrArr  = response[@"data"];
                for (NSString *urlPath in urlStrArr) {
                    [strongSelf.storePhotoArrM addObject:urlPath];
                    [strongSelf.networkURLArrM addObject:urlPath];
                    
                }
                /// 提交年审费用
                [strongSelf postAnnualNetworkBill];
            }else {
                [strongSelf showAlterInfoWithNetWork:@"提交失败" complete:nil];
                return ;            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
            return ;
        }];
    }else {
        [self showAlterInfoWithNetWork:@"请添加正确证件照片！" complete:nil];
    }
    
}

#pragma mark - XCCheckoutDetailPhotoCellDelegate

- (void)XCCheckoutDetailPhotoCellClickphotoWithURL:(NSURL *)photoURL
                                             index:(NSInteger)index
                                              cell:(XCCheckoutDetailPhotoCell *)cell
{
    if (photoURL) {
        __weak __typeof(self) weakSelf = self;      
        XCPhotoPreViewController *previewVC = [[XCPhotoPreViewController alloc] initWithTitle:@"照片预览" sources:self.storePhotoArrM comlectionBlock:^(NSArray<NSURL *> *deleArray) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if (deleArray.count > 0) {
                for (NSString *imagePath in deleArray) {
                    if ([strongSelf isUsefulURLWith:imagePath]) {
                        
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
            NSIndexPath *indexPath = [strongSelf.tableView indexPathForCell:cell];
            [strongSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        previewVC.shouldShowDeleBtm = YES;
        [previewVC updatePositionWithIndex:index];
        [self.navigationController pushViewController:previewVC animated:YES];
    };

}


- (void)XCCheckoutDetailPhotoCellClickAddPhotosImageView:(UIImageView *)imageView cell:(XCCheckoutDetailPhotoCell *)cell
{
    self.currentPhotoCell = cell;
//    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
//    [action showInView:self.navigationController.view];
    TZImagePickerController *imagePickerVc = [self createPickerPhotoViewController];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate 新照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    for (UIImage *newImage in photos) {
        NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingString:
                             [NSString stringWithFormat:@"storeImage%@%lu.jpg",[NSString getNowTimeTimestamp],(unsigned long)self.storePhotoArrM.count]];
        NSLog(@"%@",tmpPath);
        if ([[NSFileManager defaultManager] fileExistsAtPath:tmpPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
        }
        unlink([tmpPath  UTF8String]);
        [UIImageJPEGRepresentation(newImage, 1.0) writeToFile:tmpPath atomically:YES];
        NSURL *tmpFileURL = [NSURL fileURLWithPath:tmpPath];
        [self.storePhotoArrM addObject:[tmpFileURL absoluteString]];
        NSLog(@"============>A");
    }
    NSLog(@"============>D");
    //完成
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.currentPhotoCell setPhotoArr:self.storePhotoArrM];
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
    NSIndexPath *indexpath = [self.tableView indexPathForCell:self.currentPhotoCell];
    [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - UIActionSheet delegate

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    switch (buttonIndex) {
//        case 0:
//        {
//            UIImagePickerController *vc = [UIImagePickerController new];
//            vc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
//            vc.delegate = self;
//            [self.navigationController presentViewController:vc animated:YES completion:nil];
//        }
//            break;
//        case 1:
//        {
//            NSInteger maxCount = 4;
//            NSInteger count = maxCount - self.storePhotoArrM.count;
//            if (count < 0) {
//                count = 0 ;
//            }
//            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count columnNumber:4 delegate:self pushPhotoPickerVc:YES];
//            imagePickerVc.allowPickingVideo = NO;
//            imagePickerVc.allowTakePicture = NO;
//            imagePickerVc.sortAscendingByModificationDate = YES;
//            [self presentViewController:imagePickerVc animated:YES completion:nil];
//
//        }
//            break;
//
//        default:
//            break;
//    }
//}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.dataArrM[indexPath.row];

    if (indexPath.row == 2) {
      
        XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID forIndexPath:indexPath];
        textFiledCell.delegate = self;
        textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        [textFiledCell setTitle:title];
        textFiledCell.shouldShowSeparator = YES;
        textFiledCell.userInteractionEnabled = NO;
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
        photoCell.maxPhoto = 4;
        photoCell.titleLabel.attributedText = [NSString stringWithImportentValue:title];
        [photoCell setPhotoArr:self.storePhotoArrM];

        return photoCell;
    }
    XCDistributionPicketCell *cell = (XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID forIndexPath:indexPath];
    if (indexPath.row == self.dataArrM.count - 1) {
        cell.shouldShowSeparator = NO;
    }
    cell.titleLabel.attributedText = [NSString stringWithImportentValue:title];

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

//处理选择图片
- (void)photoCellHanderSelectImage:(UIImage *)image
{

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

- (TZImagePickerController *)createPickerPhotoViewController
{
    CGFloat rate = 25/16.0;
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

#pragma mark - Setter&Getter
- (void)setModel:(XCCustomerDetailModel *)model
{
    _model = model;
    
}
@end
