//
//  HomeTableViewCell.m
//  CWYouJi
//
//  Created by MC on 15/10/31.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "Home2TableViewCell.h"



@interface Home2TableViewCell (){
    
    UIImageView * _bgimgView;
    UIImageView *_imgView;
    UIImageView *_headimgView;
    UIImageView *_leixingView;
    UIImageView *_tuijianView;

    UILabel *_titleLbl;
    UILabel *_title2Lbl;
    UILabel *_dingweiLbl;
    UILabel *_nameLbl;

    
}

@end


@implementation Home2TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,(150-30)/2, 30, 30)];
        [_deleteBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
        [self.contentView addSubview:_deleteBtn];

        
        
        CGFloat x = 10;
        CGFloat y = 1;
        CGFloat width = Main_Screen_Width - 20;
        CGFloat height = 148;
        
        _bgimgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _bgimgView.image = [UIImage imageNamed:@"home_list_bg"];
        [self.contentView addSubview:_bgimgView];
        
        x = 10;
        y = 10;
        width = 100;
        height = 100;
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _imgView.image =[UIImage imageNamed:@"travels-details_default-chart04"];
        [_bgimgView addSubview:_imgView];
        
        y = 97;
        width = 40;
        height = width;
        _headimgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _headimgView.image = [UIImage imageNamed:@"home_default-avatar"];
        ViewRadius(_headimgView, 20);
        _headimgView.layer.borderColor = [UIColor whiteColor].CGColor;
        _headimgView.layer.borderWidth = 1.0;
        [_bgimgView addSubview:_headimgView];
        
        x = 58;
        y = 112;
        width = 130;
        height = 20;
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _nameLbl.text = @"michan";
        _nameLbl.textColor = [UIColor grayColor];
        _nameLbl.font = AppFont;
        [_bgimgView addSubview:_nameLbl];
        
        
        x = 125;
        y = 10;
        width = 163;
        height = 20;
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _titleLbl.textColor = AppTextCOLOR;
        _titleLbl.text = @"比马里亚纳";
        _titleLbl.font = [UIFont systemFontOfSize:15];
        [_bgimgView addSubview:_titleLbl];
        
        
        y += height + 10;
        _title2Lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _title2Lbl.textColor = AppTextCOLOR;
        _title2Lbl.text = @"一西太平洋的新海角";
        _title2Lbl.font = [UIFont systemFontOfSize:14];
        [_bgimgView addSubview:_title2Lbl];

        y += height + 5;
        width = 25;
        height = width;
        _leixingView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _leixingView.image =[UIImage imageNamed:@"食"];
        [_bgimgView addSubview:_leixingView];
        
        
        x +=width +5;
        _tuijianView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _tuijianView.image = [UIImage imageNamed:@"荐"];
        [_bgimgView addSubview:_tuijianView];
        
        
        x = 123;
        y += height + 8;
        width = 20;
        height = 20;
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        img.image = [UIImage imageNamed:@"home_icon_map"];
        [_bgimgView addSubview:img];
        
        x += width;
        width = 93;
        _dingweiLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _dingweiLbl.text=  @"中国广州";
        _dingweiLbl.textColor =[UIColor grayColor];
        _dingweiLbl.font =[UIFont systemFontOfSize:14];
        [_bgimgView addSubview:_dingweiLbl];
        
        x += width + 20;
        width = 22;
        height = 20;
        img =[[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        img.image =[UIImage imageNamed:@"home_icon_comment"];
        [_bgimgView addSubview:img];
        
        
        
    }
    
    return self;
    
}
-(void)setIsEit:(BOOL)isEit
{
    if (isEit) {
        _bgimgView.frame = CGRectMake(60, 1, Main_Screen_Width - 20, 148);
    }
    else
    {
        _bgimgView.frame = CGRectMake(10, 1, Main_Screen_Width - 20, 148);

    }
}
-(void)setTitleStr:(NSString *)titleStr
{
    _titleLbl.text = titleStr;
}
-(void)setTitle2Str:(NSString *)title2Str
{
    _title2Lbl.text = title2Str;
}

-(void)setLeixingStr:(NSString *)leixingStr
{
    _leixingView.image = [UIImage imageNamed:leixingStr];
}
-(void)setIstuijian:(BOOL)istuijian{
    
    _tuijianView.hidden = istuijian;
}
-(void)setDingweiStr:(NSString *)dingweiStr{
    
}
-(void)setNameStr:(NSString *)nameStr{
    _nameLbl.text = nameStr;
}
-(void)setImgViewStr:(NSString *)imgViewStr
{
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imgViewStr] placeholderImage:[UIImage imageNamed:@"travels-details_default-chart04"]];
    
}
-(void)setHeadimgStr:(NSString *)headimgStr
{
    [_headimgView sd_setImageWithURL:[NSURL URLWithString:headimgStr] placeholderImage:[UIImage imageNamed:@"home_default-avatar"]];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

