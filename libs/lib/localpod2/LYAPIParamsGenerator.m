//
//  LYAPIParamsGenerator.m
//  Lvyue
//
//  Created by szh on 2018/3/5.
//  Copyright © 2018年 szh. All rights reserved.
//

#import "LYAPIParamsGenerator.h"
//#import "UIDevice+LYNetworkingHeader.h"
//#import <CloudPushSDK/CloudPushSDK.h>
@implementation LYAPIParamsGenerator

+ (NSDictionary *)commonHeaderDictionary{
    
    return @{
//        @"os-version": [UIDevice ly_ostype],
//             @"devid" :  [UIDevice ly_uuid],
//             @"os-model" :[UIDevice ly_deviceModel],
//             @"device-type":@"6",//"6": iOS, "5": android
//             @"app-package-name":@"com.lvyuetravel.xpms.client",
//             @"app-version-name":[UIDevice ly_appversion],
//             @"idfa":[UIDevice ly_idfa],
//             @"User-Agent":[NSString convertNull:[self commonUserAgentString]],
//             @"lang":[NSString convertNull:[LYLocalizationManager getNowLang]],
//             @"push-token":[NSString convertNull:[self getAliDeviceID]],//阿里下发的推送设备id（后端用这个发推送）
//             @"ver": [NSString stringWithFormat:@"%d",APPVERSIONCODE],
//             @"notification-enabled":[self getNotificationEnable],// 推送开关，1开启，2关闭， 3未得到结果
//             @"channel-type":@"1", //1 阿里
//             @"apple-apns-token":[self getDeviceToken],//苹果下发的推送token
//             @"uid":[self getCookiesUID],//苹果下发的推送token
//             @"timeZone":[LYUserManager sharedInstance].hotelModel.timeZone.length?[LYUserManager sharedInstance].hotelModel.timeZone:@"8",//时区,默认东八区

             };
}

+ (NSString *)getCookiesUID{
//    NSHTTPCookieStorage *cooksto =  [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [cooksto cookies])
//    {
//        if ([cookie.name isEqualToString:@"uid"]) {
//            return cookie.value;
//        }
//    }

    return @"";
}

+ (NSString *)commonUserAgentString{
    return @"";
//    return [NSString stringWithFormat:@"com.lvyuetravel.xmps.client_iOS/%@/%@/%@",[UIDevice ly_appversion],[UIDevice ly_deviceModel],[UIDevice ly_ostype]];
}


+ (NSDictionary *)commonParamsDictionary{
    return @{};
//    return @{@"lang":[NSString convertNull:[LYLocalizationManager getNowLang]],@"timeZone":[LYUserManager sharedInstance].hotelModel.timeZone.length?[LYUserManager sharedInstance].hotelModel.timeZone:@"8",//时区,默认东八区
//    };
}

+ (NSDictionary *)paramsDictionaryGenerator:(NSDictionary *)params methodName:(NSString *)methodName{
    
    return @{};
//    NSMutableDictionary *paramsDic = [[LYAPIParamsGenerator commonParamsDictionary] mutableCopy];
//    [paramsDic addEntriesFromDictionary:params];
//
//    return paramsDic;
}

+ (NSString *)cacheKeyGenerator:(NSDictionary *)params methodName:(NSString *)methodName{
    return @"";
}

+ (NSString *)getAliDeviceID
{
    return @"";
//    NSString *token = [CloudPushSDK getDeviceId];
//    if (!token || token.length == 0) {
//
//        return @"";
//    }
//    return token;
}
+ (NSString *)getDeviceToken
{
    return @"";
//    NSString *token = [CloudPushSDK getApnsDeviceToken];
//    if (!token || token.length == 0) {
//
//        return @"";
//    }
//    return token;
}

+ (NSString *)getNotificationEnable{
    return @"";
//    NSString * enabled = [[NSUserDefaults standardUserDefaults] objectForKey:@"notification_enabled"];
//    if (enabled.intValue==1||enabled.intValue==2) {
//        return enabled;
//    }else{
//        return @"3";
//    }
}
@end
