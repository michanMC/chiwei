//
//  DEMOHomeViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOHomeViewController.h"
#import "DEMONavigationController.h"
#import "ZZCarousel.h"
#import "MCplaceholderText.h"
#import "HomeTableViewCell.h"
#import "zuopinViewController.h"
#import "zuopinXQViewController.h"
#import "DMLazyScrollView.h"
#import "shaixuanView.h"
#import "zhizuoZP1ViewController.h"
#import "jingdianView.h"
#import "homeYJModel.h"
@interface DEMOHomeViewController ()<ZZCarouselDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate,jingdianViewDelegate>
{
    
    UITableView * _tableView;
    ZZCarousel *_headwheel;//广告图
    MCplaceholderText *_searchtext;
    UIButton * _faBuBtn;
    UIView * _daohanTiaoview;
    UIView * _daohanTiaoLineview;
    
    shaixuanView *_shaixuanView;
    jingdianView *_jiangdianView;
    //喜欢
    NSInteger _btnTagindexXH;
    //分类
     NSInteger _btnTagindexFL;
    
    NSMutableArray *_dataAarray;//数据源
    NSInteger _pageStr;
    
    NSMutableArray *_bannerArray;

}

@end

@implementation DEMOHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _pageStr = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectObj:) name:@"didSelectObjNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dishuaxinObj:) name:@"dishuaxinObjNotification" object:nil];
	self.title = @"Home Controller";
    _dataAarray  =[NSMutableArray array];
    _bannerArray = [NSMutableArray array];
    [self prepareUI];
    
    
    _shaixuanView = [[[NSBundle mainBundle] loadNibNamed:@"shaixuanView" owner:self options:nil] lastObject];
    _shaixuanView.frame = CGRectMake(0, 64.5, Main_Screen_Width, Main_Screen_Height - 64);
    _shaixuanView.hidden = YES;

    [self btnview:_shaixuanView.quanbu1];
    [self btnview:_shaixuanView.tuijian];
    [self btnview:_shaixuanView.butuijian];
    [self btnview:_shaixuanView.quanbu2];
    [self btnview:_shaixuanView.shiBtn];
    [self btnview:_shaixuanView.zhuBtn];
    [self btnview:_shaixuanView.jingBtn];
    [self btnview:_shaixuanView.gouBtn];
    [_shaixuanView.quanbu1 addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [_shaixuanView.tuijian addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];

    [_shaixuanView.butuijian addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];

    [_shaixuanView.quanbu2 addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];

    [_shaixuanView.shiBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];

    [_shaixuanView.zhuBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [_shaixuanView.jingBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];

    [_shaixuanView.gouBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];

    [_shaixuanView.okBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];


    [self.view addSubview:_shaixuanView];
    
    
    
    _jiangdianView = [[jingdianView alloc]initWithFrame:CGRectMake(0, 64.5, Main_Screen_Width, Main_Screen_Height - 64.5)];
    _jiangdianView.delegate = self;
    _jiangdianView.hidden = YES;
    [self.view addSubview:_jiangdianView];
    
}

-(void)actionShaixuan:(UIButton*)btn{
    
    NSLog(@"%ld",btn.tag);
    //喜欢
    if (btn.tag >= 700 && btn.tag <= 702) {
        for (int i = 700; i < 703; i ++) {
            UIButton * subBtn = (UIButton*)[self.view viewWithTag:i];
            subBtn.selected = NO;
            [self StateNormalBtn:subBtn];
        }
        btn.selected = YES;
        [self StateSelectedBtn:btn];
        _btnTagindexXH  = btn.tag;
        
        
    }
    else if (btn.tag >= 800 && btn.tag <= 804)//分类
    {
        for (int i = 800; i < 805; i ++) {
            UIButton * subBtn = (UIButton*)[self.view viewWithTag:i];
            subBtn.selected = NO;
            [self StateNormalBtn:subBtn];
        }
        btn.selected = YES;
        [self StateSelectedBtn:btn];
        _btnTagindexFL  = btn.tag;

        
    }
    else if(btn.tag == 900){
        UIButton * btn2 = (UIButton*)[self.view viewWithTag:901];
        [self actionShaixuan:btn2];
        
        NSLog(@"喜欢%ld",_btnTagindexXH);
        NSLog(@"分类%ld",_btnTagindexFL);

        
    }
    else if(btn.tag == 901){
        _jiangdianView.hidden = YES;
        if (!_shaixuanView.hidden) {//隐藏
            if (_tableView.contentOffset.y > 100) {
                _daohanTiaoview.backgroundColor = [UIColor whiteColor];
                _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
            }
            else
            {
                _daohanTiaoview.backgroundColor = [UIColor clearColor];
                _daohanTiaoLineview.backgroundColor =[ UIColor clearColor];
            }
            _shaixuanView.hidden = YES;
            btn.selected = NO;
            
        }
        else
        {
//            [UIView animateWithDuration:1 animations:^{
//                _shaixuanView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
//                
//            }];
            _daohanTiaoview.backgroundColor = [UIColor whiteColor];
            _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
            _shaixuanView.hidden = NO;

        }
        
    }
    
    
    
    
    
}
-(void)btnview:(UIButton*)btn{
    ViewRadius(btn, 15);
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    btn.layer.borderWidth = 0.5;
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
}
-(void)StateSelectedBtn:(UIButton*)btn{
    
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    UIImageView * img = (UIImageView*)[_shaixuanView viewWithTag:btn.tag + 10];
    img.hidden = NO;

}
-(void)StateNormalBtn:(UIButton*)btn{
    
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    UIImageView * img = (UIImageView*)[_shaixuanView viewWithTag:btn.tag + 10];
    img.hidden = YES;


}


-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    _headwheel = [self headViewwheel:500];
    _tableView.tableHeaderView = [self addHeadView:_headwheel];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView addFooterWithTarget:self action:@selector(actionfooter)];
    [_tableView addHeaderWithTarget:self action:@selector(actionHeader)];
    _faBuBtn = [[UIButton alloc]initWithFrame:CGRectMake((Main_Screen_Width - 50)/2, Main_Screen_Height - 5 - 50, 50, 50)];
    [_faBuBtn setImage:[UIImage imageNamed:@"home_add_normal"] forState:UIControlStateNormal];
    [self.view addSubview:_faBuBtn];
    [_faBuBtn addTarget:self action:@selector(actionFabu) forControlEvents:UIControlEventTouchUpInside];
    
   // [_headwheel reloadData];
    [self preparedaohangtiao];
    [self loadData:YES];
    [self loadbanner];
}
#pragma mrak-上下拉
-(void)actionHeader{
    _pageStr = 1;
    [self loadData:NO];
}
-(void)actionfooter{
    _pageStr ++;
    [self loadData:NO];
    
}
-(void)preparedaohangtiao{
    
  _daohanTiaoview  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 64)];
    
    CGFloat x = 10;
    CGFloat y = 25;
    CGFloat width = 30;
    CGFloat height = 30;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [btn setBackgroundImage:[UIImage imageNamed:@"home_mine_avatar"] forState:0];
    [btn addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [_daohanTiaoview addSubview:btn];
    x += width + 15;
    width  =Main_Screen_Width - 2*x;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    bgView.backgroundColor =[UIColor blackColor];
    bgView.alpha = .4;
    ViewRadius(bgView, 15);
    [_daohanTiaoview addSubview:bgView];
    x += 10;
    y += 6.5;
    width  = 20;
    height = 20;
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    img.image = [UIImage imageNamed:@"ic_icon_search"];
    [_daohanTiaoview addSubview:img];
    x +=width + 5;
    y -=6.5;
    width = Main_Screen_Width - 2*x - 35;
    height = 30;
    _searchtext = [[MCplaceholderText alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _searchtext.placeholder = @"输入景点搜索";
    _searchtext.textColor  =[UIColor whiteColor];
    _searchtext.font = AppFont;
    _searchtext.delegate =self;
    [_searchtext addTarget:self action:@selector(actionText:) forControlEvents:UIControlEventEditingChanged];
    [_daohanTiaoview addSubview:_searchtext];
    x = Main_Screen_Width - 10 - 30;
    width = 30;
    height = 30;
    
    UIButton * _shaixuanBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_shaixuanBtn setImage:[UIImage imageNamed:@"home_mine_screened2"] forState:0];
    [_shaixuanBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    _shaixuanBtn.tag =  901;
    [_daohanTiaoview addSubview:_shaixuanBtn];
    _daohanTiaoLineview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 0.5)];
    _daohanTiaoLineview.backgroundColor = [UIColor clearColor];
    [_daohanTiaoview addSubview:_daohanTiaoLineview];
    [self.view addSubview:_daohanTiaoview];
    
    
    
}
#pragma mark-加载广告图
-(void)loadbanner{
    
    
    [self.requestManager requestWebWithParaWithURL:@"api/global/banner.json" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"guang游记==%@",resultDic);
        _bannerArray = resultDic[@"object"];
        
        
        [_headwheel reloadData];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
               NSLog(@"失败");
    }];
 
    
    
    
}
#pragma mark-加载数据
-(void)loadData:(BOOL)isjuhua{
    
    NSDictionary * Parameterdic = @{
                                    @"page":@(_pageStr),
                                    @"user_session":self.userSessionId
                                    
                                    };
    
    
    [self showLoading:isjuhua AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/query.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
       NSLog(@"返回游记==%@",resultDic);
        if (_pageStr == 1) {
            [_dataAarray removeAllObjects];
        }
        
        NSArray * objectArray = resultDic[@"object"];
        for (NSDictionary* dic in objectArray) {
            homeYJModel * model = [homeYJModel mj_objectWithKeyValues:dic];
           model.userModel = [YJUserModel mj_objectWithKeyValues:dic[@"user"]];
            NSLog(@"%@",model.userModel.isNew);
            
            [_dataAarray addObject:model];
        }
        
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [_tableView reloadData];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        NSLog(@"失败");
    }];

    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (!textField.text.length) {
        if (_tableView.contentOffset.y > 100) {
            _daohanTiaoview.backgroundColor = [UIColor whiteColor];
            _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
        }
        else
        {
            _daohanTiaoview.backgroundColor = [UIColor clearColor];
            _daohanTiaoLineview.backgroundColor =[ UIColor clearColor];
        }

        _jiangdianView.hidden = YES;
        
    }

    
}
-(void)actionText:(UITextField*)textField{
    _daohanTiaoview.backgroundColor = [UIColor whiteColor];
    _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
    _shaixuanView.hidden = YES;
    _jiangdianView.hidden = NO;
    NSLog(@"string%@",textField.text);
    
}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    _daohanTiaoview.backgroundColor = [UIColor whiteColor];
//    _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
//    _shaixuanView.hidden = YES;
//    _jiangdianView.hidden = NO;
//    NSLog(@"string%@",textField.text);
//    
//    return YES;
//    
//}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.text.length) {
        _shaixuanView.hidden = YES;
        _daohanTiaoview.backgroundColor = [UIColor whiteColor];
        _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
        _shaixuanView.hidden = YES;
        _jiangdianView.hidden = NO;
        NSLog(@"string%@",textField.text);
        

    }
    
    
}
-(void)jingdianStr:(NSString *)str{
    _searchtext.text = str;
    [_searchtext resignFirstResponder];
    if (_tableView.contentOffset.y > 100) {
        _daohanTiaoview.backgroundColor = [UIColor whiteColor];
        _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
    }
    else
    {
        _daohanTiaoview.backgroundColor = [UIColor clearColor];
        _daohanTiaoLineview.backgroundColor =[ UIColor clearColor];
    }
    
    _jiangdianView.hidden = YES;
    
    
}
#pragma mark-监听
- (void)didSelectObj:(NSNotification *)notication
{
    NSLog(@"%@",notication);
    
    //取值
    NSString *reveiveString = notication.object;
    
    NSLog(@"%@",reveiveString);
    if ([reveiveString isEqualToString:@"1"]) {
        zuopinViewController * ctl = [[zuopinViewController alloc]init];
        ctl.SegmentIndex = 0;
        [self pushNewViewController:ctl];
    }
    if ([reveiveString isEqualToString:@"2"]) {
        zuopinViewController * ctl = [[zuopinViewController alloc]init];
        ctl.SegmentIndex = 1;
        [self pushNewViewController:ctl];
    }

//    if([reveiveString isEqualToString:@"登录"]){
//        LoginUIViewController * ctl = [[LoginUIViewController alloc]init];
//        [self pushNewViewController:ctl];
//    }
//    else if ([reveiveString isEqualToString:@"我的资料"]){
//        MeCompanyViewController * ctl = [[MeCompanyViewController alloc]init];
//#warning 个人
//        // MeDataViewController * ctl = [[MeDataViewController alloc]init];
//        [self pushNewViewController:ctl];
//    }
//    
    
}
-(void)dishuaxinObj:(NSNotification*)notication{
    _pageStr = 0;
    [self loadData:NO];
}
#pragma mark-发布
-(void)actionFabu{
    zhizuoZP1ViewController * ctl = [[zhizuoZP1ViewController alloc]init];
    [self pushNewViewController:ctl];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _faBuBtn.hidden = YES;
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    NSLog(@"wqe");
    _faBuBtn.hidden = NO;
    NSLog(@"%f",_tableView.contentOffset.y );
    
    if (scrollView == _tableView) {
        if (_tableView.contentOffset.y > 100) {
            [UIView animateWithDuration:1 animations:^{
                _daohanTiaoview.backgroundColor = [UIColor whiteColor];
                _daohanTiaoLineview.backgroundColor = [UIColor lightGrayColor];
            }];
            
            
        }
        else
        {
            
            
            [UIView animateWithDuration:1 animations:^{
                _daohanTiaoview.backgroundColor = [UIColor clearColor];
                _daohanTiaoLineview.backgroundColor = [UIColor clearColor];
                
            }];
            
        }
    }
    

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _dataAarray.count;
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
    static NSString *cellid1 = @"HomeTableViewCell";
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLbl1.textColor = AppTextCOLOR;
    cell.title2Lb.textColor = AppTextCOLOR;
    cell.dingweiimg.textColor = [UIColor grayColor];
    cell.nameLbl.textColor = [UIColor grayColor];
    ViewRadius(cell.headImg, 20);
    cell.headImg.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.headImg.layer.borderWidth = 1.5;
    if (_dataAarray.count > indexPath.section) {
        homeYJModel * model = _dataAarray[indexPath.section];
      //  NSMutableDictionary * model = _dataAarray[indexPath.section];
        //NSLog(@">>>>>>%@", model.title);
     
    //title
    if (model.title.length > 9) {//第一行大概9个字
        cell.titleLbl1.text = [model.title substringToIndex:9];
        cell.title2Lb.text = [model.title substringFromIndex:9];
        
    }
    else
    {
        cell.titleLbl1.text = model.title;
        cell.title2Lb.text = @"";
        
    }
        
        //photos

        if ([model.photos count]) {
            NSString * str = [NSString stringWithFormat:@"%@",model.photos[0][@"thumbnail"]];
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"travels-details_default-chart04"]];
        }
        
        //头像
        if(model.userModel.thumbnail)
        {
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:model.userModel.thumbnail] placeholderImage:[UIImage imageNamed:@"home_default-avatar"]];
            
        }
        //姓名
        if (model.userModel.nickname) {
            cell.nameLbl.text = model.userModel.nickname;
        }
        else
        {
           cell.nameLbl.text = @"游客";
        }
         
        
        //游记类型
        //NSLog(@">>>>%@",[self.classifyDic objectForKey:model[@"classify"]]);
        cell.typeLimgView.image  = [UIImage imageNamed:[self.classifyDic objectForKey:[NSString stringWithFormat:@"%ld",model.classify]]];
        
        NSLog(@"<<<<<%@",[NSString stringWithFormat:@"%ld",model.classify]);
        
        
        //游记推荐
        BOOL isRecommend = [model.isRecommend boolValue];
        cell.tuijianimg.hidden = !isRecommend;
        

    
    }
    
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    homeYJModel * model = _dataAarray[indexPath.section];

    zuopinXQViewController * ctl = [[zuopinXQViewController alloc]init];
    ctl.home_model = model;
    ctl.dataArray = _dataAarray;
    ctl.index = indexPath.section;
    [self pushNewViewController:ctl];
}
#pragma mark-添加广告头
-(UIView*)addHeadView:(ZZCarousel*)zzcarView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200 )];
    [view addSubview:zzcarView];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView * lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 120, Main_Screen_Width, 0.5)];
    lineView.backgroundColor =[UIColor lightGrayColor];
        return view;
}

