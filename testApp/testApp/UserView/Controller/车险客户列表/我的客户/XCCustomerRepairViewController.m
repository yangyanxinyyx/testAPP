//
//  XCCustomerRepairViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerRepairViewController.h"
#import "XCCustomerShopModel.h"
#import "SelectTiemHoursView.h"
#import "XCCustomerShopListView.h"
#import "PriceUnderwritingImportTableViewCell.h"
#import "XCCheckoutDetailPhotoCell.h"
#import <TZImagePickerController.h>
#import "XCPhotoPreViewController.h"
#import "UIImage+imageHelper.h"

#define kPhotoCellID @"PhotoCellID"

#define kimportTableCellID @"importTableCellID"
@interface XCCustomerRepairViewController ()<XCDistributionFooterViewDelegate,XCCheckoutDetailTextFiledCellDelegate,PriceUnderwritingImportTableViewCellDelegate,XCCheckoutDetailPhotoCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,TZImagePickerControllerDelegate>
/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * shopModelArrM ;

/** 4张图片保存 */
@property (nonatomic, strong) NSMutableArray * storePhotoArrM ;
/** 上传成功图片URL */
@property (nonatomic, strong) NSMutableArray * networkURLArrM ;
/** 选中当前的Cell */
@property (nonatomic, strong) XCCheckoutDetailPhotoCell * currentPhotoCell ;

@end

@implementation XCCustomerRepairViewController

#pragma mark - lifeCycle

- (void)dealloc {
    
    NSLog(@"===========我的客户-维修预约 Dealloc");
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
    [self.tableView registerClass:[PriceUnderwritingImportTableViewCell class] forCellReuseIdentifier:kimportTableCellID];
    [self.tableView registerClass:[XCCheckoutDetailPhotoCell class] forCellReuseIdentifier:kPhotoCellID];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
    [self initUI];
    [self configureData];
    self.shopModelArrM = [[NSMutableArray alloc] init];

}

#pragma mark - Init Method

- (void)configureData
{
    _storePhotoArrM = [[NSMutableArray alloc] init];
    self.dataArrM = [[NSMutableArray alloc] initWithArray:@[@[@"联系人:",@"车牌号:",@"联系电话:",@"预约时间:",@"门店选择:"],
  @[@"要求描述"],
  @[@"相关照片上传(最多4张)"]]];
}
- (void)initUI
{
    
}
#pragma mark - Action Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    __weak __typeof(self) weakSelf = self;

    if (indexPath.section == 0 && indexPath.row == 4) {
            XCCustomerShopListView *listView = [[XCCustomerShopListView alloc] initWithDataArr:self.shopModelArrM confirmBlock:^(XCCustomerShopModel *model) {
            weakSelf.model.storeName = model.name;
            weakSelf.model.storeId = model.shopID;
            NSLog(@"%@",model);
            
            [(XCDistributionPicketCell *)cell setTitleValue:model.name];
        }];
        [self.view addSubview:listView];
    }else if (indexPath.section == 0 && indexPath.row == 3){
        SelectTiemHoursView *selectTimeView =[[SelectTiemHoursView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        selectTimeView.block = ^(NSString *string) {
            weakSelf.model.appointmentTime = string;
            [(XCDistributionPicketCell *)cell setTitleValue:string];
        };
        [self.view addSubview:selectTimeView];
    }
    
}

#pragma mark XCDistributionFooterViewDelegate

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    
    BOOL configureSuccess = YES;
    NSString *errString = @"保单信息错误";
    if (!isUsable(_model.customerId,[NSNumber class])&& !_model.customerName &&
        !_model.phoneNo &&!isUsable(_model.carId,[NSNumber class])) {
        errString = @"保单信息错误";
        configureSuccess = NO;
    }
    if (!isUsable(_model.storeId,[NSNumber class])&& !_model.storeName ) {
        errString = @"门店信息错误";
        configureSuccess = NO;
    }
    if (!_model.appointmentTime) {
        errString = @"请选择预约时间";
        configureSuccess = NO;
    }
    if (configureSuccess) {
        [self upLoadNetworkPhoto];
    }else {
        [self showAlterInfoWithNetWork:errString complete:nil];
    }
   
}

