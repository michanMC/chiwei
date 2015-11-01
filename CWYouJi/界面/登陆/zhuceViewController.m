//
//  zhuceViewController.m
//  CWYouJi
//
//  Created by MC on 15/10/28.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zhuceViewController.h"
#import "placeholderText.h"
@interface zhuceViewController ()
{
    
    placeholderText * _phoneText;
    placeholderText * _cvvText;
    placeholderText * _pwd1Text;
    placeholderText * _pwd2Text;
    NSTimer *_gameTimer;
    NSDate   *_gameStartTime;

    UIButton * _cvvBtn;
    UITableView * _tableView;
    
}

@end

@implementation zhuceViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setToolbarHidden:YES animated:NO];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    CGFloat width = 160;
    CGFloat height = 60;
    CGFloat y =64 + 20;
    CGFloat x = (Main_Screen_Width - width) /2 ;
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    imgView.image = [UIImage imageNamed:@"signin_logo-"];
    [self.view addSubview:imgView];
    
    x = 40;
    y += height + 20;
    
    width = Main_Screen_Width - 80;
    height = 40;
    _phoneText = [[placeholderText alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _phoneText.placeholder = @"请输入手机号码";
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneText.layer.borderColor =  [UIColor lightGrayColor].CGColor;
    _phoneText.font = [UIFont systemFontOfSize:14];
    _phoneText.layer.borderWidth = 0.5;
    ViewRadius(_phoneText, 20);
    [self.view addSubview:_phoneText];
    y +=height + 5;
    CGFloat cvvbtnY = y;
    _cvvText = [[placeholderText alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _cvvText.keyboardType = UIKeyboardTypeNumberPad;
    _cvvText.layer.borderColor =  [UIColor lightGrayColor].CGColor;
    _cvvText.placeholder = @"验证码";

    _cvvText.font = [UIFont systemFontOfSize:14];
    _cvvText.layer.borderWidth = 0.5;
    ViewRadius(_cvvText, 20);
    [self.view addSubview:_cvvText];
    y +=height + 5;
    _pwd1Text = [[placeholderText alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _pwd1Text.keyboardType = UIKeyboardTypeNumberPad;
    _pwd1Text.layer.borderColor =  [UIColor lightGrayColor].CGColor;
    _pwd1Text.font = [UIFont systemFontOfSize:14];
    _pwd1Text.placeholder = @"请输入密码";
    _pwd1Text.layer.borderWidth = 0.5;
    ViewRadius(_pwd1Text, 20);
    [self.view addSubview:_pwd1Text];
    y +=height + 5;
    _pwd2Text = [[placeholderText alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _pwd2Text.keyboardType = UIKeyboardTypeNumberPad;
    _pwd2Text.layer.borderColor =  [UIColor lightGrayColor].CGColor;
    _pwd2Text.font = [UIFont systemFontOfSize:14];
    _pwd2Text.placeholder = @"请再次输入密码";
    _pwd2Text.layer.borderWidth = 0.5;
    ViewRadius(_pwd2Text, 20);
    [self.view addSubview:_pwd2Text];

    y +=height + 40;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.tag = 102;
    //[btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确认" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"login_btn_normal"] forState:0];
    [self.view addSubview:btn];
    
    y = cvvbtnY + 0.5;
    height = 39;
    width = 70;

    x = Main_Screen_Width - 40 - 80;
    _cvvBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_cvvBtn setTitle:@"获取验证码" forState:0];
    [_cvvBtn setTitleColor:[UIColor orangeColor] forState:0];
    _cvvBtn.titleLabel.font = AppFont;
    //_cvvBtn.backgroundColor = [UIColor yellowColor];
    [_cvvBtn addTarget:self action:@selector(cvvBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cvvBtn];

    x -= 5;
    y += 5;
    width = 0.5;
    height = height - 10;
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    lineview.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineview];
    
    
    
    
}
#pragma mark-点击获取验证码
-(void)cvvBtn{
    
    _gameStartTime=[NSDate date];
     _gameTimer= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
}
// 时钟触发执行的方法
- (void)updateTimer:(NSTimer *)sender
{
    
    NSInteger deltaTime = [sender.fireDate timeIntervalSinceDate:_gameStartTime];
    
    NSString *text = [NSString stringWithFormat:@"%ld",60 - deltaTime];
    
    if (deltaTime>60) {
        [_cvvBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [_cvvBtn setUserInteractionEnabled:YES];
        [_gameTimer invalidate];
        return;
    }else
    {
        [_cvvBtn setTitle:text forState:UIControlStateNormal];
        [_cvvBtn setUserInteractionEnabled:NO];
        
    }
    
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