#pragma mark-ZZCarousel
-(ZZCarousel*)headViewwheel:(NSInteger)tag{
    ZZCarousel* wheel  = [[ZZCarousel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200)];
    wheel.tag = tag;
    /*
     *   carouseScrollTimeInterval  ---  此属性为设置轮播多长时间滚动到下一张
     */
    wheel.carouseScrollTimeInterval = 5.0f;
    
    
    
    // 代理
    wheel.delegate = self;
    
    /*
     *   isAutoScroll  ---  默认为NO，当为YES时 才能使轮播进行滚动
     */
    wheel.isAutoScroll = YES;
    
    /*
     *   pageType  ---  设置轮播样式 默认为系统样式。ZZCarousel 中封装了 两种样式，另外一种为数字样式
     */
    wheel.pageType = ZZCarouselPageTypeOfNone;
    
    /*
     *   设置UIPageControl 在轮播中的位置、系统默认的UIPageControl 的顶层颜色 和底层颜色已经背景颜色
     */
        wheel.pageControlFrame = CGRectMake((Main_Screen_Width - 60 ) / 2, wheel.frame.size.height - 20, 60, 10);
    
    
    wheel.pageIndicatorTintColor = RGBCOLOR(250, 150, 110);//[UIColor whiteColor];
    wheel.currentPageIndicatorTintColor = RGBCOLOR(251, 78, 9);
    wheel.pageControlBackGroundColor = [UIColor whiteColor];
    
    /*
     *   设置数字样式的 UIPageControl 中的字体和字体颜色。 背景颜色仍然按照上面pageControlBackGroundColor属性来设置
     */
    wheel.pageControlOfNumberFont = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    wheel.pageContolOfNumberFontColor = [UIColor whiteColor];
    //[view addSubview:wheel];
    
    return  wheel;
    
}
#pragma mark --- ZZCarouselDelegate


