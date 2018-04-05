//
//  CoverAnnouncementView.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "CoverAnnouncementView.h"

@interface CoverAnnouncementView ()

@property (nonatomic,strong) UILabel *announceLabel;
@property (nonatomic,strong) UILabel *tempLabel;
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSArray *titleArray;


@end

@implementation CoverAnnouncementView
@synthesize index = _index;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}


- (void)createUI{

    self.titleArray = @[@"000"
                        ,@"111"
                        ,@"222"
                        ,@"333"
                        ,@"444"
                        ,@"555"
                        ,@"666"
                        ,@"777"
                        ,@"888"
                        ,@"999"];

    self.index = 0;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 18, 18)];
    self.imageView.image = [UIImage imageNamed:@"提醒.png"];
    [self addSubview:_imageView];


    self.announceLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH-40, 40)];
    _announceLabel.textColor = [UIColor whiteColor];
    _announceLabel.text = _titleArray[self.index];
    [self addSubview:_announceLabel];

    self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, SCREEN_WIDTH-40, 40)];
    _tempLabel.textColor = [UIColor whiteColor];
    _tempLabel.text = _titleArray[self.index+1];
    [self addSubview:_tempLabel];
    self.layer.masksToBounds = YES;

    self.timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    if (index == 10) {
        _index = 0;
    }
}

- (NSInteger )index
{
    if (_index == 9) {
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
        self.announceLabel.frame = CGRectMake(40, -40, SCREEN_WIDTH-40, 40);
        self.tempLabel.frame = CGRectMake(40, 0, SCREEN_WIDTH-40, 40);
    } completion:^(BOOL finished) {
        self.announceLabel.text = self.tempLabel.text;
        _tempLabel.text = _titleArray[self.index+1];
        self.announceLabel.frame = CGRectMake(40, 0, SCREEN_WIDTH-40, 40);
        self.tempLabel.frame = CGRectMake(40, 40, SCREEN_WIDTH-40, 40);

    }];
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
