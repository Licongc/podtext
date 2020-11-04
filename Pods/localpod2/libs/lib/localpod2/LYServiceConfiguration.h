//
//  LYServiceConfiguration.h
//  Lvyue
//
//  Created by szh on 2018/3/5.
//  Copyright © 2018年 szh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYServiceConfiguration : NSObject

@property (nonatomic, copy)NSString *baseUrl;

+ (LYServiceConfiguration *)defaultConfiguration;

@end
