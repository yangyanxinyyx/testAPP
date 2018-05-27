//
//  WSImageBroserCell.h
//  doucui


#import <UIKit/UIKit.h>
#import "WSImageModel.h"
@class WSImageBroserCell;
@protocol WSImageBroserCellDelegate <NSObject>

- (void)WSImageBroserCellLongPressCell:(WSImageBroserCell *)cell;

@end

@interface WSImageBroserCell : UICollectionViewCell
@property (nonatomic, weak) id<WSImageBroserCellDelegate> delegate;
@property (nonatomic, strong) WSImageModel *model;
@property (nonatomic, strong) UIImageView *imageView;


@end
