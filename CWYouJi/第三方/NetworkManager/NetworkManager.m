//
//  NetworkManager.m
//  FishingJoy
//
//  Created by expro on 14-1-9.
//  Copyright (c) 2014年 expro. All rights reserved.
//

#import "NetworkManager.h"
#import "MyTools.h"
#import "AA3DESManager.h"
#import "CommeHelper.h"
//http://121.201.16.96:80/app/test
static NSString *const EPHttpApiBaseURL = AppURL;//@"http://121.201.16.96";
//static NSString *const EPHttpApiBaseURL = @"http://120.25.218.167";

@implementation NetworkManager

+ (instancetype)instanceManager
{
    static NetworkManager *_instanceManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instanceManager = [[NetworkManager alloc] init];
        _instanceManager.httpClient = [ExproHttpClient sharedClient];
        
        _instanceManager.reachability = [Reachability reachabilityWithHostName:EPHttpApiBaseURL];
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [_instanceManager.httpClient.requestSerializer setValue:[defaults objectForKey:@"sessionId"] forHTTPHeaderField:@"user_session"];
        
        
    });
    
    return _instanceManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
//    Reachability *reachAblitity = [Reachability reachabilityForInternetConnection];
    Reachability *reachAblitity = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    switch ([reachAblitity currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=TRUE;
            break;
    }
    
    return isExistenceNetwork;
}

- (BOOL) IsEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

- (BOOL) IsEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

/**
 *  请求网络接口,返回请求的响应接口,并作初期数据处理
 *
 *  @param webApi        网络请求的接口
 *  @param para          请求所带的参数
 *  @param completeBlock 成功请求后得到的响应,此响应包括服务器业务逻辑异常结果,只接收服务器业务逻辑状态码为200的结果
 *  @param errorBlock    服务器响应不正常,网络连接失败返回的响应结果
 */
