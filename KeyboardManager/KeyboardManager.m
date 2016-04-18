//
//  KeyboardManager.m
//  KeyboradManagerDemo
//
//  Created by zhangdong on 16/4/18.
//  Copyright © 2016年 zhangdong. All rights reserved.
//

#import "KeyboardManager.h"

@implementation KeyboardManager

+ (instancetype)defaultManager {
    static KeyboardManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self defaultManager];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return [KeyboardManager defaultManager];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


@end
