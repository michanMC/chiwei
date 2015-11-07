//
//  zhizuoZP1ViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/8.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zhizuoZP1ViewController.h"

@interface zhizuoZP1ViewController ()
{
    
    UIImageView * _haedImgView;
    UILabel *_textlbl;
    UIButton * _btn1;
    UIButton * _btn2;
    UIButton *_btn3;
    BOOL _isxuanzhe;
    
}

@end

@implementation zhizuoZP1ViewController
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
    self.title = @"制作游记";
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    
    CGFloat x = 0;
    CGFloat width = Main_Screen_Width;
    CGFloat height = 30;
    CGFloat y = (Main_Screen_Height - 30)/2;
    _textlbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _textlbl.text = @"你对此景点的看法是";
    _textlbl.font = [UIFont systemFontOfSize:20];
    _textlbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textlbl];
    
    
    
    width = 150;
    height = 150;
    x = (Main_Screen_Width - width)/2;
    y -= 10 + width;
    _haedImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _haedImgView.image = [UIImage imageNamed:@"-travel-notes_photo"];
    [self.view addSubview:_haedImgView];
    
    y = Main_Screen_Height/2 + 25;
    
    width = 70;
    height = 70;
    x = (Main_Screen_Width - 140)/ 6 * 2;
    _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_btn1 setImage:[UIImage imageNamed:@"不枉此行_normal"] forState:0];
    [_btn1 addTarget:self action:@selector(ActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn1];
    
    
    x += width +x;
    
    _btn2 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_btn2 setImage:[UIImage imageNamed:@"坑了-个爹_normal"] forState:0];
    [self.view addSubview:_btn2];
    [_btn2 addTarget:self action:@selector(ActionBtn:) forControlEvents:UIControlEventTouchUpInside];

    width = Main_Screen_Width - 80;
    height = 40;
    y = Main_Screen_Height - 40 - 20;
    x = 40;
    
    _btn3 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_btn3 setBackgroundImage:[UIImage imageNamed:@"login_btn_pressed"] forState:0];
    [_btn3 setTitle:@"下一步" forState:0];
    [_btn3 setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:_btn3];
    
    
    
  
    
    
}
-(void)ActionBtn:(UIButton *)btn{
    CGFloat x = 0;
    CGFloat y = 64 + 10;
    if (!_isxuanzhe) {
        _isxuanzhe = YES;
        _haedImgView.hidden = YES;
       
        _textlbl.frame = CGRectMake(x, y, _textlbl.frame.size.width, _textlbl.frame.size.height) ;
        y += 30 + 25;
        _btn1.frame = CGRectMake(_btn1.frame.origin.x, y, 70, 70);
        _btn2.frame = CGRectMake(_btn2.frame.origin.x, y, 70, 70);
    }
     y = 64 + 10 + 50;
    if (btn==_btn1) {
        _btn1.frame = CGRectMake(_btn1.frame.origin.x, y-10, 90, 90);
        _btn2.frame = CGRectMake(_btn2.frame.origin.x, y+10, 70, 70);

    }
    else
    {
        _btn1.frame = CGRectMake(_btn1.frame.origin.x, y+10, 70, 70);
        _btn2.frame = CGRectMake(_btn2.frame.origin.x, y-10, 90, 90);
    }
    
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
