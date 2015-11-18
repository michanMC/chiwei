//
//  DEMOMenuViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "DEMOHomeViewController.h"
#import "DEMOSecondViewController.h"
#import "DEMONavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "letf2TableViewCell.h"
#import "letf3TableViewCell.h"
#import "zuopinViewController.h"
#import "letfTableViewCell.h"
#import "WMLabelAlertView.h"
#import "fenxiangViewTableViewCell.h"


#import "REFrostedViewController.h"
#import "AppDelegate.h"

#import "loginViewController.h"
#import "homeYJModel.h"


@interface DEMOMenuViewController ()<WMAlertViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>{
    UIImageView *imageView;
    UILabel *label;
    UIImageView * _dengjiimgView;
     WMLabelAlertView*   alert;
    UITableView * _fenxiangView;
    NSInteger index;
////    MCIucencyView * _mciuc;
//    UITextField * nameText;
//    UITextField * nameText2;
    
    MCUser * _user;
    RGFadeView * rgFadeView;
    UIButton * _bianjiBtn;
    YJUserModel * _usermodel;

}

@end

@implementation DEMOMenuViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didMoenuSelectObj:) name:@"didMoenuSelectObjNotification" object:nil];
    }
    
    return self;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (rgFadeView) {
        
        [rgFadeView removeFromSuperview];
        rgFadeView = nil;
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self Datadetail:NO];

    
}
#pragma mark-监听
- (void)didMoenuSelectObj:(NSNotification *)notication
{
    NSLog(@">>>%@",notication);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    requestManager = [NetworkManager instanceManager];
    requestManager.needSeesion = YES;
    _user=  [MCUser sharedInstance];

    index = 3;
    NSLog(@"%f",self.tableView.frame.size.width);
//    nameText = [[UITextField alloc]initWithFrame:CGRectMake(-100, -100, 10, 10)];
//    nameText.delegate = self;
//    [self.view addSubview:nameText];
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = RGBCOLOR(106, 104, 84);
 //[UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
        UIImageView *_bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width - 50, 200)];
        _bgImgView.image = [UIImage imageNamed:@"mine_bg"];
        [view addSubview:_bgImgView];
       // view.backgroundColor = [UIColor redColor];
       imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (200 - 80)/2, 80, 80)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        //imageView.image = [UIImage imageNamed:@"mine_default-avatar"];
        NSLog(@"%@",_user.userThumbnail);
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_user.userThumbnail] placeholderImage:[UIImage imageNamed:@"mine_default-avatar"]];
       
        
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 40;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * imgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionImgTap)];
        [imageView addGestureRecognizer:imgTap];
        
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.tableView.frame.size.width - 50, 20)];
        label.text =_user.userNickname;
        label.font = [UIFont systemFontOfSize:18];//[UIFont fontWithName:@"HelveticaNeue" size:18];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
       CGFloat lblW = [MCIucencyView heightforString:label.text andHeight:20 fontSize:18];
        CGFloat width = 20;
        CGFloat height = width;
        CGFloat x =(self.tableView.frame.size.width - 50- lblW)/2 - 10 - width;
        CGFloat y = 150;
        _dengjiimgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _dengjiimgView.image = [UIImage imageNamed:@"mine_grade-level"];
    
        
        [view addSubview:_dengjiimgView];
        

    
        [view addSubview:imageView];
        [view addSubview:label];
        
        x = (Main_Screen_Width-50)/2 + lblW / 2 + 10;
        
         _bianjiBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
        //_dengjiimgView.image = [UIImage imageNamed:@"mine_icon_revise"];
        [_bianjiBtn setImage:[UIImage imageNamed:@"mine_icon_revise"] forState:0];
        [_bianjiBtn addTarget:self action:@selector(bianji) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_bianjiBtn];
        
        
        UIButton *fenxianBtn = [[UIButton alloc]initWithFrame:CGRectMake((Main_Screen_Width-50) - 10 - 30, (200 - 80)/2, 30, 30)];
        [fenxianBtn setImage:[UIImage imageNamed:@"nav_icon_share"] forState:0];
        [fenxianBtn addTarget:self action:@selector(actionFenxian) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:fenxianBtn];
        
        
        
        view;
    });
//    _mciuc = [[MCIucencyView alloc ]initWithFrame:CGRectMake(0, -64, Main_Screen_Width, Main_Screen_Height + 64)];
//    [_mciuc setBgViewColor:[UIColor blackColor]];
//    [_mciuc setBgViewAlpha:0.3];
//    [self.view addSubview:_mciuc];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mciucTap)];
//    [_mciuc addGestureRecognizer:tap];
//    _mciuc.hidden = YES;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 90)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton * Btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    Btn1.tag = 400;
    [Btn1 addTarget:self action:@selector(actionBtn1:) forControlEvents:UIControlEventTouchUpInside];
    [Btn1 setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [view addSubview:Btn1];
    Btn1 = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - 30, 5, 30, 30)];
    [Btn1 setImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    [view addSubview:Btn1];

    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    lbl.text = @"编辑昵称";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lbl];
    
    
    
