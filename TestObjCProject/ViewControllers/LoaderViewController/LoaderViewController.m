//
//  LoaderViewController.m
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "LoaderViewController.h"

@interface LoaderViewController ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation LoaderViewController

- (void)startActivity {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = self.view.center;
    [self.activityIndicator startAnimating];
}

- (void)stopActivity {
    [self.activityIndicator removeFromSuperview];
}

@end
