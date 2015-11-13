

#import "BaseViewController.h"
#import "UIViewController+HUD.h"
@interface BaseViewController ()
{
  MCUser *_user; 
}
@property (nonatomic, copy) BarButtonItemActionBlock barbuttonItemAction;


@end

@implementation BaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _user = [MCUser sharedInstance];
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)clickedBarButtonItemAction {
    if (self.barbuttonItemAction) {
        self.barbuttonItemAction();
    }
}

#pragma mark - Public Method

- (void)configureBarbuttonItemStyle:(BarbuttonItemStyle)style action:(BarButtonItemActionBlock)action {
    switch (style) {
        case BarbuttonItemStyleSetting: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        }
        case BarbuttonItemStyleMore: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        }
        case BarbuttonItemStyleCamera: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"album_add_photo"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        }
        default:
            break;
    }
    self.barbuttonItemAction = action;
}

- (void)setupBackgroundImage:(UIImage *)backgroundImage {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Height, Main_Screen_Width)];
    backgroundImageView.image = backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

- (void)pushNewViewController:(UIViewController *)newViewController {
    if (newViewController) {
    }
    [self.navigationController pushViewController:newViewController animated:YES];
}

#pragma mark - Loading

- (void)showLoading:(BOOL)show AndText:(NSString *)text
{
    if (show) {
        
        [self showHudInView:self.view hint:text];
    }
    else{
        [self stopshowLoading];

    }
}
-(void)stopshowLoading{
    [self hideHud];
    
}

- (void)showAllTextDialog:(NSString *)title
{
    [self showHint:title];
}

- (void)showLoading
{
     [self showHudInView:self.view hint:nil];
}

- (void)showSuccess
{
    
}

- (void)showError
{
    
}

#pragma mark - Life cycle
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self appColorNavigation];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    requestManager = [NetworkManager instanceManager];
    requestManager.needSeesion = YES;
    _userid = _user.userid;
    
    _userphone = _user.userphone;
    
    _userSessionId = _user.userSessionId;
    _userExpire = _user.userExpire;
    _userNickname = _user.userNickname;

    _userSex = _user.userSex;
    
    _userThumbnail = _user.userThumbnail;
    
    
    
    
    
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self appColorNavigation];
    
       [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    
    
   // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    //所有的子界面都重写返回按钮并保存返回手势
//    if (self.navigationController.viewControllers.count > 1) {
//        
//        [self.navigationItem setHidesBackButton:YES];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回icon"] style:UIBarButtonItemStylePlain target:self action:@selector(toPopVC)];
//        //self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
//    }


}
-(void)appColorNavigation{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     RGBCOLOR(127, 125, 147), NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"CourierNewPSMT" size:20.0], NSFontAttributeName,
                                                                     nil]];
    self.navigationController.navigationBar.barTintColor =     [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = RGBCOLOR(127, 125, 147);///[UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    //[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
 
}
-(void)ColorNavigation{
    
    self.navigationController.navigationBar.barTintColor =       AppCOLOR;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"Arial-Bold" size:40.0], NSFontAttributeName,
                                                                     nil]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View rotation
//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
//- (NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait;
//}
- (void)toPopVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
