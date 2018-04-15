//
//  CoverAnnouncementView.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CoverAnnouncementViewDelegate <NSObject>

- (void)pressToPushWebWithID:(NSNumber *)webId;

@end

@interface CoverAnnouncementView : UIView

@property (nonatomic,weak) id<CoverAnnouncementViewDelegate>delegate;

@end
