

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef void(^BarButtonItemActionBlock)(void);

typedef NS_ENUM(NSInteger, BarbuttonItemStyle) {
    BarbuttonItemStyleSetting = 0,
    BarbuttonItemStyleMore,
    BarbuttonItemStyleCamera,
};

@interface BaseViewController : UIViewController
{
    NetworkManager *requestManager;
}

/**
 用户id
 */
@property(nonatomic,copy)NSString*  userid;//用户账号
/**
 用户手机号
 */
@property(nonatomic,copy)NSString*  userphone;//







-(void)ColorNavigation;

/**
 *  统一设置背景图片
 *
 *  @param backgroundImage 目标背景图片
 */
- (void)setupBackgroundImage:(UIImage *)backgroundImage;

/**
 *  push新的控制器到导航控制器
 *
 *  @param newViewController 目标新的控制器对象
 */
- (void)pushNewViewController:(UIViewController *)newViewController;

/**
 *  显示加载的loading，没有文字的
 */
- (void)showLoading;
/**
 *  显示带有某个文本加载的loading
 *
 *  @param text 目标文本
 */
- (void)showLoading:(BOOL)show AndText:(NSString *)text;

- (void)showAllTextDialog:(NSString *)title;

/**
 *  显示成功的HUD
 */
- (void)showSuccess;
/**
 *  显示错误的HUD
 */
- (void)showError;
-(void)stopshowLoading;
- (void)configureBarbuttonItemStyle:(BarbuttonItemStyle)style action:(BarButtonItemActionBlock)action;
/**
 *  分享
 */
-(void)ShareCtlView:(UIViewController*)ctl;
@end
