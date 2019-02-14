//
//  DetailCurrencyCell.h
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailCurrencyCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *priceLabel;

- (void)configureFrom:(Currency*)currency fromIndexPath:(NSIndexPath*)indexPath;

@end

NS_ASSUME_NONNULL_END
