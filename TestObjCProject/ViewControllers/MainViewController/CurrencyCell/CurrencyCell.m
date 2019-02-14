//
//  CurrencyCell.m
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "CurrencyCell.h"

@implementation CurrencyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSwitch];
        [self createLabel];
    }
    return self;
}

- (void)configureFrom:(Currency*)currency fromIndexPath:(NSIndexPath*)indexPath {
    NSMutableString *mNameString = [[NSMutableString alloc] initWithString:currency.name];
    [mNameString insertString:@"/" atIndex:3];
    self.nameLabel.text = mNameString;
    [self.isOnSwitch setOn:currency.isEnable];
    self.isOnSwitch.tag = indexPath.row;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Create ui elements
- (void)createLabel {
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.nameLabel];
    [self addConstraintToSwitch];
    [self addConstraintToLabel];
}

- (void)createSwitch {
    self.isOnSwitch = [[UISwitch alloc] init];
    [self.isOnSwitch setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.isOnSwitch];
    [self addConstraintToSwitch];
}

#pragma mark - UI constraint create
- (void)addConstraintToSwitch {
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.isOnSwitch attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-16];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.isOnSwitch attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:31];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.isOnSwitch attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:51];
    
    NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:self.isOnSwitch attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self addConstraints:@[right,center]];
    [self.isOnSwitch addConstraints:@[width, height]];
}

- (void)addConstraintToLabel {
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:16];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.isOnSwitch attribute:NSLayoutAttributeRight multiplier:1 constant:16];
    NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.isOnSwitch attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self addConstraints:@[left, right, center]];
}

@end
