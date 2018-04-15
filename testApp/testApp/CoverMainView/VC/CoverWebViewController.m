//
//  CoverWebViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "CoverWebViewController.h"

@interface CoverWebViewController ()<BaseNavigationBarDelegate>

@property(nonatomic,strong)UIWebView *web;

@end

@implementation CoverWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate  = self;
    topBar.title = @"公告";
    [self.view addSubview:topBar];

    self.web = [[UIWebView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, self.view.bounds.size.width, SCREEN_HEIGHT - kHeightForNavigation - kBottomMargan)];
    [self.view addSubview:_web];
    _web.scrollView.bounces = NO;
    _web.scrollView.showsVerticalScrollIndicator = NO;

    NSDictionary *param = @{@"notice_info_id":_webId};
    [RequestAPI getCoverWeb:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        NSLog(@"%@",response);
        if (response && [response isKindOfClass:[NSDictionary class]] && response[@"result"]) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"获取轮播图成功");
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *data = response[@"data"];
                   
                }



            }else if (([response[@"result"] integerValue] == 0)){
                NSLog(@"公告详情失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"公告详情错误" complete:nil];
                [self.view addSubview:tipsView];
            }
        }
    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }];

//    //先将拿到的id截取前三位
//    NSString *str1 = _webId;
//    str1 = [str1 substringToIndex:3];
//
//    NSString *urlStr = [NSString stringWithFormat:@"http://m.pcauto.com.cn/x/%@/%@.html",str1,_webId];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_web loadRequest:request];
//    NSLog(@"%@",urlStr);
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
