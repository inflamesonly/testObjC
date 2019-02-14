//
//  Currency.m
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "Currency.h"
#import "RLMCurrency.h"

@implementation Currency

- (id)initWithName:(NSString*)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.isEnable = false;
    }
    return self;
}

- (id)initWithName:(NSString*)name price:(double)price {
    self = [super init];
    if (self) {
        self.name = name;
        self.isEnable = false;
        self.price = price;
    }
    return self;
}

- (id)initWithRlmObject:(RLMCurrency*)rlmObject {
    self = [super init];
    if (self) {
        self.name = rlmObject.name;
        self.isEnable = [rlmObject.isEnable boolValue];
        self.price = [rlmObject.price doubleValue];
    }
    return self;
}

+ (NSArray*)mapFromStringsArray:(NSArray*)array {
    NSMutableArray *mArray = [NSMutableArray new];
    for (NSString *value in array) {
        Currency *object = [[Currency alloc] initWithName:value];
        [mArray addObject:object];
    }
    return mArray.copy;
}

+ (NSArray*)mapFromDictionariesResponse:(NSDictionary*)dictionary {
    NSMutableArray *mArray = [NSMutableArray new];
    for (int i = 0; i < [dictionary allKeys].count; i++) {
        NSString *key = [dictionary allKeys][i];
        double value = [[dictionary allValues][i] doubleValue];
        Currency *object = [[Currency alloc] initWithName:key price:value];
        [mArray addObject:object];
    }
    return mArray.copy;
}

+ (NSArray*)mapFromRealm {
    NSMutableArray *mArray = [NSMutableArray new];
    for (RLMCurrency *rlmObject in [RLMCurrency allObjects]) {
        Currency *object = [[Currency alloc] initWithRlmObject:rlmObject];
        [mArray addObject:object];
    }
    return mArray;
}

@end
