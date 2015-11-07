//
//  zuopinDataViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinDataViewController.h"
#import "UIButton+WebCache.h"
#import "zuopinQxTableViewCell.h"
#import "zuopinQx2TableViewCell.h"
#import "zuopinQx3TableViewCell.h"

@interface zuopinDataViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    RGFadeView * rgFadeView;
    
    
    
}

@end

@implementation zuopinDataViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (rgFadeView) {
        [rgFadeView removeFromSuperview];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(40, 0, Main_Screen_Width - 80, Main_Screen_Height ) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate= self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = [self addHeadView:4];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self.view addSubview:_tableView];
    
    
    
    
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120, 10, 80, 80)];
//    view2.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view2];
    
    
    
    

}
-(UIView*)addHeadView:(NSInteger)indexCount{
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 80, Main_Screen_Width - 80 + 60)];
    
    UIView *imgbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, Main_Screen_Width - 80, Main_Screen_Width - 80)];
    
    [bgview addSubview:imgbgView];
    
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imgbgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = imgbgView.bounds;
        maskLayer.path = maskPath.CGPath;
        imgbgView.layer.mask = maskLayer;
    
    
    
    CGRect imgfram;
    if (indexCount == 1) {
        imgfram = CGRectMake(0, 0, Main_Screen_Width - 80, Main_Screen_Width - 80);
     UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart01" ImgUrlStr:@""];
        imgView.tag = 400;
        [imgbgView addSubview:imgView];
    }
    else if(indexCount == 2){
        
        for (int  i = 0; i < 2 ; i++) {
            
            imgfram = CGRectMake(((Main_Screen_Width - 80 - 2)/2 + 2) *i, 0, (Main_Screen_Width - 80 - 2)/2, Main_Screen_Width - 80);
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart02" ImgUrlStr:@""];
            imgView.tag = 400 +i;
            [imgbgView addSubview:imgView];
            
        }
        
    }
    else if(indexCount == 3){
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = (Main_Screen_Width- 2 - 80)/2;
        CGFloat height = Main_Screen_Width - 80;
        for (int  i = 0; i < 3 ; i++) {
            
            imgfram = CGRectMake(x, y, width, height);
            if (i==0) {
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart02" ImgUrlStr:@""];
            [imgbgView addSubview:imgView];
                x +=width + 2;
                height = (height-2)/2;
                imgView.tag = 400 +i;
            }
            else
            {
                UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_banner_default-chart" ImgUrlStr:@""];
                imgView.tag = 400 +i;
                [imgbgView addSubview:imgView];
                if (i == 1) {
                    y += height + 2;
                }
                
            }
            
        }
    }
    else if(indexCount == 4){
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = (Main_Screen_Width- 2 - 80)/2;
        CGFloat height = (Main_Screen_Width - 80 - 2) / 2;
        for (int  i = 0; i < 4 ; i++) {
            
            imgfram = CGRectMake(x, y, width, height);
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_banner_default-chart" ImgUrlStr:@""];
            imgView.tag = 400 +i;
            [imgbgView addSubview:imgView];
            x += width + 2;
            if (i == 1) {
                y += height + 2;
                x = 0;
            }
            
        }
 
    }
    return bgview;

}
-(UIButton*)addImgView:(CGRect)imgFrame ImgStr:(NSString*)imgStr ImgUrlStr:(NSString*)imgUrlStr{
    UIButton * imgView = [[UIButton alloc]initWithFrame:imgFrame];
    [imgView sd_setBackgroundImageWithURL:[NSURL URLWithString:imgUrlStr] forState:0 placeholderImage:[UIImage imageNamed:imgStr]];
    
    return imgView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (section == 0) {
        return 1;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat h = [MCIucencyView heightforString:@"王企鹅王企鹅王企鹅王企鹅王企鹅请问请问去问问企鹅我去" andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
        
        return 85 + h + 55;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0)
        return 44;
        else
        {
               CGFloat h = [MCIucencyView heightforString:@"王企鹅王企鹅王企鹅王企鹅王企鹅请问请问去问问企鹅我去" andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
            
            return h + 38 + 10;
            //38
        }
    }
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static  NSString * cellid1 = @"mc1";
    if (indexPath.section==0) {
        zuopinQxTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[zuopinQxTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataStr = @"王企鹅王企鹅王企鹅王企鹅王企鹅请问请问去问问企鹅我去";
        
        
        CGFloat h = [MCIucencyView heightforString:@"王企鹅王企鹅王企鹅王企鹅王企鹅请问请问去问问企鹅我去" andWidth:Main_Screen_Width - 80 - 30 fontSize:13];

        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Main_Screen_Width - 80, 85 + h + 55) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =CGRectMake(0, 0, Main_Screen_Width - 80, 85 + h + 55);
        maskLayer.path = maskPath.CGPath;
        cell.layer.mask = maskLayer;

        return cell;
    }
    else if(indexPath.section == 1)
    {
        static NSString * cellid2 = @"zuopinQx2TableViewCell";
        static NSString * cellid3 = @"zuopinQx3TableViewCell";

        if (indexPath.row == 0) {
            zuopinQx2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid2 owner:self options:nil]lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            [cell.pinglunBtn addTarget:self action:@selector(ActionPinjia:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            
            
            
            
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame =cell.bounds;
            maskLayer.path = maskPath.CGPath;
            cell.layer.mask = maskLayer;
            return cell;
        }
        else
        {
            zuopinQx3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
            if (!cell) {
                cell = [[zuopinQx3TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.titleStr = @"王企鹅王企鹅王企鹅王企鹅王企鹅请问请问去问问企鹅我去";
            
            
            if (indexPath.row == 10 -1) {
                CGFloat h = [MCIucencyView heightforString:@"王企鹅王企鹅王企鹅王企鹅王企鹅请问请问去问问企鹅我去" andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
                
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 10) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame =CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 10);
                maskLayer.path = maskPath.CGPath;
                cell.layer.mask = maskLayer;
                

            }
            else
            {
                CGFloat h = [MCIucencyView heightforString:@"王企鹅王企鹅王企鹅王企鹅王企鹅请问请问去问问企鹅我去" andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
                
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 10) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(0, 0)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame =CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 10);
                maskLayer.path = maskPath.CGPath;
                cell.layer.mask = maskLayer;
 
            }
            
            return cell;
        }
    }
    
    return [[UITableViewCell alloc]init];
}
#pragma mark-评价
-(void)ActionPinjia:(UIButton*)btn{
    
    if (!rgFadeView) {
        rgFadeView = [[RGFadeView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        [self.view addSubview:rgFadeView];
    }
    rgFadeView.placeLabel.text = @"请输入评论信息";
    [rgFadeView.msgTextView becomeFirstResponder];

    
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
