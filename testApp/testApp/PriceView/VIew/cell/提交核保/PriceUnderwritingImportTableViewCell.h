//
//  PriceUnderwritingImportTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PriceUnderwritingImportTableViewCellDelegate <NSObject>
- (void)textViewBeginWithTextView:(UITextView *)textView;
- (void)textViewChangeWithTextView:(UITextView *)textView;
- (void)textViewENDWithTextView:(UITextView *)textView;
@end

@interface PriceUnderwritingImportTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, weak) id <PriceUnderwritingImportTableViewCellDelegate> delegate;
@end
