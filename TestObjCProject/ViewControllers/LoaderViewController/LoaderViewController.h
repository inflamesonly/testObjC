//
//  LoaderViewController.h
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAlertController+Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoaderViewController : UIViewController

- (void)startActivity;
- (void)stopActivity;

@end

NS_ASSUME_NONNULL_END
