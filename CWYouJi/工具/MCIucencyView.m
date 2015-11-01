//
//  MCIucencyView.m
//  Hair
//
//  Created by michan on 15/5/26.
//  Copyright (c) 2015年 MC. All rights reserved.
//

#import "MCIucencyView.h"

@implementation MCIucencyView


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];

    }
    return self;
}
-(void)prepareUI{
    self.backgroundColor = [UIColor clearColor];
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.5;
    [self addSubview:_bgView];
    
    
}
-(void)setBgViewColor:(UIColor *)Color
{
    _bgView.backgroundColor = Color;
}
-(void)setBgViewAlpha:(CGFloat)bgViewAlpha
{
    _bgView.alpha = bgViewAlpha;
}
-(void)setGrade:(NSInteger)page{
    //_bgView.backgroundColor = [UIColor clearColor];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 13;
    CGFloat height = 13;
    for (int i = 0 ; i < 5; i++) {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgView.image = [UIImage imageNamed:@"star_dark_single"];
        [self addSubview:imgView];
        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgView.image = [UIImage imageNamed:@"star_light_single"];
        imgView.tag = i;
        [self addSubview:imgView];

        
        x += width;
    }
    for (int j = 0; j < 5; j++) {
        if (j >= page) {
            UIImageView *img = (UIImageView*)[self viewWithTag:j];
            img.hidden = YES;
        }
    }
    
}
-(void)setGradeMax:(NSInteger)page{
    _bgView.backgroundColor = [UIColor clearColor];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 18;
    CGFloat height = 18;
    if (page == 0) {
        
    for (int i = 0 ; i < 5; i++) {
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
            imgView.image = [UIImage imageNamed:@"order_icon_star_nomal"];
           // [self addSubview:imgView];
        imgView.userInteractionEnabled = YES;
            x += width;
        }
        return;
        
    }

    for (int i = 0 ; i < 5; i++) {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgView.image = [UIImage imageNamed:@"order_icon_star_nomal"];
      //  [self addSubview:imgView];
        imgView.userInteractionEnabled = YES;

        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgView.image = [UIImage imageNamed:@"order_icon_star_press"];
        imgView.tag = i;
        [self addSubview:imgView];
        imgView.userInteractionEnabled = YES;

        
        x += width - 3;
    }
    for (int j = 0; j < 5; j++) {
        if (j >= page) {
            UIImageView *img = (UIImageView*)[self viewWithTag:j];
            img.hidden = YES;
        }
    }
    
    
    
    
}

-(void)setGradeR:(NSInteger)page{
    //_bgView.backgroundColor = [UIColor clearColor];
    CGFloat x = 0;
    CGFloat y = 3;
    CGFloat width = 17;
    CGFloat height = 17;
    x = self.frame.size.width - width * page;
    
    
    
    for (int i = 0 ; i < page; i++) {
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake( x, y, width, height)];
        imgView.image = [UIImage imageNamed:@"order_icon_star_press"];
        imgView.tag = i;
        [self addSubview:imgView];
        
        
        x += width - 3;
    }
}



-(void)PaomaView:(NSString*)str{
    
    _PaomaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width - 50, self.frame.size.height)];
    [self addSubview:_PaomaView];
    //view.backgroundColor = [UIColor yellowColor];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _PaomaView.frame.size.width - 50, _PaomaView.frame.size.height)];
    
    lbl.text = str;
   CGFloat width = [MCIucencyView widthForString:lbl andheight:self.frame.size.height];
    
    lbl.frame = CGRectMake(0, 0, width, _PaomaView.frame.size.height);
    lbl.textColor = [UIColor grayColor];
    lbl.font = [UIFont systemFontOfSize:14];
    [_PaomaView addSubview:lbl];
    CGRect  frame =  lbl.frame;
    frame.origin.x = width + self.frame.size.width-120 - 50;
    lbl.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:15.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    frame = lbl.frame;
    frame.origin.x = -width;
    lbl.frame = frame;
    [UIView commitAnimations];
    
}
+(CGFloat) widthForString:(UILabel *)textView andheight:(CGFloat)height
{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(CGFLOAT_MAX, height)];
    return sizeToFit.width;
}
+ (CGFloat) heightForString:(UILabel *)textView andWidth:(CGFloat)width
{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    
    
    return sizeToFit.height;
}
/**
 ios7.0之前适用----
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (CGFloat) heightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize]
                         constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                             lineBreakMode:NSLineBreakByWordWrapping];
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}
/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (CGFloat) heightforString:(NSString *)value andWidth:(CGFloat)width fontSize:(CGFloat)fontSize{
    return [value boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil].size.height;

}
+ (CGFloat) heightforString:(NSString *)value andHeight:(CGFloat)height fontSize:(CGFloat)fontSize{
    return [value boundingRectWithSize:CGSizeMake(100000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil].size.width;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
