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
    NSInteger pageStr;
    
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
        pageStr = 1;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disshuaxinObj:) name:@"dishoucangshuaxinObjNotification" object:nil];
     self.view.frame = CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44);
    self.view.backgroundColor = [UIColor redColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView addHeaderWithTarget:self action:@selector(actionHeader)];
    [_tableView addFooterWithTarget:self action:@selector(actionFooter)];

    [self loadData:YES];
    // Do any additional setup after loading the view.
}
-(void)disshuaxinObj:(NSNotification*)Notification{
    
    [_dataArray removeAllObjects];
    [self loadData:NO];
    
    
    
    
}
-(void)actionHeader{
    pageStr = 1;
    [_dataArray  removeAllObjects];
    [self loadData:NO];
    
}
-(void)actionFooter{
    
    pageStr ++;
    [self loadData:NO];
    
}

-(void)loadData :(BOOL)iszhuan{
    NSDictionary * Parameterdic = @{
                                    @"page":@(pageStr)
                                    };
    
    
    [self showLoading:iszhuan AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travle/collection/query.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"收藏返回==%@",resultDic);
        
        
        for (NSDictionary * dic in resultDic[@"object"]) {
            travelModel * model = [travelModel mj_objectWithKeyValues:dic];
            
            model.homeModel = [homeYJModel mj_objectWithKeyValues:dic[@"travel"]];
            model.homeModel.userModel =[YJUserModel mj_objectWithKeyValues:dic[@"travel"][@"user"]];
            [_dataArray addObject:model];
        }
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [_tableView reloadData];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];

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
        NSLog(@">>>>%@",[self.classifyDic objectForKey:[NSString stringWithFormat:@"%ld",(long)homemodel.classify]]);
        cell.leixingStr  = [self.classifyDic objectForKey:[NSString stringWithFormat:@"%ld",(long)homemodel.classify]];
        
        cell.dingweiStr = homemodel.spotName;

        //游记推荐
        BOOL isRecommend = [homemodel.isRecommend boolValue];
        cell.istuijian = !isRecommend;
        
        
        cell.deleteBtn.selected = homemodel.isdelete;

        
        
        
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
//    if (_isquanxuan) {//全选
//        cell.deleteBtn.selected = YES;
//    }
//    else
//    {
//        if ([_deleArray containsObject:@(cell.deleteBtn.tag)]) {
//            cell.deleteBtn.selected = YES;
//        }
//        else
//        {
//            cell.deleteBtn.selected = NO;
//        }
//        
//        
//    }
//
    
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
    
    if (!_isEit) {
        
    
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
    
    UIButton * delebtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 2.5, 35, 35)];
    [delebtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [delebtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [delebtn addTarget:self action:@selector(quanxuanBtn:) forControlEvents:UIControlEventTouchUpInside];
    delebtn.tag = 400;
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
    [_deleteBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        NSLog(@">>>>>%@",_deleArray);
        
        if (!_deleArray.count) {
            [self showAllTextDialog:@"请选择你要删除的作品"];
            return ;
        }
        
        NSMutableArray *collectionIdarray = [NSMutableArray array];
        for (int i = 200; i < _dataArray.count + 200; i++) {
            if ([_deleArray containsObject:@(i)]) {
                travelModel * model = _dataArray[i-200];

                [collectionIdarray addObject:model.id];
                
            }
            
            }
        NSString * travelIds = [collectionIdarray componentsJoinedByString:@","];
        [self deletedata:travelIds];
        

        
    }];
    [foorview addSubview:_deleteBtn];
    [self.view addSubview:foorview];
    
    
    
}
-(void)deletedata:(NSString*)collectionIds{
    
    NSDictionary * Parameterdic = @{
                                    @"collectionIds":collectionIds
                                    };
    
    
    [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travle/collection/deleteByCollectionIds.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [_dataArray removeAllObjects];
        [self showAllTextDialog:@"删除成功"];
        [self loadData:YES];
        
        
        //发送通知首页刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dishuaxinObjNotification" object:@""];
        
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didzuopingshuaxinObjNotification" object:@""];

        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    
    
    
}

-(void)actionCellBtn:(UIButton*)btn{
    travelModel * model = _dataArray[btn.tag - 200];
    homeYJModel * homemodel = model.homeModel;

    

    if ([_deleArray containsObject:@(btn.tag)]) {
        [_deleArray removeObject:@(btn.tag)];
        homemodel.isdelete = NO;

    }
    else{
    [_deleArray addObject:@(btn.tag)];
        homemodel.isdelete = YES;

    }
    
     [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",(unsigned long)_deleArray.count] forState:0];
    UIButton * quanxuanbtn = (UIButton*)[self.view viewWithTag:400];
    if (_dataArray.count == _deleArray.count ) {
        quanxuanbtn.selected = YES;
    }
    else
    {
        quanxuanbtn.selected = NO;
        
    }

    
    
    [_tableView reloadData];
    
    
    
    
}
-(void)quanxuanBtn:(UIButton*)btn{
    if (btn.selected) {
        btn.selected = NO;
        [_deleArray removeAllObjects];
        for (travelModel * model in _dataArray) {
            homeYJModel * homemodel = model.homeModel;

            homemodel.isdelete = NO;
        }
        [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",(unsigned long)_deleArray.count] forState:0];

    }
    else
    {
        btn.selected = YES;
        [_deleArray removeAllObjects];
        
        [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%d)",_dataArray.count] forState:0];
        for (int i = 0; i < _dataArray.count; i++) {
            travelModel * model = _dataArray[i];
            homeYJModel * homemodel = model.homeModel;

            homemodel.isdelete = YES;
            [_deleArray addObject:@(200+ i)];
        }

        
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
