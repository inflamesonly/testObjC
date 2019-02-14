//
//  DetailViewController.m
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCurrencyCell.h"
#import "RequestManager.h"
#import "Currency.h"
#import "RLMCurrency.h"


@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *currencyTableView;

@end


@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupStartView];
    [self createTableView];
    [self getCurrencyList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTableViewConstraint];
}

#pragma mark - API request
- (void)getCurrencyList {
    [self.currencyTableView setHidden:YES];
    [self startActivity];
    [[RequestManager sharedManager] getNeedCurrencyList:self.currencyArray success:^(NSDictionary * _Nonnull success) {
        self.currencyArray = [Currency mapFromDictionariesResponse:success];
        [RLMCurrency updateAllPricessInArray:self.currencyArray];
        [self.currencyTableView reloadData];
        [self.currencyTableView setHidden:NO];
        [self stopActivity];
    } orFalureBlock:^(NSError * _Nonnull error) {
        [UIAlertController showAlertInViewController:self withTitle:@"Error"  message:@"Server error" cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:nil];
    }];
}

#pragma mark - UI constraint create
- (void)setupTableViewConstraint {
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.currencyTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.currencyTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.currencyTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.currencyTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    
    [self.view addConstraints:@[left, top, right, bottom]];
}

#pragma mark - Create ui elements
- (void)setupStartView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.currencyTableView registerClass:[DetailCurrencyCell class] forCellReuseIdentifier:@"DetailCurrencyCell"];
    self.title = @"Detail";
}

- (void)createTableView {
    self.currencyTableView = [[UITableView alloc] init];
    self.currencyTableView.dataSource = self;
    self.currencyTableView.delegate = self;
    [self.currencyTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.currencyTableView];
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currencyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self configureFromTableView:tableView cellForRowAtIndexPath:indexPath];
}

- (DetailCurrencyCell*)configureFromTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCurrencyCell *cell = (DetailCurrencyCell *)[tableView dequeueReusableCellWithIdentifier:@"DetailCurrencyCell"];
    if (cell == nil) {
        cell = [[DetailCurrencyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailCurrencyCell"];
    }
    
    Currency *currency = self.currencyArray[indexPath.row];
    [cell configureFrom:currency fromIndexPath:indexPath];
    
    return cell;
}

@end