//    nameText2 = [[UITextField alloc]initWithFrame:CGRectMake(5, 5+30 + 5, Main_Screen_Width - 10, 35)];
//    nameText2.placeholder = @"输入昵称";
//    nameText2.textColor = [UIColor grayColor];
//    nameText2.font = [UIFont systemFontOfSize:14];
//    nameText2.borderStyle = UITextBorderStyleRoundedRect;
//    nameText2.enabled = NO;
//    [view addSubview:nameText2];
    
    
//    _countStr = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10-50, 35 + 5 + 5, 50, 20)];
//    _countStr.textAlignment = NSTextAlignmentRight;
//    _countStr.textColor = [UIColor lightGrayColor];
//    _countStr.font = [UIFont systemFontOfSize:13];
//    _countStr.text = @"0/15";
//    [view addSubview:_countStr];
    //nameText.inputAccessoryView = view;

    
    

}

#pragma 点击取消、保存
-(void)actionBtn1:(UIButton*)btn{
    if (btn.tag == 400) {
        //[self mciucTap];
    }
}
#pragma mark-编辑
-(void)bianji{
    if (!rgFadeView) {
        rgFadeView = [[RGFadeView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        [self.view.window addSubview:rgFadeView];
    }
    [rgFadeView textH:150];
    rgFadeView.titelLbl.text = @"编辑昵称";
    rgFadeView.placeLabel.text = @"输入昵称";
    [rgFadeView.msgTextView becomeFirstResponder];
    [rgFadeView.sendBtn addTarget:self action:@selector(ActionSendBtn) forControlEvents:UIControlEventTouchUpInside];
    rgFadeView.msgTextView.tag = 2000;
    rgFadeView.msgTextView.delegate = self;
//    [nameText becomeFirstResponder];
// 
//    _mciuc.hidden = NO;
}
#pragma mark-修改资料
-(void)ActionSendBtn{
    [rgFadeView.msgTextView resignFirstResponder];
    rgFadeView.placeLabel.hidden = NO;
    NSLog(@"%@",rgFadeView.msgTextView.text);
    if (rgFadeView.msgTextView.text.length) {
        
       // [self showHudInView:self.view hint:@"修改中"];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

        NSDictionary * Parameterdic = @{
                                        @"nickname":rgFadeView.msgTextView.text,
                                        @"user_session":[defaults objectForKey:@"sessionId"]
                                        };
        
        
        
        [requestManager requestWebWithParaWithURL:@"api/user/profiles/updateNickname.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
           
            [self hideHud];

            [self showHint:@"修改成功"];
            //发送通知首页刷新
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dishuaxinObjNotification" object:@""];
            

            label.text = rgFadeView.msgTextView.text;
            
            CGFloat lblW = [MCIucencyView heightforString:label.text andHeight:20 fontSize:18];
            
            CGFloat width = 20;
            CGFloat height = width;
            CGFloat x =(self.tableView.frame.size.width - 50- lblW)/2 - 10;
            
            
            CGFloat y = 150;
            
            _dengjiimgView .frame= CGRectMake(x, y, width, height);
            
            _user.userNickname = label.text;
            
            x = (Main_Screen_Width-50)/2 + lblW / 2 + 10;
            
            _bianjiBtn.frame = CGRectMake(x,_bianjiBtn.frame.origin.y , _bianjiBtn.frame.size.width, _bianjiBtn.frame.size.height);
            
            NSLog(@"成功");
            NSLog(@"返回==%@",resultDic);
            
            
            
            
            
        } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
            [self hideHud];
            [self showHint:description];
            NSLog(@"失败");
        }];
        

    }
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 2000) {
        [self ActionSendBtn];
    }
    
}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    nameText2.text = nameText.text;
//    
//    
//    return YES;
//}
//-(void)mciucTap{
//    
//    _mciuc.hidden = YES;
//    nameText.text = @"";
//    nameText2.text = @"";
//    [nameText resignFirstResponder];
//    
//    
//    
//}

