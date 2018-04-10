//
//  PriceInfoViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceInfoViewController.h"
#import "PriceInfolabelTableViewCell.h"
#import "PriceCommerceInsTableViewCell.h"
#import "PriceInfoAddTableViewCell.h"
#import "PriceInfoSaveTableViewCell.h"
#import "PriceUnderwritingViewController.h"
#import "PriceAdjustViewController.h"
@interface PriceInfoViewController ()<UITableViewDelegate,UITableViewDataSource,PriceInfoSaveTableViewCellDelegate,BaseNavigationBarDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation PriceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate = self;
    topBar.title = @"报价详情";
    [self.view addSubview:topBar];
    [self createUI];
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Network
- (void)requestPrecisePrice{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.quoteGroup forKey:@"quoteGroup"];
    [dic setObject:[UserInfoManager shareInstance].code forKey:@"CustKey"];
    [dic setObject:self.carId forKey:@"carId"];
    [dic setObject:self.blType forKey:@"blType"];
    [RequestAPI getPrecisePrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        
    } fail:^(id error) {
        
    }];
}
#pragma mark - UITableView delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *priceInforLabel = @"infoLabel";
    static NSString *priceCommerceIns = @"commerceIns";
//    static NSString *priceCommerceInsFirst = @"commerceInsFirst";
    static NSString * priceInfoAdd = @"infoAdd";
    static NSString *priceInfoSave = @"infoSave";
    if (indexPath.section == 0) {
        PriceInfolabelTableViewCell *infoLableCell = [tableView dequeueReusableCellWithIdentifier:priceInforLabel];
        if (!infoLableCell) {
            infoLableCell = [[PriceInfolabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInforLabel];
        }
        infoLableCell.labelTag.text = @"交强险";
        infoLableCell.labelInfo.text = @"投保";
        infoLableCell.labelNumber.text = @"¥ 30000000";
        return infoLableCell;
    } else if (indexPath.section == 1) {
    if (indexPath.row < 5 ){
            PriceCommerceInsTableViewCell *commerceInsCell = [tableView dequeueReusableCellWithIdentifier:priceCommerceIns];
            if (!commerceInsCell) {
                commerceInsCell = [[PriceCommerceInsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceCommerceIns];
            }
        
            commerceInsCell.labelTag.text = @"机动车损险";
            commerceInsCell.labelInsure.text = @"不计免赔";
            commerceInsCell.labelAnnotate.text = @"投保";
            commerceInsCell.labelNumber.text = @"3000";
            return commerceInsCell;
        } else if (indexPath.row == 5){
            PriceInfoAddTableViewCell *infoAddCell = [tableView dequeueReusableCellWithIdentifier:priceInfoAdd];
            if (!infoAddCell) {
                infoAddCell = [[PriceInfoAddTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInfoAdd];
            }
            return infoAddCell;
        } else {
            PriceInfolabelTableViewCell *infoLableCell = [tableView dequeueReusableCellWithIdentifier:priceInforLabel];
            if (!infoLableCell) {
                infoLableCell = [[PriceInfolabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInforLabel];
            }
            infoLableCell.labelTag.text = @"合计";
            infoLableCell.labelNumber.text = @"¥ 30000000";
            return infoLableCell;
        }
        
    } else if (indexPath.section == 2) {
        PriceInfolabelTableViewCell *infoLableCell = [tableView dequeueReusableCellWithIdentifier:priceInforLabel];
        if (!infoLableCell) {
            infoLableCell = [[PriceInfolabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInforLabel];
        }
        infoLableCell.labelTag.text = @"总计";
        infoLableCell.labelNumber.text = @"¥ 30000000";
        return infoLableCell;
    }  else {
        PriceInfoSaveTableViewCell *infoSaveCell = [tableView dequeueReusableCellWithIdentifier:priceInfoSave];
        if (!infoSaveCell) {
            infoSaveCell = [[PriceInfoSaveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInfoSave];
        }
        infoSaveCell.delegate = self;
        return infoSaveCell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70 * ViewRateBaseOnIP6)];
    view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(31 * ViewRateBaseOnIP6 , 22 * ViewRateBaseOnIP6, 200, 26 * ViewRateBaseOnIP6)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
    [view addSubview:label];
    if (section == 0) {
        label.text = @"交强险";
        return view;
    } else if (section == 1) {
        label.text = @"商业险";
        return view;
    } else {
        return nil;
    }
    
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 7;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 252*ViewRateBaseOnIP6;
    } else {
        if (indexPath.section == 1 && indexPath.row < 4) {
            return 58 * ViewRateBaseOnIP6;
        } else if(indexPath.row == 4) {
            return 88 * ViewRateBaseOnIP6;
        } else {
           return 88 * ViewRateBaseOnIP6;
        }
        
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section < 2) {
      return 70 * ViewRateBaseOnIP6;
    } else if (section == 2){
        return 30 * ViewRateBaseOnIP6;
    } else {
        return 0;
    }
    
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 5) {
        PriceAdjustViewController *adjustVC = [[PriceAdjustViewController alloc] init];
        [self.navigationController pushViewController:adjustVC animated:YES];
    }
}

#pragma mark- cell Delegate
- (void)savePriveInfoDelegate{
    NSLog(@"保存");
}

- (void)submitNuclearInsDelegate{
    PriceUnderwritingViewController *priceUnderVC = [[PriceUnderwritingViewController alloc] init];
    [self.navigationController pushViewController:priceUnderVC animated:YES];
    
}

#pragma mark- function

#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.myTableView];
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}







@end
