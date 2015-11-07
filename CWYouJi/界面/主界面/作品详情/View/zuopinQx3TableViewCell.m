//
//  zuopinQx3TableViewCell.m
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinQx3TableViewCell.h"

@interface zuopinQx3TableViewCell (){
    UIImageView *_headImgView;
    UILabel * _nameLbl;
    
    UILabel *_titleLbl;
    
    
    
    
    
}

@end

@implementation zuopinQx3TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier   {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat x = 20;
        CGFloat y = 0;
        CGFloat width = Main_Screen_Width - 80 - 40;
        CGFloat height = 0.5;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
        
        y += height + 10;
        width = 25;
        height = 25;
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _headImgView.image =[UIImage imageNamed:@"home_default-avatar"];
        [self.contentView addSubview:_headImgView];
        
        x +=width + 5;
        width = 150;
        height = 20;
        y += 2.5;
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _nameLbl.text = @"michan";
        _nameLbl.textColor= AppTextCOLOR;
        _nameLbl.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nameLbl];
        
        x = 20;
        y += height + 10;
        
        height = 20;
        width = Main_Screen_Width - 80 - 30;
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _titleLbl.textColor = [UIColor grayColor];
        _titleLbl.font = [UIFont systemFontOfSize:13];
        _titleLbl.numberOfLines = 0;
        [self.contentView addSubview:_titleLbl];
        
        
        
    }
    return self;
}
-(void)setHeadStr:(NSString *)headStr
{
    
}
-(void)setNameStr:(NSString *)nameStr
{
    _nameLbl.text = nameStr;
}
-(void)setTitleStr:(NSString *)titleStr
{
    
    _titleLbl.text= titleStr;
    CGFloat h = [MCIucencyView heightforString:titleStr andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
    _titleLbl.frame = CGRectMake(_titleLbl.frame.origin.x, _titleLbl.frame.origin.y, _titleLbl.frame.size.width, h);
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
