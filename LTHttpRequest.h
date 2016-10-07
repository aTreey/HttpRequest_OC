//
//  LTHttpRequest.h
//  NewHealthGuard
//
//  Created by LaoTao on 16/01/24.
//  Copyright © 2016年 LaoTao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LTHttpRequestEnum) {
    /**
     * 默认
     */
    LTHttpRequestEnumDefault = 0,
    
    
    //    NSTextAlignmentLeft      = 0,    // Visually left aligned
    //#if TARGET_OS_IPHONE
    //    NSTextAlignmentCenter    = 1,    // Visually centered
    //    NSTextAlignmentRight     = 2,    // Visually right aligned
    //#else /* !TARGET_OS_IPHONE */
    //    NSTextAlignmentRight     = 1,    // Visually right aligned
    //    NSTextAlignmentCenter    = 2,    // Visually centered
    //#endif
    //    NSTextAlignmentJustified = 3,    // Fully-justified. The last line in a paragraph is natural-aligned.
    //    NSTextAlignmentNatural   = 4,    // Indicates the default alignment for script
} NS_ENUM_AVAILABLE_IOS(6_0);


@interface LTHttpRequest : NSObject

@property (assign, nonatomic) LTHttpRequestEnum requestEnum;

+ (instancetype)requestHttp;


- (void)postParameters:(id)parameters
            requestUrl:(NSString *)url
          contentType:(BOOL)contentType
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

- (void)getRequestUrl:(NSString *)url
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure;

@end
