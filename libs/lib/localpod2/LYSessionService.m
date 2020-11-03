//
//  LYSessionService.m
//  Lvyue
//
//  Created by szh on 2018/3/5.
//  Copyright © 2018年 szh. All rights reserved.
//

#import "LYSessionService.h"
#import "LYAPIParamsGenerator.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface LYSessionService()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) AFHTTPRequestSerializer *afHTTPRequestSerializer;
@property (nonatomic, strong) AFJSONRequestSerializer *afJSONRequestSerializer;

@property (nonatomic, assign) NSInteger activityCount;
@property (nonatomic, strong) NSCache *sessionManagerCache;
@property (nonatomic, strong) NSArray *listOfHttpType;
@end

@implementation LYSessionService
+ (instancetype)sharedService{
    static LYSessionService *sessionService = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        sessionService = [[LYSessionService alloc] init];
    });
    return sessionService;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"image/png", nil];

        [RACObserve(self, activityCount) subscribeNext:^(NSNumber *activityCount) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (activityCount.integerValue>0) {
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
                }else{
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                }
            });
        }];
        
        self.listOfHttpType =  @[@"GET", @"PUT", @"POST", @"HEAD", @"PATCH", @"DELETE"];
        
    }
    return self;
}

- (nullable NSURLSessionDataTask *)RequsetHttpType:(LYRequestMethod)httpType
                                           params:(NSDictionary *)params
                                       methodName:(NSString *)methodName
                             serviceConfiguration:(LYServiceConfiguration *)configuration
                                          success:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success
                                          failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure{
    NSString *httpTypeMethod = nil;
    if (httpType >= 0 && httpType < self.listOfHttpType.count) {
        httpTypeMethod = self.listOfHttpType[httpType];
    }
    NSAssert(httpTypeMethod.length>0, @"the HTTP method not found");
    
    NSDictionary *encryptedPara = [LYAPIParamsGenerator paramsDictionaryGenerator:params methodName:methodName];
    
    NSString *URLString = nil;
    if (!configuration) {
        configuration = [LYServiceConfiguration defaultConfiguration];
    }
    NSURL *url = [NSURL URLWithString:configuration.baseUrl];
    if ([url path].length > 0 && ![[url absoluteString] hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    URLString =  [[NSURL URLWithString:methodName relativeToURL:url] absoluteString];

    NSParameterAssert(URLString);

    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.afHTTPRequestSerializer requestWithMethod:httpTypeMethod URLString:URLString parameters:encryptedPara error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        return nil;
    }

    NSDictionary *headers = [LYAPIParamsGenerator commonHeaderDictionary];
    if (headers.count>0) {
        [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            [request setValue:value forHTTPHeaderField:field];
        }];
    }
    @synchronized(self){
        self.activityCount++;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
//    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//        @synchronized(self) {
//            self.activityCount = MAX(_activityCount - 1, 0);
//        }
//        if (error) {
//            if (failure) {
//                NSLog(@"%@---%@---%@---%@", request.URL, request.allHTTPHeaderFields, params, [error localizedDescription]);
//                failure(dataTask, error);
//            }
//        } else {
//            if (success) {
//                NSLog(@"%@---%@---%@---%@", request.URL, request.allHTTPHeaderFields, params, responseObject);
//                success(dataTask, responseObject);
//            }
//        }
//    }];
    dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        @synchronized(self) {
            self.activityCount = MAX(self->_activityCount - 1, 0);
        }
        if (error) {
            if (failure) {
                NSLog(@"%@---%@---%@---%@", request.URL, request.allHTTPHeaderFields, params, [error localizedDescription]);
                failure(dataTask, error);
            }
        } else {
            if (success) {
                NSLog(@"%@---%@---%@---%@", request.URL, request.allHTTPHeaderFields, params, responseObject);
                success(dataTask, responseObject);
            }
        }

    }];
    
    [dataTask resume];
    return dataTask;
    
}

- (NSURLSessionDataTask *)RequsetFileParameters:(id)params methodName:(NSString *)methodName serviceConfiguration:(LYServiceConfiguration *)configuration constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nullable))block progress:(void (^)(NSProgress * _Nullable))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure{
    
    NSString *URLString = nil;
    if (!configuration) {
        configuration = [LYServiceConfiguration defaultConfiguration];
    }
    NSURL *URL = [NSURL URLWithString:configuration.baseUrl];
    if ([[URL path] length] > 0 && ![[URL absoluteString] hasSuffix:@"/"]) {
        URL = [URL URLByAppendingPathComponent:@""];
    }
    
    URLString =  [[NSURL URLWithString:methodName relativeToURL:URL] absoluteString];
    
    NSParameterAssert(URLString);
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.afHTTPRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:params constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    NSDictionary *headers =  [LYAPIParamsGenerator commonHeaderDictionary];
    if (headers.count > 0) {
        [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            [request setValue:value forHTTPHeaderField:field];
        }];
    }
    
    @synchronized(self){
        self.activityCount++;
    }
    
    
    __block NSURLSessionDataTask *task = [self.sessionManager uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        @synchronized(self) {
            self.activityCount = MAX(self->_activityCount - 1, 0);
        }
        
        if (error) {
            if (failure) {
                NSLog(@"%@---%@---%@---%@", request.URL, request.allHTTPHeaderFields, params, [error localizedDescription]);
                failure(task, error);
            }
        } else {
            if (success) {
                NSLog(@"%@---%@---%@---%@", request.URL, request.allHTTPHeaderFields, params, responseObject);
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}
#pragma mark --  Setter && Getter
- (NSCache *)sessionManagerCache {
    if (!_sessionManagerCache) {
        _sessionManagerCache = [[NSCache alloc] init];
    }
    return _sessionManagerCache;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        //        _sessionManager.requestSerializer = self.afHTTPRequestSerializer;
        //        _sessionManager.responseSerializer = self.afHTTPResponseSerializer;
        _sessionManager.operationQueue.maxConcurrentOperationCount = 5;
//        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
//        response.removesKeysWithNullValues = YES;//去除空值
//        _sessionManager.responseSerializer = response;//申明返回的结果是json类
//        _sessionManager.securityPolicy = [self customSecurityPolicy];
//        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
    }
    return _sessionManager;
}

- (AFSecurityPolicy *)customSecurityPolicy{
    /** https */
    NSString*cerPath = [[NSBundle mainBundle] pathForResource:@""ofType:nil];
    NSData*cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet*set = [[NSSet alloc] initWithObjects:cerData,nil];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:set];
    return policy;
}

- (AFHTTPRequestSerializer *)afHTTPRequestSerializer {
    if (!_afHTTPRequestSerializer) {
        _afHTTPRequestSerializer = [AFHTTPRequestSerializer serializer];
        _afHTTPRequestSerializer.timeoutInterval = 60;
        
    }
    return _afHTTPRequestSerializer;
}

- (AFJSONRequestSerializer *)afJSONRequestSerializer{
    if (!_afJSONRequestSerializer) {
        _afJSONRequestSerializer = [AFJSONRequestSerializer serializer];
        _afJSONRequestSerializer.timeoutInterval = 60;
    }
    return _afJSONRequestSerializer;
}

- (BOOL)isReachable{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

@end
