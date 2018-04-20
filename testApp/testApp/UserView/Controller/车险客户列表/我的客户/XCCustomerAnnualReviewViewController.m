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
@interface XCCustomerAnnualReviewViewController ()<XCDistributionFooterViewDelegate,XCCheckoutDetailPhotoCellDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>
{
    NSString *_pathToPhoto;
}
@end

@implementation XCCustomerAnnualReviewViewController

#pragma mark - lifeCycle

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
    _pathToPhoto = [doc_l_path stringByAppendingPathComponent:@"lience.jpg"];
    
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        SelectTimeView *selectView = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        selectView.block = ^(NSString *string) {
            
        };
        [self.view addSubview:selectView];
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        //类选择
        
    }
}
#pragma mark - Delegates & Notifications
#pragma mark - XCDistributionFooterViewDelegate
- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    FinishTipsView *alterView = [[FinishTipsView alloc] initWithTitle:@"预约成功" complete:^{
        
    }];
    [self.view addSubview:alterView];
}

#pragma mark - XCCheckoutDetailPhotoCellDelegate
- (void)XCCheckoutDetailPhotoCellClickphotoImageView:(UIImage *)image index:(NSInteger)index cell:(XCCheckoutDetailPhotoCell *)cell
{
    
}

- (void)XCCheckoutDetailPhotoCellClickAddPhotosImageView:(UIImageView *)imageView cell:(XCCheckoutDetailPhotoCell *)cell
{
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
        [UIImagePNGRepresentation(image) writeToFile:_pathToPhoto atomically:YES];

        
        XCCheckoutDetailPhotoCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        NSURL *fileURL = [NSURL fileURLWithPath:_pathToPhoto];
         [cell setPhotoArr:@[fileURL]];
        
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

#pragma mark - Setter&Getter

@end
