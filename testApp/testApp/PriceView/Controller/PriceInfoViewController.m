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
@interface PriceInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation PriceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

#pragma mark - UITableView delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    static NSString *priceInforLabel = @"infoLabel";
    static NSString *priceCommerceIns = @"commerceIns";
    static NSString *priceCommerceInsFirst = @"commerceInsFirst";
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
//        if (indexPath.row == 0) {
//            PriceCommerceInsTableViewCell *commerceInsCell = [tableView dequeueReusableCellWithIdentifier:priceCommerceInsFirst];
//            if (!commerceInsCell) {
//                commerceInsCell = [[PriceCommerceInsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceCommerceInsFirst];
//            }
//            if (indexPath.row == 0) {
//                commerceInsCell.isFirst = YES;
//            } else {
//                commerceInsCell.isFirst = NO;
//            }
//            commerceInsCell.labelTag.text = @"机动车损险";
//            commerceInsCell.labelInsure.text = @"不计免赔";
//            commerceInsCell.labelAnnotate.text = @"投保";
//            commerceInsCell.labelNumber.text = @"3000";
//            return commerceInsCell;
//        } else {
//            PriceCommerceInsTableViewCell *commerceInsCell = [tableView dequeueReusableCellWithIdentifier:priceCommerceIns];
//            if (!commerceInsCell) {
//                commerceInsCell = [[PriceCommerceInsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceCommerceIns];
//            }
//
//            commerceInsCell.isFirst = NO;
//
//            commerceInsCell.labelTag.text = @"机动车损险";
//            commerceInsCell.labelInsure.text = @"不计免赔";
//            commerceInsCell.labelAnnotate.text = @"投保";
//            commerceInsCell.labelNumber.text = @"3000";
//            return commerceInsCell;
//        }
        PriceCommerceInsTableViewCell *commerceInsCell = [tableView dequeueReusableCellWithIdentifier:priceCommerceInsFirst];
        if (!commerceInsCell) {
            commerceInsCell = [[PriceCommerceInsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceCommerceInsFirst];
        }
        if (indexPath.row == 0) {
            commerceInsCell.isFirst = YES;
        } else {
            commerceInsCell.isFirst = NO;
        }
        commerceInsCell.labelTag.text = @"机动车损险";
        commerceInsCell.labelInsure.text = @"不计免赔";
        commerceInsCell.labelAnnotate.text = @"投保";
        commerceInsCell.labelNumber.text = @"3000";
        return commerceInsCell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
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
        return 5;
    }
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section < 2) {
      return 70 * ViewRateBaseOnIP6;
    } else {
        return 30 * ViewRateBaseOnIP6;
    }
    
}




#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.myTableView];
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        
        _myTableView.separatorColor = [UIColor purpleColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}







@end
