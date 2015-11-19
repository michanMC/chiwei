//
//  SettgViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/19.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "SettgViewController.h"
#import "SettgTableViewCell.h"
#import "MeViewController.h"
@interface SettgViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    NSArray *_array;
    
}

@end

@implementation SettgViewController
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
//    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
//    lbl.text = @"系统设置";
//    //lbl.textAlignment = NSTextAlignmentCenter;
//    lbl.backgroundColor = [UIColor yellowColor];
//    self.navigationItem.titleView = lbl;
    self.title = @"系统设置";
    _array = @[@[@"声音",@"震动",@"系统通知",@"评论通知"],
               @[@"关于我们"]
              ];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettgTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SettgTableViewCell"];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SettgTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tileLbl.text = _array[indexPath.section][indexPath.row];
    cell.tileLbl.textColor = AppTextCOLOR;
    cell.SWBtn.tag = indexPath.row + 600;
    
    [cell.SWBtn setImage:[UIImage imageNamed:@"toggle-off"] forState:UIControlStateNormal];
    [cell.SWBtn setImage:[UIImage imageNamed:@"toggle-on"] forState:UIControlStateSelected];
    cell.SWBtn.selected = YES;
    [cell.SWBtn addTarget:self action:@selector(actionSwBtn:) forControlEvents:UIControlEventTouchUpInside];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    if (indexPath.row == 0) {
        if ([[defaults objectForKey:@"shengyin"] isEqualToString:@"1"]) {
            cell.SWBtn.selected = YES;
        }
        else if([[defaults objectForKey:@"shengyin"] isEqualToString:@"2"]){
            cell.SWBtn.selected = NO;

        }
    }
    else if (indexPath.row == 1) {
        if ([[defaults objectForKey:@"zhendong"] isEqualToString:@"1"]) {
            cell.SWBtn.selected = YES;
        }
        else if([[defaults objectForKey:@"zhendong"] isEqualToString:@"2"]){
            cell.SWBtn.selected = NO;
            
        }
    }
    else if (indexPath.row == 2) {
        if ([[defaults objectForKey:@"xitong"] isEqualToString:@"1"]) {
            cell.SWBtn.selected = YES;
        }
        else if([[defaults objectForKey:@"xitong"] isEqualToString:@"2"]){
            cell.SWBtn.selected = NO;
            
        }
    }
    else if (indexPath.row == 3) {
        if ([[defaults objectForKey:@"pinglun"] isEqualToString:@"1"]) {
            cell.SWBtn.selected = YES;
        }
        else if([[defaults objectForKey:@"pinglun"] isEqualToString:@"2"]){
            cell.SWBtn.selected = NO;
            
        }
    }

    
    
    
    if (indexPath.section == 1) {
        cell.SWBtn.hidden = YES;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    else
        cell.SWBtn.hidden = NO;
    
    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeViewController * ctl = [[MeViewController alloc]init];
    [self pushNewViewController:ctl];
}
-(void)actionSwBtn:(UIButton*)btn{
    /*保存数据－－－－－－－－－－－－－－－－－begin*/
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    

    if (btn.selected ) {
        btn.selected = NO;
        
    }
    else
    {
        btn.selected = YES;
    }
    
    if (btn.tag - 600 == 0) {//声音
       
        if(btn.selected){
            [defaults setObject:@"1" forKey:@"shengyin"];
        }
        else
        {
          [defaults setObject:@"2" forKey:@"shengyin"];
        }
    }
    else if(btn.tag == 601){//震动
        if(btn.selected){
            [defaults setObject:@"1" forKey:@"zhendong"];
        }
        else
        {
            [defaults setObject:@"2" forKey:@"zhendong"];
        }

        
    }
    else if(btn.tag == 602){//系统
        if(btn.selected){
            [defaults setObject:@"1" forKey:@"xitong"];
        }
        else
        {
            [defaults setObject:@"2" forKey:@"xitong"];
        }

        
    }
    else if(btn.tag == 603){//评论
        if(btn.selected){
            [defaults setObject:@"1" forKey:@"pinglun"];
        }
        else
        {
            [defaults setObject:@"2" forKey:@"pinglun"];
        }

        
    }

    //强制让数据立刻保存
    [defaults synchronize];
    
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
