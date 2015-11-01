//
//  zuopinViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/1.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinViewController.h"
#import "HMSegmentedControl.h"
#import "MyshouchangViewController.h"
#import "MyzuopinViewController.h"
@interface zuopinViewController ()<UIScrollViewDelegate>
{
    
    HMSegmentedControl *titleSegment;
    MyshouchangViewController *_myshouchangCtl;
    
    MyzuopinViewController * _myzuopinCtl;
    
    NSInteger _isBianji;
    
}

@end

@implementation zuopinViewController
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
    self.title = @"作品";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _isBianji = 3;
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    [self addAllSelect];
    //    添加滚动
    [self addScrollView];
    [self addMyzuopin];
    [self addMyshouchang];
    
    
    
    
}
-(void)addMyshouchang{
    _myshouchangCtl = [[MyshouchangViewController alloc]init];
     [self.mainScroll addSubview:_myshouchangCtl.view];
}
-(void)addMyzuopin{
    _myzuopinCtl = [[MyzuopinViewController alloc]init];
    [self.mainScroll addSubview:_myzuopinCtl.view];
    
}
-(void)addAllSelect{
    //选择框
    titleSegment = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    titleSegment.sectionTitles = @[@"已制作的作品", @"我收藏的作品"];
    titleSegment.selectedSegmentIndex = _SegmentIndex;
    if (_SegmentIndex> 0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(bianjiBtn)];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }

    titleSegment.backgroundColor = [UIColor whiteColor];
    titleSegment.textColor = [UIColor grayColor];
    titleSegment.selectedTextColor = AppCOLOR;
    titleSegment.font = [UIFont systemFontOfSize:16];
    titleSegment.selectionIndicatorColor = AppCOLOR;//[UIColor colorWithPatternImage:[UIImage imageNamed:@"red_line_tap"]];
    //titleSegment.selectionIndicatorHeight = 3;
    titleSegment.selectionStyle = HMSegmentedControlSelectionStyleArrow;
    titleSegment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    [self.view addSubview:titleSegment];
    __weak typeof(self) weakSelf = self;
    __block typeof(NSInteger) weakisBianji = _isBianji;

    [titleSegment setIndexChangeBlock:^(NSInteger index) {
        
        weakSelf.mainScroll.contentOffset =CGPointMake(index * Main_Screen_Width, 0);
        if (index== 1) {
            weakSelf.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:weakSelf action:@selector(bianjiBtn)];
            if (_isBianji == 1) {
                //weakisBianji = 0;
                
                weakSelf.navigationItem.rightBarButtonItem.title =  @"完成";}
            
            else if(_isBianji == 0 )
            {
                //weakisBianji = 1;
                
                weakSelf.navigationItem.rightBarButtonItem.title =  @"编辑";
                
            }
            
           // NSLog(@"%ld",_isBianji);
        }
        else
        {
            weakSelf.navigationItem.rightBarButtonItem = nil;
        }
        
        
    }];
    
    //
}
- (void)addScrollView
{
    //中间View
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44 + 64, Main_Screen_Width, Main_Screen_Height - 44 - 64)];
    self.mainScroll.contentSize = CGSizeMake(Main_Screen_Width * 2, 0);
    //self.mainScroll.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    _mainScroll.contentOffset = CGPointMake(Main_Screen_Width * _SegmentIndex, 0);
    self.mainScroll.delegate = self;
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    self.mainScroll.bounces = NO;
    [self.view addSubview:self.mainScroll];
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    [titleSegment setSelectedSegmentIndex:page animated:YES];
    if (page> 0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(bianjiBtn)];
        if (_isBianji == 1) {
           // _isBianji = 0;
            self.navigationItem.rightBarButtonItem.title =  @"完成";}
        else if(_isBianji == 0)
        {
            //_isBianji = 1;
            self.navigationItem.rightBarButtonItem.title =  @"编辑";
            
        }

    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-编辑
-(void)bianjiBtn{
    if (_isBianji== 1) {
        _isBianji = 0;
        self.navigationItem.rightBarButtonItem.title =  @"编辑";//[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(bianjiBtn)];
        [_myshouchangCtl actionBianji];
    }
    else
    {
        _isBianji = 1;
       self.navigationItem.rightBarButtonItem.title =  @"完成";
        [_myshouchangCtl actionBianji];

    }
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