- (void)requestWebWithParaWithURL:(NSString*)webApi Parameter:(NSDictionary *)para IsLogin:(BOOL)islogin Finish:(HttpResponseSucBlock)completeBlock Error:(HttpResponseErrBlock)errorBlock
{
    NSMutableDictionary * paraDic =[NSMutableDictionary dictionaryWithDictionary:para];

    if (islogin) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSLog(@"%@",[defaults objectForKey:@"sessionId"]);
        
        [self.httpClient.requestSerializer setValue:[defaults objectForKey:@"sessionId"] forHTTPHeaderField:@"user_session"];
        
        if ([[defaults objectForKey:@"sessionId"] length]) {
            
            [paraDic setObject:[defaults objectForKey:@"sessionId"] forKey:@"user_session"];
        }
        
        
    }
   

    [self.httpClient POST:webApi parameters:paraDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // DLog(@"URL:%@, 请求参数:%@, 返回值:%@",operation.request.URL,para,responseObject);
        
        NSError *parserError = nil;
        NSDictionary *resultDic = nil;
        @try {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

            
//           NSRange rangeFrom = [s rangeOfString:@"result\":\""];
             NSRange rangeFrom = [responseString rangeOfString:@"resultMsg\":\""];
           // DLog(@"range===%lu    %lu",(unsigned long)rangeFrom.location, (unsigned long)rangeFrom.length);
//            resultDic = (NSDictionary *)responseObject;
//            NSRange rangeTo = [s rangeOfString:@"\",\"remark\""];
            NSRange rangeTo = [responseString rangeOfString:@"\",\"deviceId\""];
         //   DLog(@"range===%lu    %lu",(unsigned long)rangeTo.location, (unsigned long)rangeTo.length);
           
            NSRange stringRange = NSMakeRange(rangeFrom.location + rangeFrom.length, rangeTo.location - rangeFrom.location - rangeFrom.length);
            NSString *tostring;
            if (stringRange.length != 0) {
                tostring = [responseString substringWithRange:stringRange];
               // DLog(@"st====%@",tostring);
                NSString *decryptString = [AA3DESManager getDecryptWithString:tostring keyString:@"p2p_standard2_base64_key" ivString:@"p2p_s2iv"];
                NSLog(@"decrystring==%@",decryptString);
            }
           
            NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            
            
            resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
           // DLog(@"dic===%@",resultDic);
            
           // NSString *resultArray = [resultDic objectForKey:@"code"];
            
//            if ((NSNull *)resultArray != [NSNull null]) {
//                NSString *resultArrayStr = [AA3DESManager getDecryptWithString:resultArray keyString:@"p2p_standard2_base64_key" ivString:@"p2p_s2iv"];
//                NSLog(@"resultArrayStr==%@",resultArrayStr);
//            }
          
            
        }
        @catch (NSException *exception) {
            [NSException raise:@"网络接口返回数据异常" format:@"Error domain %@\n,code=%ld\n,userinfo=%@",parserError.domain,(long)parserError.code,parserError.userInfo];
            //发出消息错误的通知
        }
        @finally {
            //业务产生的状态码
            NSString *logicCode = [NSString stringWithFormat:@"%ld",[resultDic[@"code"] integerValue]];
            
            //成功获得数据
            if ([logicCode isEqualToString:@"1"]) {
                
                completeBlock(resultDic);
                
            }
            else{
                //业务逻辑错误
                NSString *message = [resultDic objectForKey:@"message"];
                NSError *error = [NSError errorWithDomain:@"服务器业务逻辑错误" code:logicCode.intValue userInfo:nil];
                if ([message isEqualToString:@"会话信息失效"]) {
                    
                    //                    /*保存数据－－－－－－－－－－－－－－－－－begin*/
                    //                    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                    //                    [defaults setObject:@"0" forKey:@"isLogOut"];
                    //                    // [defaults setObject :nil forKey:@"sessionId"];
                    //                    [MCUser sharedInstance].sessionId = nil;
                    //                    [defaults setObject:nil forKey:@"sessionId"];
                    //                    // [defaults setObject:nil forKey:@"Pwd"];
                    //                    [defaults setObject:nil forKey:@"customerName"];
                    //                    [defaults setObject:nil forKey:@"examine"];
                    //
                    //
                    //                    //消除提示打开通讯录
                    //                    [defaults setBool:NO forKey:@"isNoNotice"];
                    //
                    //                    //强制让数据立刻保存
                    //                    [defaults synchronize];
                    //                    // [[NetworkManager instanceManager] setSessionID:nil];
                    //                    ViewController * root = [[ViewController alloc]init];
                    //                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    //                    // [self addChildViewController:nav];
                    //                    
                    //                    
                    //                    appDelegate.window.rootViewController = root;
                    //                    
                    //                    
                    //                    
                    //                    return ;
                }
                errorBlock(nil,error,message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败
        if (![self isExistenceNetwork]) {
            
            errorBlock(operation,error,@"网络有问题，请稍后再试");
        }
        else{
            errorBlock(operation,error,@"数据请求失败");
        }

    }];
}

- (void)requestWebWithParaWithURL_NotResponseJson:(NSString*)webApi Parameter:(NSDictionary *)para Finish:(HttpResponseSucBlock)completeBlock Error:(HttpResponseErrBlock)errorBlock
{
    

    [self.httpClient POST:webApi parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        NSError *parserError = nil;
        NSDictionary *resultDic = nil;
        @try {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSRange rang=[responseString rangeOfString:@"</body>"];
            NSString *html=[responseString substringWithRange:NSMakeRange(0, rang.location+rang.length)];
            NSString *data=[responseString substringFromIndex:NSMaxRange(rang)];
       
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithCapacity:2];
            
            [dict setValue:html forKey:@"html"];

            NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *tempDict=[NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&err];
            
            [dict setObject:tempDict forKey:@"data"];
            
            resultDic=dict;
            
            
            
        }
        @catch (NSException *exception) {
            [NSException raise:@"网络接口返回数据异常" format:@"Error domain %@\n,code=%ld\n,userinfo=%@",parserError.domain,(long)parserError.code,parserError.userInfo];
            //发出消息错误的通知
        }
        @finally {
            //业务产生的状态码
            NSString *logicCode = [resultDic objectForKey:@"data"][@"resultCode"];
            
            //成功获得数据
            if ([logicCode isEqualToString:@"SUCCESS"]) {
                
                completeBlock(resultDic);
            }
            else{
                //业务逻辑错误
                NSString *message = [resultDic objectForKey:@"message"];
                NSError *error = [NSError errorWithDomain:@"服务器业务逻辑错误" code:logicCode.intValue userInfo:nil];
                errorBlock(nil,error,message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败
        if (![self isExistenceNetwork]) {
            
            errorBlock(operation,error,@"网络有问题，请稍后再试");
        }
        else{
            errorBlock(operation,error,@"数据请求失败");
        }
        
        
    }];
}


//获取所有的需要的参数,暂时没用到
//- (void)getAllParamList
//{
//    [self requestWebWithParaWithURL:@"area!getFishConfig.action" Parameter:nil Finish:^(NSDictionary *resultDic) {
//        self.paramdic = resultDic;
//    } Error:^(AFHTTPRequestOperation *operation, NSError *error,NSString *description) {
//        if (error.code == 404) {
//            UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"网络不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//            [alert show];
//        }
//    }];
//}



@end

@implementation ExproHttpClient

+ (instancetype)sharedClient
{
    static ExproHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ExproHttpClient alloc] initWithBaseURL:[NSURL URLWithString:EPHttpApiBaseURL]];
        
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
        //[_sharedClient.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];
        //[_sharedClient.requestSerializer setValue:APP_KEY forHTTPHeaderField:@"sign_appkey"];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
       // _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript", nil];
        
        
        
       

        
        
        
        
    });
    
    return _sharedClient;
}



@end

