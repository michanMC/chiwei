//
//  MyshouchangViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/1.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MyshouchangViewController.h"
#import "Home2TableViewCell.h"
#import "homeYJModel.h"
#import "travelModel.h"
@interface MyshouchangViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
        UITableView * _tableView;
    BOOL _isEit;
    UIView * foorview;
//    BOOL _isquanxuan;
//    UIButton * _deleteBtn;
//    
//    NSMutableArray *_deleArray;//记录要删除的Btn
    
    NSMutableArray *_dataArray;

    
}

@end

@implementation MyshouchangViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isEit = NO;
        _deleArray = [NSMutableArray array];
        _dataArray = [NSMutableArray array];

       
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disshuaxinObj:) name:@"dishuaxinObjNotification" object:nil];
     self.view.frame = CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44);
    self.view.backgroundColor = [UIColor redColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)disshuaxinObj:(NSNotification*)Notification{
    
    [_dataArray removeAllObjects];
    [self loadData];
    
    
    
    
}
-(void)loadData{
    NSDictionary * Parameterdic = @{
                                    @"page":@(1)
                                    };
    
    
    [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travle/collection/query.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            travelModel * model = [travelModel mj_objectWithKeyValues:dic];
            
            model.homeModel = [homeYJModel mj_objectWithKeyValues:dic[@"travel"]];
            model.homeModel.userModel =[YJUserModel mj_objectWithKeyValues:dic[@"travel"][@"user"]];
            [_dataArray addObject:model];
        }
        
        [_tableView reloadData];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
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
    if (_dataArray.count > indexPath.section) {
        travelModel * model = _dataArray[indexPath.section];
        homeYJModel * homemodel = model.homeModel;

        //title
        if (homemodel.title.length > 9) {//第一行大概9个字
            cell.titleStr = [homemodel.title substringToIndex:9];
            cell.title2Str = [homemodel.title substringFromIndex:9];
            
        }
        else
        {
            cell.titleStr = homemodel.title;
            cell.title2Str = @"";
            
        }
        //photos
        
        if ([homemodel.photos count]) {
            NSString * str = homemodel.photos[0][@"thumbnail"];
            cell.imgViewStr = str;
        }
        //头像
        if(homemodel.userModel.thumbnail)
        {
            
            cell.headimgStr = homemodel.userModel.thumbnail;
            
            
        }
        //姓名
        if (homemodel.userModel.nickname) {
            cell.nameStr = homemodel.userModel.nickname;
        }
        else
        {
            cell.nameStr = @"游客";
        }
        
        //游记类型
        //NSLog(@">>>>%@",[self.classifyDic objectForKey:model[@"classify"]]);
        cell.leixingStr  = [self.classifyDic objectForKey:[NSString stringWithFormat:@"%ld",(long)homemodel.classify]];
        
        
        //游记推荐
        BOOL isRecommend = [homemodel.isRecommend boolValue];
        cell.istuijian = !isRecommend;
        
        
        
        
        
        
    }
    

    cell.isEit = _isEit;
    cell.deleteBtn.tag = indexPath.section + 200;
    [cell.deleteBtn addTarget:self action:@selector(actionCellBtn:) forControlEvents:UIControlEventTouchUpInside];
//    if ([_deleArray containsObject:@(cell.deleteBtn.tag)]) {
//        cell.deleteBtn.selected = YES;
//    }
//    else
//    {
//        cell.deleteBtn.selected = NO;
//    }
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
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    travelModel * model = _dataArray[indexPath.section];
    homeYJModel * homemodel = model.homeModel;
    NSMutableArray * data_Array = [NSMutableArray array];
    for (travelModel * model in _dataArray) {
        [data_Array addObject:model.homeModel];
    }
    
    
    
    NSDictionary * dic = @{
                           @"model":homemodel,
                           @"index":@(indexPath.section),
                           @"dataarray":data_Array
                           };
    
    

    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectzuopinNotification" object:dic];
    
    
    
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
    }
    else
    {
        btn.selected = YES;
        _isquanxuan = YES;
        
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
