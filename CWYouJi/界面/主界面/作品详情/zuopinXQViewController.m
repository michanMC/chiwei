//
//  zuopinXQViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinXQViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "DMLazyScrollView.h"
#import "zuopinDataViewController.h"
#import "HZPhotoBrowser.h"
#define ARC4RANDOM_MAX	0x100000000

@interface zuopinXQViewController ()<UITableViewDataSource,UITableViewDelegate,DMLazyScrollViewDelegate,HZPhotoBrowserDelegate>
{
    DMLazyScrollView* _lazyScrollView;

    UIButton * _backBtn;
    UILabel *_titleLbl;
    NSMutableArray*   _viewControllerArray;

    
}



@property(nonatomic,strong)UIImageView *imgview;

@end

@implementation zuopinXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectjubaoObj:) name:@"didjubaoObjNotification" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didshowTupianjubaoObj:) name:@"didshowObjNotification" object:nil];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
//举报
-(void)didSelectjubaoObj:(NSNotification*)Notification{
    jubaoViewController * ctl = [[jubaoViewController alloc]init];
    [self pushNewViewController:ctl];
    //[self.navigationController presentViewController:ctl animated:YES completion:nil];
   
    
}
#pragma mark-浏览图片监听
-(void)didshowTupianjubaoObj:(NSNotification*)Notification{
    
    NSLog(@"%@",Notification.object);
    NSInteger index = [Notification.object integerValue] - 400;
    
    //启动图片浏览器
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self.view; // 原图的父控件
    browserVc.imageCount = 4; // 图片总数
    browserVc.currentImageIndex =(int)index;
    browserVc.delegate = self;
    [browserVc show];

}
#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [UIImage imageNamed:@"login_bg_720"];
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
   // NSString * imgurl = [NSString stringWithFormat:@"%@%@",AppURL,imgArray[index]];
    
    return [NSURL URLWithString:@""];
}


-(void)prepareUI{
     _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [self.view addSubview:_imgview];
    
    [self.imgview setImageToBlur:[UIImage imageNamed:@"login_bg_720"]
                      blurRadius:kLBBlurredImageDefaultBlurRadius
                 completionBlock:^(){
                     NSLog(@"The blurred image has been set");
                 }];
    
    NSUInteger numberOfPages = 10;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [_viewControllerArray addObject:[NSNull null]];
    }
    
    // PREPARE LAZY VIEW
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:rect];
    [_lazyScrollView setEnableCircularScroll:YES];
   // [_lazyScrollView setAutoPlay:YES];
    
    __weak __typeof(&*self)weakSelf = self;
    
    _lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    _lazyScrollView.numberOfPages = numberOfPages;
    // lazyScrollView.controlDelegate = self;
    [self.view addSubview:_lazyScrollView];

    
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 23, 35, 35)];
    [_backBtn setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    [self.view addSubview:_backBtn];
    [_backBtn addTarget:self action:@selector(actionBackBtn) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    
}
- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        zuopinDataViewController *contr = [[zuopinDataViewController alloc] init];
//        contr.view.backgroundColor = [UIColor colorWithRed: (CGFloat)arc4random()/ARC4RANDOM_MAX
//                                                     green: (CGFloat)arc4random()/ARC4RANDOM_MAX
//                                                      blue: (CGFloat)arc4random()/ARC4RANDOM_MAX
//                                                     alpha: 1.0f];
        
        UILabel* label = [[UILabel alloc] initWithFrame:contr.view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%d",index];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:50];
        [contr.view addSubview:label];
        
        [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
        return contr;
    }
    return res;
}

#pragma mark-返回
-(void)actionBackBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