-(NSInteger)numberOfZZCarousel:(ZZCarousel *)wheel
{
    if (_bannerArray.count) {
        return _bannerArray.count;
    }
    return 3;
}
-(ZZCarouselView *)zzcarousel:(UICollectionView *)zzcarousel viewForItemAtIndex:(NSIndexPath *)index itemsIndex:(NSInteger)itemsIndex identifire:(NSString *)identifire ZZCarousel:(ZZCarousel *)zZCarousel
{
    /*
     *  index参数         ※ 注意
     */
    ZZCarouselView *cell = [zzcarousel dequeueReusableCellWithReuseIdentifier:identifire forIndexPath:index];
    
    if (!cell) {
        cell = [[ZZCarouselView alloc]init];
    }
    //    cell.title.text = [_imagesGroup objectAtIndex:indexPath.row];
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"图片地址"]];
    
    /*
     *  itemsIndex 参数   ※ 注意
     */
    if (_bannerArray.count) {
        NSDictionary * model = [_bannerArray objectAtIndex:itemsIndex];
        
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model[@"image"]] placeholderImage:[UIImage imageNamed:@"home_banner_default-chart"]];
    }
    else
   
    cell.imageView.image = [UIImage imageNamed:@"home_banner_default-chart"];
//    
    
    return cell;
}

//点击方法

-(void)zzcarouselScrollView:(ZZCarousel *)zzcarouselScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    //[self showAllTextDialog:[NSString stringWithFormat:@"点击了 第%ld张",(long)index]];
    
    
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
