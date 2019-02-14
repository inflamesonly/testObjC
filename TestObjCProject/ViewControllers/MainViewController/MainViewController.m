//
//  ViewController.m
//  TestObjCProject
//
//  Created by macOS on 13.02.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "MainViewController.h"
#import "CurrencyCell.h"
#import "RequestManager.h"
#import "Currency.h"
#import "DetailViewController.h"
#import "RLMCurrency.h"


@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *currencyTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) NSArray *currencyArray;

@end


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupStartView];
    [self createTableView];
    [self createNavigationInfoButton];
    [self addRefreshControl];
    [self checkFromGetLocalElementsOrServer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTableViewConstraint];
    [self createRefreshLabel];
}

- (void)checkFromGetLocalElementsOrServer {
    if ([RLMCurrency allObjects].count != 0) {
        self.currencyArray = [Currency mapFromRealm];
    } else {
        [self getCurrencyList];
    }
}

#pragma mark - Create ui elements
- (void)addRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl  addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    if (@available(iOS 10.0, *)) {
        self.currencyTableView.refreshControl = self.refreshControl;
    } else {
        [self.currencyTableView addSubview:self.refreshControl];
    }
}

- (void)refreshTable {
    //TODO: refresh your data
    [self.refreshControl endRefreshing];
    [self getCurrencyList];
}

- (void)createNavigationInfoButton {
    UIBarButtonItem *infoButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Get info"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(showInfo)];
    self.navigationItem.rightBarButtonItem = infoButton;
}

- (void)setupStartView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.currencyTableView registerClass:[CurrencyCell class] forCellReuseIdentifier:@"CurrencyCell"];
    self.title = @"Main";
}

- (void)createTableView {
    self.currencyTableView = [[UITableView alloc] init];
    self.currencyTableView.dataSource = self;
    self.currencyTableView.delegate = self;
    [self.currencyTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.currencyTableView];
}

- (void)createRefreshLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"pull down ↓ to update the table";
    label.textColor = [UIColor lightGrayColor];
    [label sizeToFit];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:label];
    [self setupLabelConstraint:label];
}

#pragma mark - UI constraint create
- (void)setupLabelConstraint:(UILabel*)label {
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-32];
    [self.view addConstraints:@[centerX, bottom]];
}

- (void)setupTableViewConstraint {
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.currencyTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.currencyTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.currencyTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.currencyTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    
    [self.view addConstraints:@[left, top, right, bottom]];
}

#pragma mark - Actions
- (void)showInfo {
    if ([self getAllEnebleObjects].count == 0) {
        [UIAlertController showAlertInViewController:self withTitle:@"Error"  message:@"No active pairs selected" cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:nil];
        NSLog(@"Array is empty");
    } else {
        [self showDetailViewController];
        NSLog(@"Array is not empty");
    }
}

- (void)showDetailViewController {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.currencyArray = [self getAllEnebleObjects];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - API request
- (void)getCurrencyList {
    [self.currencyTableView setHidden:YES];
    [self startActivity];
    [[RequestManager sharedManager] getCurrencyList:^(NSArray * _Nonnull success) {
        self.currencyArray = [Currency mapFromStringsArray:success];
        [RLMCurrency mapCurrencyArrayToRealmDataBaseArray:self.currencyArray];
        [self.currencyTableView reloadData];
        [self.currencyTableView setHidden:NO];
        [self stopActivity];
    } orFalureBlock:^(NSError * _Nonnull error) {
        [UIAlertController showAlertInViewController:self withTitle:@"Error"  message:@"Server error" cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:nil];
    }];
}

#pragma mark - Work with local object (Currency)
- (NSArray*)getAllEnebleObjects {
    NSMutableArray *mArray = [NSMutableArray new];
    for (Currency *currency in self.currencyArray) {
        if (currency.isEnable) {
            [mArray addObject:currency];
        }
    }
    return mArray.copy;
}

- (void)updateObjectAtIndex:(NSInteger)index {
    Currency *currency = self.currencyArray[index];
    CurrencyCell *cell = [self.currencyTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    currency.isEnable = !currency.isEnable;
    [cell.isOnSwitch setSelected:currency.isEnable];
    [RLMCurrency updateIsEnable:currency];
    [self updateObject:currency arrayFromIndex:index];
    [self updateCellFromIndex:index];
}

- (void)updateCellFromIndex:(NSInteger)index {
    [self.currencyTableView beginUpdates];
    [self.currencyTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.currencyTableView endUpdates];
}

- (void)updateObject:(Currency*)currency arrayFromIndex:(NSInteger)index {
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithArray:self.currencyArray];
    [mArray removeObjectAtIndex:index];
    [mArray insertObject:currency atIndex:index];
    self.currencyArray = mArray.copy;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self updateObjectAtIndex:indexPath.row];
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

- (CurrencyCell*)configureFromTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CurrencyCell *cell = (CurrencyCell *)[tableView dequeueReusableCellWithIdentifier:@"CurrencyCell"];
    if (cell == nil) {
        cell = [[CurrencyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CurrencyCell"];
    }
    
    Currency *currency = self.currencyArray[indexPath.row];
    [cell configureFrom:currency fromIndexPath:indexPath];
    [cell.isOnSwitch addTarget:self action:@selector(switchToggled:) forControlEvents: UIControlEventTouchUpInside];
    return cell;
}

- (void)switchToggled:(UISwitch *)sender {
    [self updateObjectAtIndex:sender.tag];
}

@end
