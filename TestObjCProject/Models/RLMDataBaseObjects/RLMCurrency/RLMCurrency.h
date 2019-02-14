//
//  RLMCurrency.h
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Currency.h"

NS_ASSUME_NONNULL_BEGIN

@interface RLMCurrency : RLMObject

@property NSString *key;
@property NSString *name;
@property NSNumber <RLMInt> *isEnable;
@property NSNumber <RLMDouble> *price;

+ (void)mapCurrencyArrayToRealmDataBaseArray:(NSArray*)array;
+ (void)updateIsEnable:(Currency*)currency;
+ (void)updateAllPricessInArray:(NSArray*)array;

//- (void)checkAndAdd:(RLMCurrency*)object;
//- (RLMCurrency*)createRealmObjectFromLocal:(Currency*)currency;

@end

NS_ASSUME_NONNULL_END
