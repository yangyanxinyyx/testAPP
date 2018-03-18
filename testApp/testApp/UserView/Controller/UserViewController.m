//
//  UserViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserViewController.h"
#import "XCUserTopView.h"
#import "XCUserListView.h"

@interface UserViewController ()<XCUserTopViewDelegate>

@property (nonatomic, strong) XCUserTopView * topView;
@property (nonatomic, strong) XCUserListView * listView ;

@property (nonatomic, strong) NSMutableArray * listViewDataArray ;
@end

@implementation UserViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"个人中心";
    // [self.navigationItem setTitle:@"个人中心"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [self initWithData];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UI

- (void)setUI {
    [self.navigationController setNavigationBarHidden:YES];
    self.topView = [[XCUserTopView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, 310 * ViewRateBaseOnIP6)]; // 要适配IPhoneX
    self.topView.delegate = self;
    if (self.listViewDataArray) {
        
        UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
        self.listView = [[XCUserListView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + self.topView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.topView.frame.size.height - STATUS_BAR_HEIGHT - 98 * ViewRateBaseOnIP6) collectionViewLayout:layout];
    }
    [self.view addSubview:self.topView];
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - XCUserTopViewDelegate

- (void)XCUserTopViewMyCommissionButtonClickHandler:(UIButton *)button
{
    
}

- (void)XCUserTopViewModifyPasswordButtonClickHandler:(UIButton *)button
{
    
}

#pragma mark - Privacy Method
- (void)initWithData
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"userListViewData" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        self.listViewDataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }else {
        XCLog(@"Error: class:%@ -initWithData filePath was None",[self class]);
    }
}
#pragma mark - Setter&Getter

@end
