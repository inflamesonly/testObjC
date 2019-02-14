//
//  RequestManager.h
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestManager : NSObject

+ (RequestManager*)sharedManager;

- (void)getCurrencyList:(void(^)(NSArray *success))list orFalureBlock:(void(^)(NSError *error))falure;
- (void)getNeedCurrencyList:(NSArray*)array success:(void(^)(NSDictionary *success))responseObject orFalureBlock:(void(^)(NSError *error))falure;

@end

NS_ASSUME_NONNULL_END
