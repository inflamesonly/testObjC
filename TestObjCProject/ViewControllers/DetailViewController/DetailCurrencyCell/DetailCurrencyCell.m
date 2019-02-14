//
//  DetailCurrencyCell.m
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "DetailCurrencyCell.h"

@implementation DetailCurrencyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createPriceLabel];
        [self createNameLabel];
    }
    return self;
}

- (void)configureFrom:(Currency*)currency fromIndexPath:(NSIndexPath*)indexPath {
    NSMutableString *mNameString = [[NSMutableString alloc] initWithString:currency.name];
    [mNameString insertString:@"/" atIndex:3];
    
    self.nameLabel.text = mNameString;
    self.priceLabel.text = [NSString stringWithFormat:@"%.3f",currency.price];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Create ui elements
- (void)createNameLabel {
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.nameLabel];
    [self addConstraintToPriceLabel];
    [self addConstraintToNameLabel];
}

- (void)createPriceLabel {
    self.priceLabel = [[UILabel alloc] init];
    [self.priceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.priceLabel];
    self.priceLabel.textAlignment = NSTextAlignmentRight;
}

#pragma mark - UI constraint create
- (void)addConstraintToPriceLabel {
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.priceLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-16];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.priceLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:120];
    
    NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:self.priceLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self addConstraints:@[right,center]];
    [self.priceLabel addConstraints:@[width]];
}

- (void)addConstraintToNameLabel {
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:16];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.priceLabel attribute:NSLayoutAttributeRight multiplier:1 constant:16];
    NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.priceLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self addConstraints:@[left, right, center]];
}

@end
