//
//  zhizuoZP2ViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/8.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zhizuoZP2ViewController.h"
#import "MCdeleteImgView.h"
#import "ZYQAssetPickerController.h"
#import "zhizuoTextTableViewCell.h"
#import "zhizuoText2TableViewCell.h"
#import "UIPlaceHolderTextView.h"
#import "liulanViewController.h"
#import "TYAlertController+BlurEffects.h"
#import "ShareView.h"
#import "UIView+TYAlertView.h"

@interface zhizuoZP2ViewController ()<ZYQAssetPickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_imgViewArray;
    
    UIPlaceHolderTextView * _holderText;
    UILabel *_countText;
    
    NSString *_holderTextStr;
    NSString *_countTextStr;
    NSString * _diaotiStr;
    
    
}

@end

@implementation zhizuoZP2ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgViewArray = [NSMutableArray array];
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(89,40,100,35)];
    
    UIButton *navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navigationButton setFrame:CGRectMake(100 - 35,0,30,30)];
    [navigationButton setImage:[UIImage imageNamed:@"nav_release_normal"] forState:UIControlStateNormal];
    navigationButton.tag = 200;
    [navigationButton addTarget:self action:@selector(actionnavigationButton:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:navigationButton];
    
    navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navigationButton setFrame:CGRectMake(100 - 35 - 35,0,30,30)];
    [navigationButton setImage:[UIImage imageNamed:@"nav_preview_normal"] forState:UIControlStateNormal];
    navigationButton.tag = 201;
    [navigationButton addTarget:self action:@selector(actionnavigationButton:) forControlEvents:UIControlEventTouchUpInside];

    [containerView addSubview:navigationButton];
    
    navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navigationButton setFrame:CGRectMake(100 -3 * 35,0,30,30)];
    [navigationButton setImage:[UIImage imageNamed:@"nav_delete_normal"] forState:UIControlStateNormal];
    navigationButton.tag = 202;
    [navigationButton addTarget:self action:@selector(actionnavigationButton:) forControlEvents:UIControlEventTouchUpInside];


    [containerView addSubview:navigationButton];

    
    
    
    UIBarButtonItem *navigationBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    
    self.navigationItem.rightBarButtonItem = navigationBarButtonItem;
    
    [self prepareUI];
    
    // Do any additional setup after loading the view.
}
#pragma mark-点击事件
-(void)actionnavigationButton:(UIButton*)btn{
    UITextField * text = (UITextField *)[self.view viewWithTag:500];
    [text resignFirstResponder];
    UITextView * textview = (UITextView *)[self.view viewWithTag:600];
    [textview resignFirstResponder];
    
    
    if (btn.tag == 202) {
        NSLog(@"删除");
    }
    NSMutableArray *imgArray = [NSMutableArray array];
    for (int i = 0; i < _imgViewArray.count; i ++) {
        
        UIImage *tempImg;
        if([_imgViewArray[i]isKindOfClass:[UIImage class]]){
            tempImg = _imgViewArray[i];
        }
        else{
            ALAsset *asset=_imgViewArray[i];
            tempImg =[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        }
        
        [imgArray addObject:tempImg];
        
    }
    if (!imgArray.count) {
        kAlertMessage(@"亲，有图有真相哦");
        return;
    }

    if (!_diaotiStr.length) {
        kAlertMessage(@"请输入标题");
        return;
    }
    
    if (!_holderTextStr.length) {
        kAlertMessage(@"请输入你要说的内容");
        return;
    }

    if (btn.tag == 200) {//发布
        NSLog(@"发布");
        NSLog(@">>>>%@",_dataDic);
        NSInteger  isRecommend = 0;
        NSInteger classify = 0;
        NSString *startTime;
        NSInteger spotId;
        if ([[_dataDic objectForKey:@"isRecommend"] isEqualToString:@"赞美"]) {
            isRecommend = 1;
//            _titlearray = @[@"东西好吃得不要不要的",@"三星级的价格，五星级的享受",@"景美，我和我的小伙伴都惊呆了",@"买买买"];

            
            
        }
        else
        {
          // [@"我有100钟方法让你吃不下去",@"住宿环境差，感觉不会再爱了",@"看到这景色，我的内心几乎是崩溃",@"青岛大虾，38元一只"];
            isRecommend = 0;
            
        }
        if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"东西好吃得不要不要的"]||[[_dataDic objectForKey:@"classify"] isEqualToString:@"我有100钟方法让你吃不下去"])
            classify = 0;
        if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"三星级的价格，五星级的享受"]||[[_dataDic objectForKey:@"classify"] isEqualToString:@"住宿环境差，感觉不会再爱了"])
            classify = 1;
        if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"景美，我和我的小伙伴都惊呆了"]||[[_dataDic objectForKey:@"classify"] isEqualToString:@"看到这景色，我的内心几乎是崩溃"])
            classify = 2;
        if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"买买买"]|[[_dataDic objectForKey:@"classify"] isEqualToString:@"青岛大虾，38元一只"])
            classify = 3;

     startTime =   [[_dataDic objectForKey:@"startTime"] substringToIndex:10];
        spotId = [[_dataDic objectForKey:@"spotId"] integerValue];
        
        
       // NSLog(@">>>>>%@",imgArray);
        NSMutableDictionary * imgDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < imgArray.count; i++) {
            
            UIImage *img = imgArray[i];
            NSData *imageData = UIImageJPEGRepresentation(img, 0.2);
            NSString *base64Image=[imageData base64Encoding];
             [imgDic setObject:base64Image forKey:[NSString stringWithFormat:@"%d",i+1]];

            
        }
        NSLog(@"<<<<<%@",imgDic);
        
        
        NSError *parseError = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:imgDic options:NSJSONWritingPrettyPrinted error:&parseError];
        
        NSString * photoes = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        
        
        
        NSLog(@",,,,,,%@",self.userSessionId);
        NSDictionary * Parameterdic = @{
                                        @"title":_diaotiStr,
                                        @"content":_holderTextStr,
                                        @"spotId":@(spotId),
                                        @"classify":@(classify),//classify,
                                        @"startTime":startTime,
                                        @"isRecommend":@(isRecommend),//isRecommend,
                                        @"photoes":photoes,
                                        @"user_session":self.userSessionId
                                        
                                        };
        
        
        [self showLoading:YES AndText:nil];
        [self.requestManager requestWebWithParaWithURL:@"api/travel/add.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
            [self hideHud];
            NSLog(@"成功");
            NSLog(@"返回==%@",resultDic);
            
            [self showAllTextDialog:@"发布成功"];
            //发送通知首页刷新
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dishuaxinObjNotification" object:@""];
            
            ShareView *shareView = [ShareView createViewFromNib];
            shareView.titleLbl.textColor = AppTextCOLOR;
            ViewRadius(shareView.bgView, 5);
            
            
            [shareView.detebtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
                [shareView hideView];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
            }];
            [shareView.weiboBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
                [shareView hideView];
                [self actionFenxian:SSDKPlatformTypeSinaWeibo];
                [self.navigationController popToRootViewControllerAnimated:YES];
                NSLog(@"微博");
            }];
            [shareView.QQBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
                [shareView hideView];
                [self actionFenxian:SSDKPlatformTypeQQ];
[self.navigationController popToRootViewControllerAnimated:YES];
                NSLog(@"QQ");
            }];
            [shareView.weixin handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
                [shareView hideView];
                [self actionFenxian:SSDKPlatformTypeWechat];
[self.navigationController popToRootViewControllerAnimated:YES];
                NSLog(@"weixin");
            }];
            [shareView.toudouBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
                [shareView hideView];
                [self actionFenxian:SSDKPlatformTypeDouBan];
[self.navigationController popToRootViewControllerAnimated:YES];
                NSLog(@"土豆");
            }];
            [shareView showInWindow];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//                [self.navigationController popToRootViewControllerAnimated:YES];