#pragma mark -
#pragma mark UITableView Delegate

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.backgroundColor = [UIColor clearColor];
//    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
//    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
//{
//    if (sectionIndex == 0)
//        return nil;
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
//    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
//    label.text = @"Friends Online";
//    label.font = [UIFont systemFontOfSize:15];
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor clearColor];
//    [label sizeToFit];
//    [view addSubview:label];
//    
//    return view;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
//{
//    if (sectionIndex == 0)
//        return 0;
//    
//    return 34;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _fenxiangView) {
        if (indexPath.section == 0) {
            if (index== 0) {
                index  = 3;
            }
            else{
            index = 0;
            }
        }
        else
        {
            if (index== 1) {
                index  = 3;
            }
            else{
                index = 1;
            }
        }
        [_fenxiangView reloadData];
        return;
    }
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        DEMOHomeViewController *homeViewController = [[DEMOHomeViewController alloc] init];
//        
//        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:homeViewController];
//        self.frostedViewController.contentViewController = navigationController;
//    } else {
       // DEMOSecondViewController *secondViewController = [[DEMOSecondViewController alloc] init];
        // zuopinViewController *secondViewController = [[zuopinViewController alloc] init];
    //[self.frostedViewController.navigationController pushViewController:secondViewController animated:YES];
//        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:secondViewController];
//        self.frostedViewController.contentViewController = navigationController;
    
    
    
   // }
    if (indexPath.row == 3) {
        return;
    }
    if(indexPath.row == 5){
//注销
        
        [self logout];
        
        
        return;
    }

    [self.frostedViewController hideMenuViewController];
    
    //要传的值
    NSString *sendString;
    if (indexPath.row == 0) {
        sendString = @"0";
    }
    else if(indexPath.row == 1){
        sendString = @"1";
 
    }
    else if(indexPath.row == 2){
        sendString = @"2";
        
    }
    else if(indexPath.row == 4){
        sendString = @"4";
        
    }
    


    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectObjNotification" object:sendString];

}
#pragma mark-查询资料
-(void)Datadetail:(BOOL)iszhuan{
    
  
    [requestManager requestWebWithParaWithURL:@"api/user/detail.json" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
      _usermodel  = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"]];
        
        [self.tableView  reloadData];
        
        //头像
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AppImgURL,_usermodel.thumbnail]] placeholderImage:[UIImage imageNamed:@"mine_default-avatar"]];
        

        
        label.text = _usermodel.nickname;
        
        CGFloat lblW = [MCIucencyView heightforString:label.text andHeight:20 fontSize:18];
        
        CGFloat width = 20;
        CGFloat height = width;
        CGFloat x =(self.tableView.frame.size.width - 50- lblW)/2 - 10;
        
        
        CGFloat y = 150;
        
        _dengjiimgView .frame= CGRectMake(x, y, width, height);
        
        _user.userNickname = label.text;
        
        x = (Main_Screen_Width-50)/2 + lblW / 2 + 10;
        
        _bianjiBtn.frame = CGRectMake(x,_bianjiBtn.frame.origin.y , _bianjiBtn.frame.size.width, _bianjiBtn.frame.size.height);
        

        
        
        
        
        
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showHint:description];
        NSLog(@"失败");
    }];

    
    
    
    
    
}
#pragma mark-注销
-(void)logout{
    
    [self showHudInView:self.view hint:nil];
    
    [requestManager requestWebWithParaWithURL:@"api/user/logout.json" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject :@"" forKey:@"Pwd"];
        
        [defaults setObject :@"" forKey:@"sessionId"];
        [defaults setObject :@"" forKey:@"nickname"];
        [defaults setObject :@"" forKey:@"mobile"];
        [defaults setObject :@"" forKey:@"id"];
        [defaults setObject :@"" forKey:@"password"];
        
        //强制让数据立刻保存
        [defaults synchronize];
        [self showHint:@"账号已退出"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            loginViewController *loginVC = [[loginViewController alloc]init];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            DEMONavigationController *nav = [[DEMONavigationController alloc]initWithRootViewController:loginVC];
            appDelegate.window.rootViewController = nav;

        });

        

       
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showHint:description];
        NSLog(@"失败");
    }];
 
    
    
    
}
#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _fenxiangView) {
        return 40;
    }
    if (indexPath.row == 0) {
        return 60;
    }
    if (indexPath.row == 3) {
        return 20;
    }
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _fenxiangView) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == _fenxiangView) {
        if (section == 0) {
           return 0.5;
        }
        
    }
    return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (_fenxiangView == tableView) {
        return 1;
    }
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _fenxiangView) {
        static NSString *cellIdentifier2 = @"fenxiangViewTableViewCell";
        fenxiangViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:cellIdentifier2 owner:self options:nil]lastObject];
        }
        cell.titleLbl.textColor = AppTextCOLOR;
        if (indexPath.section == 0) {
            cell.titleLbl.text = @"国内";
        }
        else
        {
            cell.titleLbl.text = @"国外";

        }
        if (index == indexPath.section) {
            cell.btn.hidden = NO;
            cell.titleLbl.textColor = [UIColor orangeColor];
        }
        else
        {
            cell.titleLbl.textColor = AppTextCOLOR;

           cell.btn.hidden = YES;
        }
        
        return cell;//[[UITableViewCell alloc]init];
        
    }
    static NSString *cellIdentifier = @"letfTableViewCell";
    static NSString *cellIdentifier2 = @"mc";
    if (indexPath.row == 0) {
        letfTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil]lastObject];
        }
        cell.backgroundColor = RGBCOLOR(106, 104, 84);

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLbl.text = @"你已经吐槽180条，赞美20条游记，请继续不吐不快吧";
        
        
        return cell;
    }
    if (indexPath.row == 3) {
        letf3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"letf3TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"letf3TableViewCell" owner:self options:nil]lastObject];
        }
        cell.backgroundColor = RGBCOLOR(106, 104, 84);

        return cell;
    }
    
    
    letf2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
    if (!cell) {
        cell = [[letf2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2 ];
    }
    
    cell.backgroundColor = RGBCOLOR(106, 104, 84);
    if (indexPath.row == 1) {
        cell.titleStr = [NSString stringWithFormat:@"已制作的作品(%@)",_usermodel.travelCount ];
        cell.isimg = NO;
        cell.imgViewStr = @"mine_icon_works";
        return cell;
    }
    if (indexPath.row == 2) {
        cell.titleStr = [NSString stringWithFormat:@"我收藏的作品(%@)",_usermodel.collectionCount ];
        cell.isimg = YES;
        cell.imgViewStr = @"mine_icon_favorite";
        return cell;
    }
    if (indexPath.row == 4) {
        cell.titleStr = @"系统设置";
        cell.isimg = YES;
        cell.imgViewStr = @"mine_icon_setting";
        return cell;
    }
    if (indexPath.row == 5) {
        cell.titleStr = @"退出登录";
        cell.isimg = YES;
        cell.imgViewStr = @"mine_icon_quit";
        return cell;
    }

    return cell;
}
#pragma mark-分享
-(void)actionFenxian{
    _fenxiangView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 80, 2 * 40)style:UITableViewStyleGrouped];
    // _yinhanView.bounces = NO;
    //table.scrollEnabled = NO;
    _fenxiangView.delegate = self;
    _fenxiangView.dataSource = self;
    _fenxiangView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _fenxiangView.scrollEnabled = NO;
    alert = [[WMLabelAlertView alloc]initWithTitle:@"请选择分享范围" contentView:_fenxiangView];
   // alert.leftButton.frame = CGRectMake(alert.leftButton.frame.origin.x, alert.leftButton.frame.origin.y, alert.leftButton.frame.size.width * 2+0.5, alert.leftButton.frame.size.height);
    alert.delegate = self;
    //[alert.rightButton removeFromSuperview];
    [alert.leftButton setTitleColor:RGBCOLOR(249, 77, 33) forState:0];
    alert.titleLabel.textColor = AppTextCOLOR;
    
    
    [alert show];

    
}
-(void)alertViewDidClickSureButton:(WMAlertView *)alertView
{
    NSLog(@"%ld",index);
    NSLog(@"确定");
}
-(void)alertViewDidClickCancleButton:(WMAlertView *)alertView
{
    NSLog(@"%ld",index);
    NSLog(@"取消");
}
#pragma mark-点击头像
-(void)actionImgTap{
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"从相册选择", @"拍照",nil];
    
    [myActionSheet showInView:self.view];
}
#pragma mark-选择从哪里拿照片
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==2) return;
    
    
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if(buttonIndex==1){//拍照
        sourceType=UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable:sourceType]){
            kAlertMessage(@"检测到无效的摄像头设备");
            return ;
        }
    }
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing=YES;
    picker.sourceType=sourceType;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        
        
        [self updateAvatar:image];
    }
}
#pragma mark-上传头像
-(void)updateAvatar:(UIImage*)img{
    [self showHudInView:self.view hint:@"上传中"];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.2);
    NSString *base64Image=[imageData base64Encoding];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    NSDictionary * Parameterdic = @{
                                    @"image":base64Image,
                                    @"user_session":[defaults objectForKey:@"sessionId"]
                                    };
    
    
    
    [requestManager requestWebWithParaWithURL:@"api/user/profiles/updateAvatar.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        //发送通知首页刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dishuaxinObjNotification" object:@""];
        
        //头像
        imageView.image = img;

        _user.userThumbnail = resultDic[@"object"];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showHint:description];
        NSLog(@"登录失败");
    }];
    

    
}
@end
