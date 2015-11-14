//
//  jingdianView.h
//  CWYouJi
//
//  Created by MC on 15/11/15.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol jingdianViewDelegate <NSObject>

-(void)jingdianStr:(NSString*)str;

@end


@interface jingdianView : UIView
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray *jingdianArray;
@property(weak,nonatomic)id<jingdianViewDelegate>  delegate;

@end
