//
//  XCUserInjuryCaseDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserInjuryCaseDetailViewController.h"
#import "XCUserCaseDetailTextCell.h"
#import "XCUserCaseScrollerViewCell.h"
#import "XCUserCaseDetailProgressCell.h"
#define kProcessCellID @"processCellID"
#define kCaseTextCellID @"CaseTextCellID"
#define kScrollViewCellID @"ScrollViewCellID"
#import "XCCheckoutPhotoPreViewController.h"
@interface XCUserInjuryCaseDetailViewController ()<XCUserCaseScrollerViewCellDelegate>
/** <# 注释 #> */
@property (nonatomic, strong) NSArray * dataTitleArrM ;
/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * imageURLArrM ;
@end

@implementation XCUserInjuryCaseDetailViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageURLArrM = [[NSMutableArray alloc] init];
    [self.tableView registerClass:[XCUserCaseDetailTextCell class] forCellReuseIdentifier:kCaseTextCellID];
    [self.tableView registerClass:[XCUserCaseScrollerViewCell class] forCellReuseIdentifier:kScrollViewCellID];
    [self.tableView registerClass:[XCUserCaseDetailProgressCell class] forCellReuseIdentifier:kProcessCellID];
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
}

#pragma mark - lifeCycle

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation )];
}

#pragma mark - Init Method

- (void)configureData
{

    self.dataTitleArrM  = @[@"联系人:",@"联系电话:",@"案发时间:",
                            @"提交时间:",@"咨询电话:"];
}

- (void)initUI
{
    
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications
#pragma mark - XCUserCaseScrollerViewCellDelegate
- (void)XCUserCaseScrollerViewCellClickphotoWithURL:(NSURL *)photoURL index:(NSInteger)index cell:(XCUserCaseScrollerViewCell *)cell
{
    if (photoURL) {
        XCCheckoutPhotoPreViewController *previewVC = [[XCCheckoutPhotoPreViewController alloc] initWithTitle:@"照片预览"];
        previewVC.sourceURL = photoURL;
        
        [self.navigationController pushViewController:previewVC animated:YES];
    }
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        //processCell
        XCUserCaseDetailProgressCell *processCell =  (XCUserCaseDetailProgressCell *)[tableView dequeueReusableCellWithIdentifier:kProcessCellID forIndexPath:indexPath];

        [processCell setProcessStr:_detailModel.status];
        if ([_detailModel.status isEqualToString:@"处理完毕"]) {
            [processCell setIsFinish:YES];
        }else {
            [processCell setIsFinish:NO];
        }
        return processCell;
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        //基本信息Cell
        XCUserCaseDetailTextCell *detailTextCell = (XCUserCaseDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kCaseTextCellID forIndexPath:indexPath];
            [detailTextCell setTitleStr:[NSString stringWithFormat:@"%@%@理赔进度",_detailModel.customerName,self.navTitle]];
        [detailTextCell setLabelTitleArrM:self.dataTitleArrM];
        if(_detailModel) {
            [detailTextCell setupCellWithCaseDetailModel:_detailModel clipName:YES];
        }
        return detailTextCell;
    }
    else if (indexPath.section == 0 && indexPath.row == 2) {
        XCUserCaseDetailTextCell *detailTextCell = (XCUserCaseDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kCaseTextCellID forIndexPath:indexPath];
        [detailTextCell setTitleStr:@"情况说明:"];
        detailTextCell.isMutableTextType = YES;
        [detailTextCell setLongString:_detailModel.remark];
        return detailTextCell;
    }else {
        XCUserCaseScrollerViewCell *cell = (XCUserCaseScrollerViewCell *)[tableView dequeueReusableCellWithIdentifier:kScrollViewCellID forIndexPath:indexPath];
        cell.delegate = self;
        [cell setTitleStr:@"相关文件:"];
        [cell setPhotoURLArr:_imageURLArrM];
        return cell;
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        CGFloat height;
    if (indexPath.row == 0 ) {
        return [XCUserCaseDetailProgressCell getCellHeight];
    }
    else if (indexPath.row == 1) {
      return [XCUserCaseDetailTextCell getCaseCellHeightWithClip:YES];
    }
    else if (indexPath.row == 2) {
        NSString *longString = @"";
        if (_detailModel.remark ) {
            longString = _detailModel.remark;
        }
        height = [self getHeightLineWithString:longString withWidth:645 * ViewRateBaseOnIP6 withFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:24 * ViewRateBaseOnIP6]];
        height  = (20 + 88) * ViewRateBaseOnIP6 +  30 * ViewRateBaseOnIP6 * 2 + height;
        return height;
    }else {
        return (20 + 88 + 140 + 30) * ViewRateBaseOnIP6;
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
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"撤销成功" complete:nil];
    [self.view addSubview:tipsView];
}

- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
}
#pragma mark - Setter&Getter

- (void)setDetailModel:(XCUserCaseDetailModel *)detailModel
{
    _detailModel = detailModel;
    
    if (isUsableNSString(_detailModel.url1, @"")) {
        [_imageURLArrM addObject:_detailModel.url1];
    }
    if (isUsableNSString(_detailModel.url2, @"")) {
        [_imageURLArrM addObject:_detailModel.url2];
    }
    if (isUsableNSString(_detailModel.url3, @"")) {
        [_imageURLArrM addObject:_detailModel.url3];
    }
    if (isUsableNSString(_detailModel.url4, @"")) {
        [_imageURLArrM addObject:_detailModel.url4];
    }
    if (isUsableNSString(_detailModel.url5, @"")) {
        [_imageURLArrM addObject:_detailModel.url5];
    }
    if (isUsableNSString(_detailModel.url6, @"")) {
        [_imageURLArrM addObject:_detailModel.url6];
    }
    if (isUsableNSString(_detailModel.driverPapersUrl1, @"")) {
        [_imageURLArrM addObject:_detailModel.driverPapersUrl1];
    }
    if (isUsableNSString(_detailModel.driverPapersUrl2, @"")) {
        [_imageURLArrM addObject:_detailModel.driverPapersUrl2];
    }
    if (isUsableNSString(_detailModel.driverPapersUrl3, @"")) {
        [_imageURLArrM addObject:_detailModel.driverPapersUrl3];
    }
    if (isUsableNSString(_detailModel.driverPapersUrl4, @"")) {
        [_imageURLArrM addObject:_detailModel.driverPapersUrl4];
    }
    if (isUsableNSString(_detailModel.recognizeeIdcard1, @"") ) {
        [_imageURLArrM addObject:_detailModel.recognizeeIdcard1];
    }
    if (isUsableNSString(_detailModel.recognizeeIdcard2, @"")) {
        [_imageURLArrM addObject:_detailModel.recognizeeIdcard2];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
