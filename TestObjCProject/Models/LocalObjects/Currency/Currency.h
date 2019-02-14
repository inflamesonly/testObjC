//
//  Currency.h
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Currency : NSObject

@property (weak, nonatomic) NSString *name;
@property BOOL isEnable;
@property double price;

- (id)initWithName:(NSString*)name;
+ (NSArray*)mapFromStringsArray:(NSArray*)array;
+ (NSArray*)mapFromDictionariesResponse:(NSDictionary*)dictionary;

+ (NSArray*)mapFromRealm;

@end

NS_ASSUME_NONNULL_END
