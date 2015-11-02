//
//  MyzuopinViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/1.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MyzuopinViewController.h"
#import "HomeTableViewCell.h"
#import "Home2TableViewCell.h"

@interface MyzuopinViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tableView;
    BOOL _isEit;

    UIView * foorview;

}

@end

@implementation MyzuopinViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isEit = NO;
        _deleArray = [NSMutableArray array];
        self.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height- 64 - 44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid1 = @"Home2TableViewCell";
    Home2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        //cell = [[[NSBundle mainBundle]loadNibNamed:@"Home2TableViewCell" owner:self options:nil]lastObject];
        cell = [[Home2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
    }
    cell.isEit = _isEit;
    cell.deleteBtn.tag = indexPath.section + 200;
    [cell.deleteBtn addTarget:self action:@selector(actionCellBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_isquanxuan) {//全选
        cell.deleteBtn.selected = YES;
        
        
        
    }
    else
    {
        if ([_deleArray containsObject:@(cell.deleteBtn.tag)]) {
            cell.deleteBtn.selected = YES;
        }
        else
        {
            cell.deleteBtn.selected = NO;
        }
  
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    cell.contentView.frame = CGRectMake(-50, cell.contentView.frame.origin.y, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
    //    cell.titleLbl1.textColor = AppTextCOLOR;
    //    cell.title2Lb.textColor = AppTextCOLOR;
    //    cell.dingweiimg.textColor = [UIColor grayColor];
    //    cell.nameLbl.textColor = [UIColor grayColor];
    //    ViewRadius(cell.headImg, 20);
    return cell;

//    static NSString *cellid1 = @"HomeTableViewCell";
//    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil]lastObject];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor clearColor];
//    cell.titleLbl1.textColor = AppTextCOLOR;
//    cell.title2Lb.textColor = AppTextCOLOR;
//    cell.dingweiimg.textColor = [UIColor grayColor];
//    cell.nameLbl.textColor = [UIColor grayColor];
//    ViewRadius(cell.headImg, 20);
//    return cell;
    
}
#pragma mark-点击编辑
-(void)actionBianji{
    
    if (_isEit) {
        _isEit = NO;
        [foorview removeFromSuperview];
        _tableView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44);
    }
    else
    {
        _isEit = YES;
        [self addfoorView];
        _tableView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44 - 40);
        
    }
    [_tableView reloadData];
    
    
    
}
-(void)addfoorView{
    foorview = [[UIView alloc]initWithFrame:CGRectMake(0,Main_Screen_Height - 64 - 44 - 40 , Main_Screen_Width, 40)];
    UIView*lineView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 64 - 44 - 40, Main_Screen_Width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [foorview addSubview:lineView];
    foorview.backgroundColor = [UIColor whiteColor];
    
    UIButton * delebtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    [delebtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [delebtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [delebtn addTarget:self action:@selector(quanxuanBtn:) forControlEvents:UIControlEventTouchUpInside];
    [foorview addSubview:delebtn];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 30, 40)];
    lbl.text = @"全选";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:15];
    [foorview addSubview:lbl];
    _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 100, 0,100 , 40)];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_deleteBtn setTitle:@"删除(0)" forState:0];
    _deleteBtn.backgroundColor =[UIColor orangeColor];
    [foorview addSubview:_deleteBtn];
    [self.view addSubview:foorview];
    
    
    
}
-(void)actionCellBtn:(UIButton*)btn{
    
    
    if ([_deleArray containsObject:@(btn.tag)]) {
        [_deleArray removeObject:@(btn.tag)];
    }
    else{
        [_deleArray addObject:@(btn.tag)];
    }
    
    [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",_deleArray.count] forState:0];
    [_tableView reloadData];
    
    
    
    
}
-(void)quanxuanBtn:(UIButton*)btn{
    if (btn.selected) {
        btn.selected = NO;
        _isquanxuan = NO;
    [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",_deleArray.count] forState:0];
    }
    else
    {
        btn.selected = YES;
        _isquanxuan = YES;
        [_deleArray removeAllObjects];
    [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%d)",10] forState:0];
    }
    [_tableView reloadData];
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
