//
//  PriceCustomerInformEntryViewController.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController1.h"

typedef void(^RequestSucces)(NSString *);

@interface PriceCustomerInformEntryViewController : BaseViewController1
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, copy) RequestSucces requestSucces;
@end