- (void)upLoadNetworkPhoto
{
    if (self.storePhotoArrM.count > 0 ) {
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
                /// 提交维修费用
                [strongSelf postRepairNetworkBill];
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
        [self postRepairNetworkBill];
    }
}

- (void)postRepairNetworkBill
{

    if (!isUsableNSString(_model.remark, @"")) {
        _model.remark = @"";
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
    
        __weak __typeof(self) weakSelf = self;
        NSDictionary *param = @{
                                @"customerId":_model.customerId,
                                @"customerName":_model.customerName,
                                @"phone":_model.phoneNo,
                                @"contacts":_model.customerName,
                                @"carId":_model.carId,
                                @"storeId":_model.storeId,
                                @"storeName":_model.storeName,
                                @"appointmentTime":_model.appointmentTime,
                                @"remark":_model.remark,
                                @"url1":url1Str,
                                @"url2":url2Str,
                                @"url3":url3Str,
                                @"url4":url4Str,
                                };
        [RequestAPI addOrderByMaintain:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
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
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
    [action showInView:self.navigationController.view];
    
}

- (void)XCCheckoutDetailPhotoCellChangePhotoArr:(NSArray *)photoArr cell:(XCCheckoutDetailPhotoCell *)cell
{
    NSString *title = cell.titleLabel.text;
    NSMutableString *tmpTitleM = [NSMutableString stringWithString:title];
    NSArray *strArr = [tmpTitleM componentsSeparatedByString:@" "];
    if (strArr.count > 1) {
        title = strArr[1];
    }
    if([title isEqualToString:@"相关照片上传(最多4张)"])
    {
        if(photoArr.count > 0) {
            self.storePhotoArrM = [NSMutableArray arrayWithArray:photoArr];
        }
    }
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
            NSInteger count = maxCount - self.storePhotoArrM.count;
            if (count < 0) {
                count = 0 ;
            }
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count columnNumber:4 delegate:self pushPhotoPickerVc:YES];
            imagePickerVc.allowPickingVideo = NO;
            imagePickerVc.allowTakePicture = NO;
            imagePickerVc.sortAscendingByModificationDate = YES;
            [self presentViewController:imagePickerVc animated:YES completion:nil];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - PriceUnderwritingImportTableViewCellDelegate
- (void)textViewBeginWithTextView:(UITextView *)textView
{
    if (!isUsableNSString(self.model.remark, @"")) {
        textView.text = @"";
    }
}
- (void)textViewENDWithTextView:(UITextView *)textView
{
    self.model.remark = textView.text;
}

#pragma mark - XCCheckoutDetailTextFiledCellDelegate
- (void)XCCheckoutDetailTextFiledSubmitTextField:(UITextField *)textField title:(NSString *)title
{
    if ([title isEqualToString:@"联系电话:"]) {
        if ([self valiMobile:textField.text]) {
            self.model.phoneNo = textField.text;
        }else {
            [self showAlterInfoWithNetWork:@"请输入正确格式电话" complete:nil];
        }
    }
    else if ([title isEqualToString:@"联系人:"]) {
        self.model.customerName = textField.text;
    }
    else if ([title isEqualToString:@"车牌号:"]) {
        self.model.plateNo = textField.text;
    }
}

- (BOOL)XCCheckoutDetailTextFiledShouldChangeCharactersInRange:(NSRange)range
                                             replacementString:(NSString *)string
                                                         title:(NSString *)title
                                                     textFiled:(UITextField *)textFiled
{
    if ([title isEqualToString:@"联系电话:"]) {
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)  {
            return NO;
        }
        return YES;
    }
    return YES;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArrM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *subArr = self.dataArrM[section];
    return subArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *subTitleArr = self.dataArrM[indexPath.section];
    NSString *title = subTitleArr[indexPath.row];

    if ([self isTextTypeCellWithIndexPath:indexPath]) {
        XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID forIndexPath:indexPath];
        textFiledCell.delegate = self;
        textFiledCell.titleLabel.text = title;
        textFiledCell.shouldShowSeparator = YES;
        
        if ([title isEqualToString:@"联系人:"]) {
            textFiledCell.textField.text = self.model.customerName;
        }
        else if ([title isEqualToString:@"联系电话:"]) {
            textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            textFiledCell.textField.text = self.model.phoneNo;
        }
        else if ([title isEqualToString:@"车牌号:"]) {
            textFiledCell.textField.text = self.model.plateNo;
        }
        return textFiledCell;
        
    }
    else if ([self isImportTableViewCellWith:indexPath]) {
        PriceUnderwritingImportTableViewCell *cell = (PriceUnderwritingImportTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kimportTableCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.labelName.text = title;
        cell.textView.text = @"维修项目类别描述...";
        
        return cell;
    }
    else if ([self isPhotoDetaiCellWithIndexPath:indexPath]){
        XCCheckoutDetailPhotoCell *photoCell = (XCCheckoutDetailPhotoCell *)[tableView dequeueReusableCellWithIdentifier:kPhotoCellID forIndexPath:indexPath];
        photoCell.delegate = self;
        photoCell.maxPhoto = 4;
        photoCell.titleLabel.text = title;
        [photoCell setPhotoArr:self.storePhotoArrM];

        return photoCell;
    }else {
        XCDistributionPicketCell *cell = (XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID forIndexPath:indexPath];
        if (indexPath.row == subTitleArr.count - 1) {
            cell.shouldShowSeparator = NO;
        }
        cell.titleLabel.attributedText = [NSString stringWithImportentValue:title];
        if ([title isEqualToString:@"预约时间:"]) {
            if (isUsableNSString(self.model.appointmentTime, @"")) {
                cell.titleValue = self.model.appointmentTime;
            }
        }
        else if ([title isEqualToString:@"门店选择:"])
        {
            if (isUsableNSString(self.model.storeName, @"")) {
                cell.titleValue = self.model.storeName;
            }
        }
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == self.dataArrM.count - 1) {
        XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
        [footerView setTitle:@"预约"];
        footerView.delegate = self;
        return footerView;
    }else {
        UITableViewHeaderFooterView *footerView = [[UITableViewHeaderFooterView alloc] init];
        return footerView;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isImportTableViewCellWith:indexPath]) {
        return  233 * ViewRateBaseOnIP6;
    }
    else if ([self isPhotoDetaiCellWithIndexPath:indexPath])  {
        return [XCCheckoutDetailPhotoCell getCellHeight];
    }

    return 88 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.dataArrM.count - 1) {
        CGFloat footerViewHeigth;
        footerViewHeigth = (60 + 88 + 60) * ViewRateBaseOnIP6;
        return footerViewHeigth;
    }else {
        return 1;
    }
 
}

