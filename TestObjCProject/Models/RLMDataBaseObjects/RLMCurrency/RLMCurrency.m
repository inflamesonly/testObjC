//
//  RLMCurrency.m
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "RLMCurrency.h"

@implementation RLMCurrency

+ (NSString *)primaryKey {
    return @"key";
}

- (id)initWithName:(NSString*)name price:(double)price {
    self = [super init];
    if (self) {
        self.name = name;
        self.key = name;
        self.isEnable = @(0);
        self.price = @(price);
    }
    return self;
}

+ (void)addToDataBase:(RLMCurrency*)object {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] addObject:object];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)removeFromDataBase:(RLMCurrency*)object {
    RLMCurrency *currency = [RLMCurrency objectForPrimaryKey: object.key];
    
    if (currency) {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [[RLMRealm defaultRealm] addObject:object];
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }
}

+ (void)updateIsEnable:(Currency*)currency {
    RLMCurrency *rlmObject = [RLMCurrency objectForPrimaryKey: currency.name];
    if (rlmObject) {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        rlmObject.isEnable = @(currency.isEnable);
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }
}

+ (void)updateIsPrice:(Currency*)currency {
    RLMCurrency *rlmObject = [RLMCurrency objectForPrimaryKey: currency.name];
    if (rlmObject) {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        rlmObject.price = @(currency.price);
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }
}

+ (void)checkAndAdd:(RLMCurrency*)object {
    RLMCurrency *currency = [RLMCurrency objectForPrimaryKey: object.key];
    if (!currency) {
        [self addToDataBase:object];
    }
}

+ (RLMCurrency*)createRealmObjectFromLocal:(Currency*)currency {
    RLMCurrency *rlmObject = [[RLMCurrency alloc] init];
    rlmObject.key = currency.name;
    rlmObject.name = currency.name;
    rlmObject.price = @(currency.price);
    rlmObject.isEnable = @(currency.isEnable);
    return rlmObject;
}

+ (void)mapCurrencyArrayToRealmDataBaseArray:(NSArray*)array {
    for (Currency *currency in array) {
        RLMCurrency *rlmObject = [self createRealmObjectFromLocal:currency];
        [RLMCurrency checkAndAdd:rlmObject];
    }
}

+ (void)updateAllPricessInArray:(NSArray*)array {
    for (Currency *currency in array) {
        [RLMCurrency updateIsPrice:currency];
    }
}

@end
