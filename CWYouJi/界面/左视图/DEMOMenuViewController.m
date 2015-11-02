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
@interface DEMOMenuViewController ()<WMAlertViewDelegate>{
    UIImageView *imageView;
    UILabel *label;
    UIImageView * _dengjiimgView;
     WMLabelAlertView*   alert;
    UITableView * _fenxiangView;
    NSInteger index;
}

@end

@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    index = 3;
    NSLog(@"%f",self.tableView.frame.size.width);
    
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
        imageView.image = [UIImage imageNamed:@"mine_default-avatar"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 40;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.tableView.frame.size.width - 50, 20)];
        label.text = @"Roman Efimov";
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
        
        UIButton * _bianjiBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
        //_dengjiimgView.image = [UIImage imageNamed:@"mine_icon_revise"];
        [_bianjiBtn setImage:[UIImage imageNamed:@"mine_icon_revise"] forState:0];
        [view addSubview:_bianjiBtn];
        
        
        UIButton *fenxianBtn = [[UIButton alloc]initWithFrame:CGRectMake((Main_Screen_Width-50) - 10 - 30, (200 - 80)/2, 30, 30)];
        [fenxianBtn setImage:[UIImage imageNamed:@"nav_icon_share"] forState:0];
        [fenxianBtn addTarget:self action:@selector(actionFenxian) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:fenxianBtn];
        
        
        
        view;
    });
}

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
    
    else if(indexPath.row == 5){
        sendString = @"5";
        
    }
    

    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectObjNotification" object:sendString];

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
        cell.titleStr = @"已制作的作品(88)";
        cell.isimg = NO;
        cell.imgViewStr = @"mine_icon_works";
        return cell;
    }
    if (indexPath.row == 2) {
        cell.titleStr = @"我收藏的作品(88)";
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
@end
