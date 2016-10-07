//
//  LTHttpRequest.m
//  NewHealthGuard
//
//  Created by LaoTao on 16/01/24.
//  Copyright © 2016年 LaoTao. All rights reserved.
//

#import "LTHttpRequest.h"

@interface LTHttpRequest ()

@property (copy, nonatomic) void (^successBlock)(id responseObject);
@property (copy, nonatomic) void (^failureBlock)(NSError *error);

@end

@implementation LTHttpRequest


+ (instancetype)requestHttp {
    return [[self alloc] init];
}

- (void)postParameters:(id)parameters
            requestUrl:(NSString *)url
          contentType:(BOOL)contentType
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure {
    _successBlock = [success copy];
    _failureBlock = [failure copy];
    
    NSLog(@"%@", parameters);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
    if (contentType) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"===%@", responseObject);
        [self responseSuccess:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[SVProgressHUD dismiss];
        _failureBlock(error);
        NSLog(@"数据上传失败:%@", error);
    }];
}

- (void)getRequestUrl:(NSString *)url
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure {
    
    _successBlock = [success copy];
    _failureBlock = [failure copy];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];

    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [self responseSuccess:responseObject];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"网络请求失败:%@", [error localizedDescription]);
        _failureBlock(error);
    }];
}

- (void)responseSuccess:(id _Nonnull)responseObject {
    NSLog(@"%@", responseObject);
    //[SVProgressHUD dismiss];
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSInteger code = [[NSString stringWithFormat:@"%@", dic[@"code"]] integerValue];
        
        if (code == 3001) {
            //退出登录
            [LTFunction logoutHint];
        }else if (code == 1) {
            if (_successBlock) {
                _successBlock(responseObject);
            }
        }else {
            
        }
            
        
    }else {
        
    }

}


@end
