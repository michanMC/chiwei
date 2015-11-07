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

#import "zhizuoZP1ViewController.h"
@interface DEMOHomeViewController ()<ZZCarouselDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    UITableView * _tableView;
    ZZCarousel *_headwheel;//广告图
    MCplaceholderText *_searchtext;
    UIButton * _faBuBtn;
}

@end

@implementation DEMOHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectObj:) name:@"didSelectObjNotification" object:nil];
	self.title = @"Home Controller";
    
    [self prepareUI];
    return;
    
//    self.view.backgroundColor = [UIColor yellowColor];
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 30, 30)];
//    btn.backgroundColor =[UIColor redColor];
//    [btn addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    _headwheel = [self headViewwheel:500];
    _tableView.tableHeaderView = [self addHeadView:_headwheel];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _faBuBtn = [[UIButton alloc]initWithFrame:CGRectMake((Main_Screen_Width - 50)/2, Main_Screen_Height - 5 - 50, 50, 50)];
    [_faBuBtn setImage:[UIImage imageNamed:@"home_add_normal"] forState:UIControlStateNormal];
    [self.view addSubview:_faBuBtn];
    [_faBuBtn addTarget:self action:@selector(actionFabu) forControlEvents:UIControlEventTouchUpInside];
    
    [_headwheel reloadData];
    
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
#pragma mark-发布
-(void)actionFabu{
    zhizuoZP1ViewController * ctl = [[zhizuoZP1ViewController alloc]init];
    [self pushNewViewController:ctl];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _faBuBtn.hidden = YES;
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _faBuBtn.hidden = NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    zuopinXQViewController * ctl = [[zuopinXQViewController alloc]init];
    [self pushNewViewController:ctl];
}
#pragma mark-添加广告头
-(UIView*)addHeadView:(ZZCarousel*)zzcarView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200 )];
    [view addSubview:zzcarView];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView * lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 120, Main_Screen_Width, 0.5)];
    lineView.backgroundColor =[UIColor lightGrayColor];
    
    CGFloat x = 10;
    CGFloat y = 25;
    CGFloat width = 30;
    CGFloat height = 30;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [btn setBackgroundImage:[UIImage imageNamed:@"home_mine_avatar"] forState:0];
    [btn addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    x += width + 15;
    width  =Main_Screen_Width - 2*x;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    bgView.backgroundColor =[UIColor blackColor];
    bgView.alpha = .4;
    ViewRadius(bgView, 15);
    [view addSubview:bgView];
    x += 10;
    y += 6.5;
    width  = 20;
    height = 20;
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    img.image = [UIImage imageNamed:@"ic_icon_search"];
    [view addSubview:img];
    x +=width + 5;
    y -=6.5;
    width = Main_Screen_Width - 2*x - 35;
    height = 30;
    _searchtext = [[MCplaceholderText alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _searchtext.placeholder = @"输入景点搜索";
    _searchtext.textColor  =[UIColor whiteColor];
    _searchtext.font = AppFont;

    [view addSubview:_searchtext];
    x = Main_Screen_Width - 10 - 30;
    width = 30;
    height = 30;
    
    UIButton * _shaixuanBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_shaixuanBtn setImage:[UIImage imageNamed:@"home_mine_screened2"] forState:0];
    [view addSubview:_shaixuanBtn];
    
    
    
    
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
//     msgadlist * model = [homemodel.msgadlistArray objectAtIndex:itemsIndex];
//     [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.adpicurl] placeholderImage:[UIImage imageNamed:@"home_moRenTuPian"]];
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
