//
//  LYSessionService.h
//  Lvyue
//
//  Created by szh on 2018/3/5.
//  Copyright © 2018年 szh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYServiceConfiguration.h"
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, LYRequestMethod) {
    LYRequestMethodGET     = 0,
    LYRequestMethodPUT     = 1,
    LYRequestMethodPOST    = 2,
    LYRequestMethodHEAD    = 3,
    LYRequestMethodPATCH   = 4,
    LYRequestMethodDELETE  = 5,
};

@interface LYSessionService : NSObject

+ (nonnull instancetype)sharedService;
- (nullable NSURLSessionDataTask *)RequsetHttpType:(LYRequestMethod)httpType
                                            params:(nullable NSDictionary *)params
                                        methodName:(nullable  NSString * )methodName
                              serviceConfiguration:(LYServiceConfiguration *_Nullable)configuration
                                           success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                           failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

- (nullable NSURLSessionDataTask *)RequsetFileParameters:(nullable id)params
                                              methodName:(nullable  NSString * )methodName
                                    serviceConfiguration:(LYServiceConfiguration *_Nullable)configuration
                               constructingBodyWithBlock:(nullable void (^)(id   <AFMultipartFormData> _Nullable formData))block
                                                progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                                 success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

- (BOOL)isReachable;
@end
