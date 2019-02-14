//
//  RequestManager.m
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "RequestManager.h"
#import <AFNetworking.h>
#import "Currency.h"


static NSString *APIKey = @"dbc0a80dc45a23d1a68ecce161d99fe8";
static NSString *API = @"https://currate.ru/api/";

static NSString *currencyList = @"currency_list";
static NSString *needCurrencyList = @"rates";


@implementation RequestManager

+ (RequestManager*)sharedManager {
    static RequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [RequestManager new];
    });
    return manager;
}

- (void)getCurrencyList:(void(^)(NSArray *success))list orFalureBlock:(void(^)(NSError *error))falure {
    NSDictionary *parameters = @{@"get" : currencyList,
                                 @"key" : APIKey
                                 };
    [self getRequest:API parameters:parameters successBlock:^(NSDictionary *success) {
        NSArray *responseArray = [success valueForKey:@"data"];
        list(responseArray);
    } orFalureBlock:^(NSError *error) {
        
    }];
}

- (void)getNeedCurrencyList:(NSArray*)array success:(void(^)(NSDictionary *success))responseObject orFalureBlock:(void(^)(NSError *error))falure {
    NSDictionary *parameters = @{@"get" : needCurrencyList,
                                 @"key" : APIKey,
                                 @"pairs" : [self needCurrencyListToString:array]
                                 };
    [self getRequest:API parameters:parameters successBlock:^(NSDictionary *success) {
        NSDictionary *responseDict = [success valueForKey:@"data"];
        responseObject(responseDict);
    } orFalureBlock:^(NSError *error) {
        
    }];
}

- (NSString*)needCurrencyListToString:(NSArray*)array {
    NSMutableString *result = [[NSMutableString alloc] init];
    int index = 0;
    for (Currency *currency in array) {
        if (index == 0 || index == array.count) {
            [result appendString:currency.name];
        } else {
            [result appendString:[NSString stringWithFormat:@",%@",currency.name]];
        }
        index++;
    }
    NSLog(@"The concatenated string is %@", result);
    return result;
}


- (AFHTTPSessionManager*)sessionManager {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}

- (void)getRequest:(NSString*)request parameters:(NSDictionary*)parameters successBlock:(void(^)(NSDictionary *success))success orFalureBlock:(void(^)(NSError *error))falure {
    AFHTTPSessionManager *manager = [self sessionManager];
    [manager GET:request parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falure(error);
    }];
}


@end
