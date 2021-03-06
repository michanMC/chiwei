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
#import "homeYJModel.h"
#import "fenxianView.h"
@interface zuopinXQViewController ()<UITableViewDataSource,UITableViewDelegate,DMLazyScrollViewDelegate,HZPhotoBrowserDelegate>
{
    DMLazyScrollView* _lazyScrollView;

    UIButton * _backBtn;
    UIButton * _fenxianBtn;

    UILabel *_titleLbl;
    NSMutableArray*   _viewControllerArray;

    
}



@property(nonatomic,strong)UIImageView *imgview;

@end

@implementation zuopinXQViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectjubaoObj:) name:@"didjubaoObjNotification" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didshowTupianjubaoObj:) name:@"didshowObjNotification" object:nil];

        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
#pragma mark- 举报
-(void)didSelectjubaoObj:(NSNotification*)Notification{
    NSString * youjiid = Notification.object;
    
    jubaoViewController * ctl = [[jubaoViewController alloc]init];
    ctl._youjiId = youjiid;
    [self pushNewViewController:ctl];
    //[self.navigationController presentViewController:ctl animated:YES completion:nil];
   
    
}
#pragma mark-浏览图片监听
-(void)didshowTupianjubaoObj:(NSNotification*)Notification{
    
  //  NSLog(@"%@",Notification.object);
    NSInteger index = [Notification.object integerValue] - 400;
    
    //启动图片浏览器
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self.view; // 原图的父控件
    NSLog(@"===%ld",_index);
    homeYJModel * model = _dataArray[_index];
    NSLog(@"---------%ld",model.photos.count);
    browserVc.imageCount = model.photos.count; // 图片总数
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
    homeYJModel * model =_dataArray[_index];
    if (model.photos.count) {
        
        NSString * imgurl = model.photos[index][@"raw"];//[NSString stringWithFormat:@"%@%@",];
    
   return [NSURL URLWithString:[NSString stringWithFormat:@"%@",imgurl]];
    }
    return [NSURL URLWithString:@""];
}


-(void)prepareUI{
     _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [self.view addSubview:_imgview];
//    if (_home_model.photos.count) {
//        NSDictionary * img = _home_model.photos[0];
//    
    [self.imgview setImageToBlur:[UIImage imageNamed:@"login_bg_720"] Url:@""
                      blurRadius:kLBBlurredImageDefaultBlurRadius
                 completionBlock:^(){
                     NSLog(@"The blurred image has been set");
                 }];
   // }
    
    NSUInteger numberOfPages = _dataArray.count;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [_viewControllerArray addObject:[NSNull null]];
    }
    
    // PREPARE LAZY VIEW
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:rect];
    //_lazyScrollView.currentPage = _index;
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
    
    _fenxianBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 35 - 10, 23, 35, 35)];
    [_fenxianBtn setImage:[UIImage imageNamed:@"nav_icon_share"] forState:UIControlStateNormal];
    [self.view addSubview:_fenxianBtn];
    [_fenxianBtn addTarget:self action:@selector(action_Fenxian:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    /*
    [_fenxianBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
       
        NSLog(@"%d",_index);
      
        fenxianView *shareView = [fenxianView createViewFromNib];
        shareView.backgroundColor = [UIColor clearColor];
        
        shareView.titleLbl.textColor = AppTextCOLOR;
        ViewRadius(shareView.bgView, 5);
        
        
        [shareView.deleBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            
           // [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }];
        [shareView.weibobtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
           // [self actionFenxian:SSDKPlatformTypeSinaWeibo];
            //[self.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"微博");
        }];
        [shareView.qqbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            //[self actionFenxian:SSDKPlatformTypeQQ];
            //[self.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"QQ");
        }];
        [shareView.weixinbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
           // [self actionFenxian:SSDKPlatformTypeWechat];
          //  [self.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"weixin");
        }];
        [shareView.tubtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            //[self actionFenxian:SSDKPlatformTypeDouBan];
            //[self.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"土豆");
        }];
        [shareView showInWindow];

        
       // NSLog(@"%@",_dataArray[])
        
     
        
    }];

    */
    
    
}
-(void)action_Fenxian:(UIButton*)btn{
    
    
    fenxianView *shareView = [fenxianView createViewFromNib];
    shareView.backgroundColor = [UIColor clearColor];
    
    shareView.titleLbl.textColor = AppTextCOLOR;
    ViewRadius(shareView.bgView, 5);
    
    
    [shareView.deleBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [shareView hideView];
        
        // [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }];
    [shareView.weibobtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [shareView hideView];
        [self actionFenxian:SSDKPlatformTypeSinaWeibo];
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"微博");
    }];
    [shareView.qqbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [shareView hideView];
        [self actionFenxian:SSDKPlatformTypeQQ];
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"QQ");
    }];
    [shareView.weixinbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [shareView hideView];
         [self actionFenxian:SSDKPlatformTypeWechat];
          [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"weixin");
    }];
    [shareView.tubtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [shareView hideView];
        [self actionFenxian:SSDKPlatformTypeDouBan];
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"土豆");
    }];
    [shareView showInWindow];
    
    
    // NSLog(@"%@",_dataArray[])
    

    
    
}
- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
   
    
    if (res == [NSNull null]) {
        zuopinDataViewController *contr = [[zuopinDataViewController alloc] init];
        homeYJModel * model = _dataArray[index];
        //NSLog(@"%@",model.collection);
        
        
        contr.home_model = model;//_dataArray[index];
        
        UILabel* label = [[UILabel alloc] initWithFrame:contr.view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%d",index];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:50];
       // [contr.view addSubview:label];
        
        [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
        [_lazyScrollView setPage:_index animated:YES];
        if (index == _dataArray.count - 1) {
            NSLog(@">>>>>>%ld",_lazyScrollView.currentPage);
            _index = _lazyScrollView.currentPage;
            
//            if (model.photos.count) {
//                NSDictionary * img = model.photos[0];
//                        UIImageView *imgView_bg = [[UIImageView alloc]init];
//                        [imgView_bg sd_setImageWithURL:[NSURL URLWithString:img[@"raw"]] placeholderImage:[UIImage imageNamed:@"login_bg_720"]];
//                
//                [self.imgview setImageToBlur:imgView_bg.image Url:img[@"raw"]
//                                  blurRadius:kLBBlurredImageDefaultBlurRadius
//                             completionBlock:^(){
//                                 NSLog(@"The blurred image has been set");
//                             }];
//                
//                
//            }
//
        }
        return contr;
    }
     NSLog(@">>>>>>%ld",_lazyScrollView.currentPage);
    _index = _lazyScrollView.currentPage;
    homeYJModel * model = _dataArray[_index];
//    if (model.photos.count) {
//                    NSDictionary * img = model.photos[0];
//        UIImageView *imgView_bg = [[UIImageView alloc]init];
//        [imgView_bg sd_setImageWithURL:[NSURL URLWithString:img[@"raw"]] placeholderImage:[UIImage imageNamed:@"login_bg_720"]];
//        
//        [self.imgview setImageToBlur:imgView_bg.image Url:img[@"raw"]
//                          blurRadius:kLBBlurredImageDefaultBlurRadius
//                     completionBlock:^(){
//                         NSLog(@"The blurred image has been set");
//                     }];
//
//        
//                }

    
    
    
//    else
//    {
//        _index = index;
//
//
//        if (model.photos.count) {
//            NSDictionary * img = model.photos[0];
//            [self.imgview sd_setImageWithURL:[NSURL URLWithString:img[@"raw"]] placeholderImage:[UIImage imageNamed:@"login_bg_720"]];
//            
//        }
//
//        
//    }
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
