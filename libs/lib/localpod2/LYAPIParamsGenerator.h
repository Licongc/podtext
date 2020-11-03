//
//  LYAPIParamsGenerator.h
//  Lvyue
//
//  Created by szh on 2018/3/5.
//  Copyright © 2018年 szh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYAPIParamsGenerator : NSObject

+ (NSDictionary *)commonHeaderDictionary;
+ (NSDictionary *)commonParamsDictionary;
+ (NSDictionary *)paramsDictionaryGenerator:(NSDictionary *)params methodName:(NSString *)methodName;
+ (NSString *)cacheKeyGenerator:(NSDictionary *)params methodName:(NSString *)methodName;
+ (NSString *)commonUserAgentString;
@end
