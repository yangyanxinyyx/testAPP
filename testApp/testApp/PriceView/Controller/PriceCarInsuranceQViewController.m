//
//  PriceCarInsuranceQViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
// 车险报价

#import "PriceCarInsuranceQViewController.h"
#import "priceCIQChangeView.h"
#import "PriceCarRecordTableViewCell.h"
#import "priceCRQLastYLabelTableViewCell.h"
#import "PriceCRQLastYInfoTableViewCell.h"
@interface PriceCarInsuranceQViewController ()<UITableViewDelegate,UITableViewDataSource,priceCIQChangeViewDelegate>
@property (nonatomic, strong) priceCIQChangeView *CIQChangeView;
@property (nonatomic, strong) UIView *viewBear;
@property (nonatomic, strong) UIView *viewLastY;
@property (nonatomic, strong) UIView *viewPriceRecord;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UITableView *tableViewlast;
@property (nonatomic, strong) UIView *viewSegmentation;
@property (nonatomic, strong) UIButton *buttonRevisePrice;
@property (nonatomic, strong) UIButton *buttonPrice;
@property (nonatomic, strong) UIView *viewSegment;
@end

@implementation PriceCarInsuranceQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"车险报价";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [self createUI];
}

#pragma mark - function
- (void)touchButtonRevisePrice:(UIButton *)button{
    NSLog(@"修改报价方案");
}

- (void)touchButtonPrice:(UIButton *)button{
    NSLog(@"报价");
}

#pragma  mark - view delegate
- (void)changeModel:(BOOL)isLaseY{
    if (isLaseY) {
        self.viewBear.frame = CGRectMake(0, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
    } else {
        self.viewBear.frame = CGRectMake(-SCREEN_WIDTH, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
    }
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableViewlast) {
        return 4;
    } else {
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.myTableView) {
      return 3;
    } else {
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.myTableView) {
        static NSString *identifier = @"identifier";
        PriceCarRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceCarRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.labelName.text = @"刘先生报价 (3)";
        cell.labelTime.text = @"2018-02-12 09:30:30";
        cell.labelNum.text = @"报价¥10,500.00";
        
        return cell;
    } else {
        if (indexPath.row == 0) {
            static NSString *identifierLabel = @"identifierLabel";
            priceCRQLastYLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierLabel];
            if (!cell) {
                cell = [[priceCRQLastYLabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierLabel];
            }
            cell.labelName.text = @"交强险";
            cell.labelInfo.text = @"投保";
            return cell;
        } else {
            static NSString *identifier = @"identifierInfo";
            PriceCRQLastYInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[PriceCRQLastYInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];            }
            cell.labelName.text = @"第三责任险";
            cell.labelNum.text = @"40万";
            return cell;
            
        }

        
    }
 
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.myTableView) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10 * ViewRateBaseOnIP6)];
        view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        return view;
    } else {
        return nil;
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.myTableView) {
        return 120 * ViewRateBaseOnIP6;
    } else {
        if (indexPath.row == 0) {
            return 75 * ViewRateBaseOnIP6;
        } else {
            return 60 * ViewRateBaseOnIP6;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.myTableView) {
        return 10 * ViewRateBaseOnIP6;
    } else {
        return 0;
    }

}

- (void)createUI{
    [self.view addSubview:self.viewBear];
    [self.view addSubview:self.CIQChangeView];
    [self.viewBear addSubview:self.viewLastY];
    [self.viewBear addSubview:self.viewPriceRecord];
    [self.viewLastY addSubview:self.tableViewlast];
    [self.viewPriceRecord addSubview:self.myTableView];
    [self.view addSubview:self.buttonPrice];
    [self.view addSubview:self.buttonRevisePrice];
    [self.view addSubview:self.viewSegmentation];
    [self.view addSubview:self.viewSegment];
}

- (priceCIQChangeView *)CIQChangeView{
    if (!_CIQChangeView) {
        _CIQChangeView = [[priceCIQChangeView alloc] initWithFrame:CGRectMake(0, 20 * ViewRateBaseOnIP6, SCREEN_WIDTH, 160 * ViewRateBaseOnIP6)];
        _CIQChangeView.delegate = self;
    }
    return _CIQChangeView;
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 244 * ViewRateBaseOnIP6) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorColor = [UIColor purpleColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _myTableView;
}

- (UITableView *)tableViewlast{
    if (!_tableViewlast) {
        _tableViewlast = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 777 * ViewRateBaseOnIP6 - 64 ) style:UITableViewStylePlain];
        _tableViewlast.delegate = self;
        _tableViewlast.dataSource = self;
        _tableViewlast.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _tableViewlast.showsVerticalScrollIndicator = NO;
        _tableViewlast.bounces = YES;
        _tableViewlast.separatorColor = [UIColor purpleColor];
        _tableViewlast.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableViewlast;
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
- (UIView *)viewSegmentation{
    if (!_viewSegmentation) {
        _viewSegmentation = [[UIView alloc] initWithFrame:CGRectMake(0, 937 * ViewRateBaseOnIP6, SCREEN_WIDTH, 1 * ViewRateBaseOnIP6)];
        _viewSegmentation.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    }
    return _viewSegmentation;
}

- (UIButton *)buttonRevisePrice{
    if (!_buttonRevisePrice) {
        _buttonRevisePrice = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonRevisePrice.frame = CGRectMake(0 , 937 * ViewRateBaseOnIP6, SCREEN_WIDTH, 100 * ViewRateBaseOnIP6);
        [_buttonRevisePrice setTitle:@"修改报价方案" forState:UIControlStateNormal];
        [_buttonRevisePrice setTitleColor:[UIColor colorWithHexString:@"#6899e8"] forState:UIControlStateNormal];
        _buttonRevisePrice.titleLabel.font = [UIFont systemFontOfSize:28 * ViewRateBaseOnIP6];
        [_buttonRevisePrice addTarget:self action:@selector(touchButtonRevisePrice:) forControlEvents:UIControlEventTouchDown];
    }
    return _buttonRevisePrice;
}

- (UIButton *)buttonPrice{
    if (!_buttonPrice) {
        _buttonPrice = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonPrice.frame = CGRectMake(30 * ViewRateBaseOnIP6, 1036 * ViewRateBaseOnIP6, SCREEN_WIDTH - 60 * ViewRateBaseOnIP6, 90 * ViewRateBaseOnIP6);
        [_buttonPrice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonPrice setTitle:@"报价" forState:UIControlStateNormal];
        _buttonPrice.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:162.0f/255.0f alpha:1.0f];
        _buttonPrice.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
        _buttonPrice.layer.masksToBounds = YES;
        [_buttonPrice addTarget:self action:@selector(touchButtonPrice:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _buttonPrice;
}
@end