#pragma mark - Privacy Method
- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}
- (void)requestSuccessHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"提交成功" complete:nil];
    [self.view addSubview:tipsView];
}

- (BOOL)isTextTypeCellWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && ((indexPath.row == 0) || (indexPath.row == 1) || (indexPath.row == 2))) {
        return YES;
    }
    return NO;
}
- (BOOL)isImportTableViewCellWith:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        return YES;
    }
    return NO;
}
- (BOOL)isPhotoDetaiCellWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 0) {
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

#pragma mark - Setter&Getter

- (void)setLocation:(CLLocation *)location
{
    _location = location;
    __weak __typeof(self) weakSelf = self;
    NSDictionary *param = @{
                            @"longitude":[NSNumber numberWithDouble:_location.coordinate.longitude],
                            @"latitude":[NSNumber numberWithDouble:_location.coordinate.latitude],
                            @"PageSize":[NSNumber numberWithInt:10],
                            };
    [RequestAPI appFindStore:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if (response[@"data"]) {
            if (response[@"data"][@"dataSet"]) {
                NSArray *origionDataArr = response[@"data"][@"dataSet"];
                for (NSDictionary *dataInfo in origionDataArr) {
                    XCCustomerShopModel *shopModel = [XCCustomerShopModel yy_modelWithJSON:dataInfo];
                    if (shopModel) {
                        [strongSelf.shopModelArrM addObject:shopModel];
                    }
                }
            }
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf requestFailureHandler];
    }];

}

@end
