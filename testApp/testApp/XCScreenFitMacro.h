//
//  XCScreenFitMacro.h
//  testApp
//
//  Created by Melody on 2018/3/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#ifndef XCScreenFitMacro_h
#define XCScreenFitMacro_h

#import <Foundation/Foundation.h>
#import "sys/utsname.h"
#import "FinishTipsView.h"
#import "UserInfoManager.h"
#import "BaseNavigationBar.h"
#import "RequestAPI.h"

#pragma mark -  屏幕适配常量

#define APP_SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
#define APP_SCREEN_CONTENT_HEIGHT   ([UIScreen mainScreen].bounds.size.height-20.0)
#define STATUS_BAR_HEIGHT           [[UIApplication sharedApplication] statusBarFrame].size.height  //获取状态栏高度。当状态栏为隐藏状态，则为0;
#define NAVIGATION_BAR_HEIGHT       44  //默认的navagationBar 高度

#define StatusBarHeight WindowSafeAreaInsets.top  //获取安全区域顶部距离
#define SafeAreaBottomBarHeight WindowSafeAreaInsets.bottom  //获取安全区域底部距离

#define MATERIALBASERATE 0.5
#define MATERAILZOOMINRATE 0.6

#define safeAreaTop        (IS_812_HEIGHT_LOGICPIXEL ? 44.f : 0.0)  //特殊情况下，可以使用。写死的顶部举例距离，一般情况,不建议使用。请使用WindowSafeAreaInsets.top。
#define safeAreaBottom     (IS_812_HEIGHT_LOGICPIXEL ? 34.0 : 0.0)  //特殊情况下，可以使用。写死的底部举例距离，一般情况,不建议使用。请使用WindowSafeAreaInsets.bottom。

#define IS_480_HEIGHT_LOGICPIXEL                ((APP_SCREEN_HEIGHT - 480.0f > -0.01f) && (APP_SCREEN_HEIGHT - 480.0f < 0.01f))
#define IS_568_HEIGHT_LOGICPIXEL                ((APP_SCREEN_HEIGHT - 568.0f > -0.01f) && (APP_SCREEN_HEIGHT - 568.0f < 0.01f))
#define IS_667_HEIGHT_LOGICPIXEL                ((APP_SCREEN_HEIGHT - 667.0f > -0.01f) && (APP_SCREEN_HEIGHT - 667.0f < 0.01f))
#define IS_736_HEIGHT_LOGICPIXEL                ((APP_SCREEN_HEIGHT - 736.0f > -0.01f) && (APP_SCREEN_HEIGHT - 736.0f < 0.01f))
#define IS_812_HEIGHT_LOGICPIXEL                ((APP_SCREEN_HEIGHT - 812.0f > -0.01f) && (APP_SCREEN_HEIGHT - 812.0f < 0.01f))
#define IS_1024_HEIGHT_LOGICPIXEL               ((APP_SCREEN_HEIGHT - 1024.0f > -0.01f) && (APP_SCREEN_HEIGHT - 1024.0f < 0.01f))

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_FRAME [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define VIEW_RATE ([[UIScreen mainScreen] bounds].size.width / 640.0f)
#define ADAPT_TRANS [[UIScreen mainScreen] bounds].size.height * 2.0f / ([[UIScreen mainScreen] bounds].size.width * 3.0f)
#define IS_IPAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE5 (SCREEN_WIDTH/SCREEN_HEIGHT > (320.0f/568.0f - 0.01f) && SCREEN_WIDTH/SCREEN_HEIGHT < (320.0f/568.0f + 0.01f))

#define ViewRateBaseOnIP6              [UIScreen mainScreen].bounds.size.width/750.0
#define ViewRateBaseOnHeightOfIP6      [UIScreen mainScreen].bounds.size.height/1334.0

#define ViewRateBaseOnIP6FitiPad ((IS_IPAD) ? (ViewRateBaseOnIP6 * 0.7) : (ViewRateBaseOnIP6))
#define ViewRateBaseOnHeightOfIP6FitiPad ((IS_IPAD) ? (ViewRateBaseOnHeightOfIP6 * 0.7) : (ViewRateBaseOnHeightOfIP6))

#define ViewLengthBaseOnIP6(length)    ceil(length*[UIScreen mainScreen].bounds.size.width/750.0)

#define ViewRateBaseOnWidthOfIPAD      [UIScreen mainScreen].bounds.size.width/768.0
#define ViewRateBaseOnHeightOfIPAD     [UIScreen mainScreen].bounds.size.height/1024.0

#define VIEW_MATERIAL_BASE_RATE               (((IS_480_HEIGHT_LOGICPIXEL)||(IS_568_HEIGHT_LOGICPIXEL)||(IS_667_HEIGHT_LOGICPIXEL)||(IS_736_HEIGHT_LOGICPIXEL)||(IS_812_HEIGHT_LOGICPIXEL))?0.5:([UIScreen mainScreen].bounds.size.width / 640.0))

#define kScaleWidth ([[UIScreen mainScreen] bounds].size.width/375)
#define kScaleHeight ([[UIScreen mainScreen] bounds].size.height/667)

#define kiPadScale (IS_IPAD?1.5:1.0)

#pragma mark -  颜色宏

#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBASTRINGCOLOR(COLORSTRING)    [UIColor colorWithRGBHexString:COLORSTRING]

#define COLOR_RGB_255(r, g, b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define COLOR_RGBA_255(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#pragma mark -  自定义的函数宏

/* 备注说明：
 * 当UIViewController 调用 viewDidLoad 时,它的所有子视图的safeAreaInsets属性都等于UIEdgeInsetsZero,
 * 在viewSafeAreaInsetsDidChange,方法调用前 是无法通过当前视图控制器的子视图获取到safeAreaInsets的.
 * viewSafeAreaInsetsDidChange 在UIViewController中第一次调用的时间是在viewWillAppear调用之后,viewWillLayoutSubviews调用之前.
 * 由于布局需要，需要提前获取安全区域的，可以获取当前window对象的safeAreaInsets属性用来计算也是可以的,
 * 但是不建议这么做, 一个视图控制器的子视图的处理当然要以它所在的控制器为准.
 *
 */

//获取个view的安全距离
#define  SafeAreaInsets(view)\
({\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wavailability\"") \
UIEdgeInsets edgeInsets = UIEdgeInsetsZero;\
if (@available(iOS 11.0, *)) {\
edgeInsets = view.safeAreaInsets; \
}\
(edgeInsets);\
_Pragma("clang diagnostic pop") \
})\

//获取个window的安全距离
#define  WindowSafeAreaInsets \
({\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wavailability\"") \
UIEdgeInsets edgeInsets = UIEdgeInsetsZero;\
if (@available(iOS 11.0, *)) {\
edgeInsets =     [UIApplication sharedApplication].delegate.window.safeAreaInsets; \
}\
(edgeInsets);\
_Pragma("clang diagnostic pop") \
})\

//设置scrollbview 不要自动下滑一段距离
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)


//适配iPhoneX
#define isIPhoneX           ((SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f) || isIPhoneXSystemInfo() ? YES : NO)
#define kBottomMargan        (isIPhoneX ? 34.f : 0.f)
#define kNavMargan        (isIPhoneX ? 44.f : 0.f)
#define kHeightForNavigation  (kNavMargan + STATUS_BAR_HEIGHT + 44)

inline static BOOL isIPhoneXSystemInfo() {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone10,3"]) {
        return YES;
    }else if ([deviceString isEqualToString:@"iPhone10,6"]){
        return YES;
    }else{
        return NO;
    }
}

#endif /* XCScreenFitMacro_h */
