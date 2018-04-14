//
//  UserViewController+ListCellNetworkHandler.h
//  testApp
//
//  Created by Melody on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserViewController.h"
@class XCUserListModel;
@interface UserViewController (ListCellNetworkHandler)
- (void)clickCellHanderNetWorkDataWithModel:(XCUserListModel *)model;
@end
