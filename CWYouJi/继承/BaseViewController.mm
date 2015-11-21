

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
    _requestManager = [NetworkManager instanceManager];
    _requestManager.needSeesion = YES;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    
    
    
    _userid = _user.userid;
    
    _userphone = [defaults objectForKey:@"mobile"];
    
    _userSessionId = [defaults objectForKey:@"sessionId"];
    _userExpire = _user.userExpire;
    _userNickname = [defaults objectForKey:@"nickname"];

    _userSex = _user.userSex;
    
    _userThumbnail = _user.userThumbnail;
    
    _classifyDic =@{
                                 @"0":@"住",
                                 @"1":@"食",
                                 @"2":@"购",
                                 @"3":@"景",
                                 
                                 };

    
    
    
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
#pragma mark-点击某个分享按钮
-(void)actionFenxian:(SSDKPlatformType)PlatformType{
    
    
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    __weak BaseViewController *theController = self;
    // [self showLoadingView:YES];
    [self showLoading:YES AndText:nil];
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    NSArray* imageArray = @[[UIImage imageNamed:@"坑了-个爹_pressed"]];
    
    if (imageArray) {
        
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeImage];
        
        //进行分享
        [ShareSDK share:PlatformType
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
             [theController stopshowLoading];
             // [theController.tableView reloadData];
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                         message:nil
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                         message:[NSString stringWithFormat:@"%@", error]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                         message:nil
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 default:
                     break;
             }
         }];
    }
    
    
    
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
