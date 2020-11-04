//
//  LYServiceConfiguration.m
//  Lvyue
//
//  Created by szh on 2018/3/5.
//  Copyright © 2018年 szh. All rights reserved.
//

#import "LYServiceConfiguration.h"
#define LYBaseURL              @"http://dev.pms.lvyuetravel.com"

@implementation LYServiceConfiguration

+ (LYServiceConfiguration *)defaultConfiguration{
    LYServiceConfiguration *configer = [[LYServiceConfiguration alloc] init];
    
    configer.baseUrl = LYBaseURL;

    return configer;
}

@end
