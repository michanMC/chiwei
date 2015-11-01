//
//  loginViewController.m
//  CWYouJi
//
//  Created by MC on 15/10/28.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "loginViewController.h"
#import "zhuceViewController.h"
#import "wangjiViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "DEMONavigationController.h"
#import "DEMOHomeViewController.h"
#import "DEMOMenuViewController.h"

@interface loginViewController ()
{
    UIImageView * _bgImgView;
    UITextField * _nameText;
    UITextField * _pwdText;

    
}

@end

@implementation loginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setToolbarHidden:YES animated:NO];
    //self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = Main_Screen_Width;
    CGFloat height = Main_Screen_Height;
    
    _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _bgImgView.image =[UIImage imageNamed:@"login_bg_720"];
    _bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgImgView];
    
    x = 40;
    y  = Main_Screen_Height /2 - 40;
    width = Main_Screen_Width - 80;
    height = 40;
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = .4;
    [_bgImgView addSubview:view1];
    ViewRadius(view1, 20);
    
    y += height +1;
    view1 = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = .4;
    [_bgImgView addSubview:view1];
    ViewRadius(view1, 20);
    x += 15;
    y = Main_Screen_Height /2 - 30;
    width = 20;
    height = 20;
    UIImageView * imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    imgView1.image =[UIImage imageNamed:@"login_icon_user"];
    [_bgImgView addSubview:imgView1];
    y +=height + 10 + 1 + 10;
    imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    imgView1.image =[UIImage imageNamed:@"login_icon_lock"];
    [_bgImgView addSubview:imgView1];
    
    x += 40;
    y = Main_Screen_Height /2 - 30;
    width = Main_Screen_Width - 80 - 15 - 60;
    height = 20;
    _nameText = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _nameText.keyboardType = UIKeyboardTypeNumberPad;
    _nameText.textColor = [UIColor whiteColor];
    _nameText.font = [UIFont systemFontOfSize:14];
    //_nameText.backgroundColor = [UIColor yellowColor];
    [_bgImgView addSubview:_nameText];
    y +=height + 10 + 1 + 10;
    _pwdText = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _pwdText.textColor = [UIColor whiteColor];
    _pwdText.font = [UIFont systemFontOfSize:14];

   // _pwdText.backgroundColor = [UIColor yellowColor];
    [_bgImgView addSubview:_pwdText];
    x = 40;
    y +=20+15;
    width = 50;
    height = 20;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [btn setTitle:@"新用户" forState:0];
    btn.tag = 100;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_bgImgView addSubview:btn];
    
    width = 70;
    x = Main_Screen_Width - 40 - width;
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.tag = 101;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"忘记密码?" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_bgImgView addSubview:btn];
    
    //登陆
    x = 40;
    y += height + 50;
    width = Main_Screen_Width - 80;
    height = 40;
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.tag = 102;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"登陆" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"login_btn_normal"] forState:0];
    [_bgImgView addSubview:btn];

    width = 40;
    height = 40;
    x = (Main_Screen_Width - width)/2;
    y = Main_Screen_Height - 40 - 30;
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:0];
    btn.tag = 103;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:btn];
    x -= (30 + 40);
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"weibo"] forState:0];
    btn.tag = 104;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:btn];
    x = (Main_Screen_Width - width)/2;
    x += (30 + 40);
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:0];
    btn.tag = 105;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:btn];
    
    
    width = 80;
    x = (Main_Screen_Width - width)/2;
    height = 160;
    y  = 50;
    UIImageView * imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    imgView2.image= [UIImage imageNamed:@"login_logo"];
    [_bgImgView addSubview:imgView2];
    

    
}
#pragma mark-点击按钮
-(void)actionBtn:(UIButton*)btn{
    
    if (btn.tag == 100) {//注册
        zhuceViewController * ctl = [[zhuceViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    else if(btn.tag == 101){//忘记密码
        wangjiViewController * ctl = [[wangjiViewController alloc]init];
        [self pushNewViewController:ctl];
  
    }
    else if(btn.tag == 102){//登陆
        [self login];
    }
    else if(btn.tag == 103){//微博
        
    }
    else if(btn.tag == 104){//qq
        
    }
    else if(btn.tag == 105){//微信
        
    }
    
}
#pragma mark-登陆
-(void)login{
    DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[DEMOHomeViewController alloc] init]];
    
    DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    
    // Make it a root controller
    //
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = frostedViewController;
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
