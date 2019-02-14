//
//  DetailViewController.h
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoaderViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : LoaderViewController

@property (strong, nonatomic) NSArray *currencyArray;

@end

NS_ASSUME_NONNULL_END
