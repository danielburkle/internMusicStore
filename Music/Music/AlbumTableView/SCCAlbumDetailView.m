//
// Created by Daniel Burkle on 6/21/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCAlbumDetailView.h"
#import "SCCHeaderDetailView.h"

@implementation SCCAlbumDetailView

#pragma mark - Object Life Cycle

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [self setTitle:[self localizedTitle]];
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureView:[self view]];
    [self configureTableView:[self tableView]];
}

#pragma mark - View Configuration

- (void)configureView:(nonnull UIView *)view
{
    [view setBackgroundColor:[UIColor whiteColor]];
}

- (void)configureTableView:(nonnull UITableView *)tableView
{
    [tableView setRowHeight:UITableViewAutomaticDimension];
    [tableView setEstimatedRowHeight:75.0];
    [tableView setSectionHeaderHeight:UITableViewAutomaticDimension];
    [tableView setEstimatedSectionHeaderHeight:100.0];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SCCHeaderDetailView *album = [[SCCHeaderDetailView alloc] initWithAlbum:_album];
    return album;
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedTitle
{
    return @"Album Details";
}

@end
