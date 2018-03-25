//
//  XCCheckoutBaseTableViewController.m
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#import "XCCheckoutBaseTableViewController.h"
@interface XCCheckoutBaseTableViewController ()
@property (strong, nonatomic) NSIndexPath* editingIndexPath;  //当前左滑cell的index，在代理方法中设置
@end

@implementation XCCheckoutBaseTableViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.tableView registerClass:[XCCheckoutTableViewCell class] forCellReuseIdentifier:kcheckCellID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.editingIndexPath)
    {
        [self configSwipeButtons];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Method

#pragma mark - Privacy Method

- (void)configSwipeButtons
{
    UIButton *deleteButton = nil;
    // 获取选项按钮的reference
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0"))
    {
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.tableView.subviews)
        {
            
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")])
            {
                // 和iOS 10的按钮顺序相反
                //                deleteButton = subview.subviews[1];
                [subview setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
                deleteButton = subview.subviews[0];
                [deleteButton setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
                
                //                UIButton *readButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
                //                [self configReadButton:readButton];
            }
        }
    }
    else
    {
        // iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        XCCheckoutTableViewCell *tableCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews)
        {
            
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")])
            {
                deleteButton = subview.subviews[0];
                //                UIButton *readButton = subview.subviews[1];
                [self configDeleteButton:deleteButton];
                //                [self configReadButton:readButton];
                [subview setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
                //                [subview setBackgroundColor:[[ColorUtil instance] colorWithHexString:@"E5E8E8"]];
            }
        }
    }
    //    [self configDeleteButton:deleteButton];
    //    [self configReadButton:readButton];
}

- (void)configDeleteButton:(UIButton*)deleteButton
{
    if (deleteButton)
    {
        //        [deleteButton.titleLabel setFont:[UIFont fontWithName:@"SFUIText-Regular" size:12.0]];
        //        [deleteButton setTitleColor:COLOR_RGB_255(0, 77, 162) forState:UIControlStateNormal];
        
        [deleteButton setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
        
        
        //        [deleteButton setBackgroundImage:[UIImage imageNamed:@"删除"]  forState:UIControlStateHighlighted];
        // 调整按钮上图片和文字的相对位置（该方法的实现在下面）
        //        [self centerImageAndTextOnButton:deleteButton];
    }
}

#pragma mark - Setter&Getter

#pragma mark - Delegates & Notifications

#pragma mark - Table view data source



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XCCheckoutTableViewCell *cell = (XCCheckoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kcheckCellID forIndexPath:indexPath];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160 * ViewRateBaseOnIP6;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = nil;
}

@end