//                
//            });

            
            
            
            
        } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
            [self hideHud];
            [self showAllTextDialog:description];
            
            NSLog(@"失败");
        }];
        
        
        return;
       
//        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:shareView preferredStyle:TYAlertControllerStyleAlert];
//        
//        // blur effect
//        [alertController setBlurEffectWithView:self.view];
//        
//        //alertController.alertViewOriginY = 60;
//        [self presentViewController:alertController animated:YES completion:nil];
        

        
        
        
        
    }
    if (btn.tag == 201) {
        NSLog(@"浏览");
        
      
//        NSMutableArray *imgArray = [NSMutableArray array];
//        for (int i = 0; i < _imgViewArray.count; i ++) {
//        
//        UIImage *tempImg;
//        if([_imgViewArray[i]isKindOfClass:[UIImage class]]){
//            tempImg = _imgViewArray[i];
//        }
//        else{
//            ALAsset *asset=_imgViewArray[i];
//            tempImg =[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//        }
//            
//            [imgArray addObject:tempImg];
//            
//        }
//        if (!imgArray.count) {
//            kAlertMessage(@"亲，有图有真相哦");
//            return;
//        }
          liulanViewController * ctl = [[liulanViewController alloc]init];
        ctl.imgViewArray= imgArray;
        ctl.titleStr = _diaotiStr;
        ctl.title2Str = _holderTextStr;
        ctl.dataDic = _dataDic;
        ctl.jingdianStr =  [_dataDic objectForKey:@"jingdianStr"];
        [self pushNewViewController:ctl];
        
        
        
    }

    
}
-(void)prepareUI{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    _tableview.tableHeaderView = [self headView];
    _tableview.delegate =self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        return 426;
    }
    
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid1 = @"zhizuoTextTableViewCell";
    if (indexPath.row == 0) {
        zhizuoTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"zhizuoTextTableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.mctext.delegate= self;
        cell.mctext.text = _diaotiStr;
        cell.mctext.tag = 500;
        //设置清除按钮
        cell.mctext.clearButtonMode = UITextFieldViewModeAlways;        return cell;
    }
    else if(indexPath.row == 1){
        
        zhizuoText2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc1"];
        if (!cell) {
            cell = [[zhizuoText2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc1"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.holderTex.delegate = self;
        cell.countLbl.tag = 600;
        cell.countLbl.text = _countTextStr;
        
        
        return cell;
        
    }
    
    
    return [[UITableViewCell alloc]init];
    
    
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    _diaotiStr = textField.text;
    //[_tableview reloadData];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([textField.text length] > 18) {
        //[_tableview reloadData];
        
        return NO;
    }
    //[_tableview reloadData];
    
    return YES;
 
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        return NO;
    }
    UILabel * lbl = (UILabel*)[self.view viewWithTag:600];
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 500) {
        //[_tableview reloadData];
        lbl.text = [NSString stringWithFormat:@"%ld/500",aString.length];
        _countTextStr = lbl.text;

        return NO;
    }
    //[_tableview reloadData];
    lbl.text = [NSString stringWithFormat:@"%ld/500",aString.length];
    _countTextStr = lbl.text;
    return YES;

    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    _holderTextStr = textView.text;
    
    [_tableview reloadData];
    
}
-(UIView*)headView{
    CGFloat width = (Main_Screen_Width - 30)/2;
    CGFloat hieght = width + 20;
    
    UIView * view =[[ UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, hieght)];
    view.backgroundColor =[UIColor groupTableViewBackgroundColor];
    UIButton *noView = [[UIButton alloc]initWithFrame:CGRectMake((Main_Screen_Width - 80)/2, 30, 80, 80)];
    [noView setImage:[UIImage imageNamed:@"-travel-notes_addpicture"] forState:0];
    [noView addTarget:self action:@selector(actionImgTap) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:noView];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, hieght - 20 - 20, Main_Screen_Width , 20)];
    
    lbl.text = @"有图有真相，点我上传图片";
    lbl.textColor = [UIColor grayColor];
    lbl.font = AppFont;
    lbl.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lbl];
    
    return view;
}
-(UIView *)addHeadView:(NSInteger)count{
   
    CGFloat width = (Main_Screen_Width - 30)/2;
    CGFloat hieght = width + 20;
    
    UIView * view =[[ UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, hieght)];
    view.backgroundColor =[UIColor groupTableViewBackgroundColor];
    //一张时
    if (count == 1) {
      MCdeleteImgView * imgView =  [self addImgView:CGRectMake(10, 10, Main_Screen_Width - 20, hieght - 20) Iszuihuo:YES Tag:1];
        
        [view addSubview:imgView];
    }
    //2
    if (count == 2) {
        
        hieght -=20;
      CGFloat  y = 10;
        CGFloat  x = 10;
        for (int i =0 ; i < 2; i++) {
            
            MCdeleteImgView * imgView =  [self addImgView:CGRectMake(x, y, width, hieght) Iszuihuo:i==1?YES:NO Tag:i + 1];
            [view addSubview:imgView];
  
            x += width + 10;
            
        }
    }
    //3
    if (count == 3) {
        
        hieght -=20;
        CGFloat  y = 10;
        CGFloat  x = 10;
        
        for (int i =0 ; i < 3; i++) {
            
            if (i == 0) {
                MCdeleteImgView * imgView =  [self addImgView:CGRectMake(x, y, width, hieght) Iszuihuo:NO Tag:i + 1];
                [view addSubview:imgView];
                
                x += width + 10;
                hieght = (hieght - 10)/2;
  
            }
            else
            {
                
                MCdeleteImgView * imgView =  [self addImgView:CGRectMake(x, y, width, hieght) Iszuihuo:i==2?YES:NO Tag:i + 1];
                [view addSubview:imgView];
                y += hieght + 10;
  
            }
            
            
        }
    }
    //4

    if (count == 4) {
        
        hieght -=20;
        CGFloat  y = 10;
        CGFloat  x = 10;
        hieght = (hieght - 10)/2;
        
        for (int i =0 ; i < 4; i++) {
            
                MCdeleteImgView * imgView =  [self addImgView:CGRectMake(x, y, width, hieght) Iszuihuo:i==3?YES:NO Tag:i + 1];
                [view addSubview:imgView];
                x += width + 10;
            if (i == 1) {
                x = 10;
                y += hieght + 10;
            }
    }
    }
    
    return view;
}
-(MCdeleteImgView*)addImgView:(CGRect)frame Iszuihuo:(BOOL)iszuihuo Tag:(NSInteger)tag{
    MCdeleteImgView * imgView = [[MCdeleteImgView alloc]initWithFrame:frame];
    imgView.deleteBtn.tag = tag;
#pragma mark-删除图片
    [imgView.deleteBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        UIButton * btn =(UIButton*)sender;
        [_imgViewArray removeObjectAtIndex:btn.tag - 1];
        if (_imgViewArray.count) {
            _tableview.tableHeaderView = nil;
            _tableview.tableHeaderView = [self addHeadView:_imgViewArray.count];
        }
        else
        {
            _tableview.tableHeaderView = nil;
            _tableview.tableHeaderView = [self headView];
        }

        
    }];
    UIImage *tempImg;
    if([_imgViewArray[tag - 1]isKindOfClass:[UIImage class]]){
        tempImg = _imgViewArray[tag - 1];
    }
    else{
       ALAsset *asset=_imgViewArray[tag - 1];
       tempImg =[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    }

    

    
    imgView.imgView.image =tempImg;
    if (iszuihuo) {
        UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 40 - 5, frame.size.height - 40 -5, 40, 40)];
        [addBtn setImage:[UIImage imageNamed:@"-travel-notes_addpicture02"] forState:0];
        [imgView addSubview:addBtn];
        imgView.userInteractionEnabled = YES;
        [addBtn addTarget:self action:@selector(actionImgTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return imgView;
 
}

#pragma mark-点击头像
-(void)actionImgTap{
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"从相册选择", @"拍照",nil];
    
    [myActionSheet showInView:self.view];
}
#pragma mark-选择从哪里拿照片
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==2) return;
    
    
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if(buttonIndex==1){//拍照
        sourceType=UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable:sourceType]){
            kAlertMessage(@"检测到无效的摄像头设备");
            return ;
        }
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [self presentViewController:picker animated:YES completion:nil];

        
        
    }
   
    [self btnClick];
    
    
    
}
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        
        
        
        if (_imgViewArray.count<4) {
            [_imgViewArray addObject:image];
        }
        // _imgViewArray = [NSMutableArray arrayWithArray:assets];
        if (_imgViewArray.count && _imgViewArray.count <5) {
            _tableview.tableHeaderView = nil;
            _tableview.tableHeaderView = [self addHeadView:_imgViewArray.count];
        }

            
            
    }
    

}




-(void)btnClick{
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 4;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        
        
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 4;
        } else {
            return YES;
        }
        
        
        
    }];
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    NSLog(@"%ld",assets.count);
    for (ALAsset *asset in assets) {
        
        if (_imgViewArray.count <4) {
            [_imgViewArray addObject:asset];
        }
    }
   // _imgViewArray = [NSMutableArray arrayWithArray:assets];
    if (_imgViewArray.count && _imgViewArray.count <5) {
        _tableview.tableHeaderView = nil;
        _tableview.tableHeaderView = [self addHeadView:_imgViewArray.count];
    }
    
}


-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker{
    NSLog(@"到达上限");
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
