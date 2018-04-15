//
//  PriceInfoViewController.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController1.h"
@interface PriceInfoViewController : BaseViewController1
@property (nonatomic, strong) NSString *quoteGroup;
@property (nonatomic, strong) NSString *blType;
@property (nonatomic, strong) NSString *route;
@property (nonatomic, assign) double syBaoFei;
@property (nonatomic, strong) NSMutableArray *arrayRecodeData;
@end
