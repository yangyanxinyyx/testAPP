//
//  CoverAnnouncementView.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "CoverAnnouncementView.h"
#import "CoverAnnouncementModel.h"

@interface CoverAnnouncementView ()

@property (nonatomic,strong) UILabel *announceLabel;
@property (nonatomic,strong) UILabel *tempLabel;
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,assign) CGFloat height;

@end

@implementation CoverAnnouncementView
@synthesize index = _index;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.height = frame.size.height;
        [self createUI];
    }
    return self;
}


- (void)createUI{
    self.backgroundColor = COLOR_RGBA_255(0, 0, 0, 0.4);

    NSMutableArray *array = [NSMutableArray array];
    for (CoverAnnouncementModel *model in [UserInfoManager shareInstance].coverMainModel.announcementDatas) {
        if (model) {
            [array addObject:model.title];
        }
    }
    if (array.count == 0) {
        return;
    }
    self.titleArray = array;

    self.index = 0;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 1, 18, 18)];
    self.imageView.image = [UIImage imageNamed:@"提醒.png"];
    [self addSubview:_imageView];


    self.announceLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 0, SCREEN_WIDTH-34, self.height)];
    _announceLabel.textColor = [UIColor whiteColor];
    _announceLabel.text = _titleArray[self.index];
    _announceLabel.font = [UIFont systemFontOfSize:12 * kScaleWidth];
    [self addSubview:_announceLabel];

    self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, self.height, SCREEN_WIDTH-34, self.height)];
    _tempLabel.textColor = [UIColor whiteColor];
    _tempLabel.font = [UIFont systemFontOfSize:12 * kScaleWidth];
    if (_titleArray.count > 1) {
      _tempLabel.text = _titleArray[self.index+1];
    }
    
    [self addSubview:_tempLabel];
    self.layer.masksToBounds = YES;

    if (_titleArray.count > 1) {
        self.timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    }

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height)];
    [self addSubview:btn];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(pressToPush) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    if (index == self.titleArray.count) {
        _index = 0;
    }
}

- (NSInteger )index
{
    if (_index == self.titleArray.count - 1) {
        return 0;
    }else{
        return _index;
    }
}

- (void)nextPage
{
    self.index = self.index +1;
    NSLog(@"%ld",self.index);
    [UIView animateWithDuration:1 animations:^{
        self.announceLabel.frame = CGRectMake(34, -self.height, SCREEN_WIDTH-34, self.height);
        self.tempLabel.frame = CGRectMake(34, 0, SCREEN_WIDTH-34, self.height);
    } completion:^(BOOL finished) {
        self.announceLabel.text = self.tempLabel.text;
        if (_titleArray.count > 1) {
            _tempLabel.text = _titleArray[self.index+1];
        }
        self.announceLabel.frame = CGRectMake(34, 0, SCREEN_WIDTH-34, self.height);
        self.tempLabel.frame = CGRectMake(34, self.height, SCREEN_WIDTH-34, self.height);

    }];
}

- (void)pressToPush
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(pressToPushWebWithID:)]) {
        CoverAnnouncementModel *model = [UserInfoManager shareInstance].coverMainModel.announcementDatas[_index];
        NSNumber *webID = model.announcementId;


        [self.delegate pressToPushWebWithID:webID];
    }

}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
