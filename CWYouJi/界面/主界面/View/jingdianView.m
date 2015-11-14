//
//  jingdianView.m
//  CWYouJi
//
//  Created by MC on 15/11/15.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "jingdianView.h"

@interface jingdianView ()<UITableViewDataSource,UITableViewDelegate>{
    
    
    
}

@end

@implementation jingdianView
-(instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
    
    
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.frame.size.height)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString * cellid = @"mc1";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    
    cell.textLabel.text = @"大理";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = AppTextCOLOR;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_delegate jingdianStr:@"大理"];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
