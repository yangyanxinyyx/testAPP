//
//  CoverAnnouncementModel.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoverAnnouncementModel : NSObject
@property (nonatomic,strong) NSNumber *creatorId;
@property (nonatomic,strong) NSString *creatorName;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *updaterId;
@property (nonatomic,strong) NSString *updaterName;
@property (nonatomic,strong) NSString *updateTime;
@property (nonatomic,strong) NSNumber *announcementId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *effectDate;
@property (nonatomic,strong) NSString *invalidDate;
@property (nonatomic,strong) NSString *isMustRead;
@property (nonatomic,strong) NSString *isTop;
@property (nonatomic,strong) NSString *isReceipt;
@property (nonatomic,strong) NSString *isImportant;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *code;

;
@end
