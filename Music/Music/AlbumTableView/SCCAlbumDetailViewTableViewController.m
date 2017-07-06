//
// Created by Daniel Burkle on 6/21/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCAlbumDetailViewTableViewController.h"

#import "SCCAlbumDetailHeaderView.h"
#import "SCCImporter.h"
#import "SCCTrackTableViewCell.h"

@interface SCCAlbumDetailViewTableViewController () {
    NSArray<SCCTrack *> *_tracks;
}

@end

@implementation SCCAlbumDetailViewTableViewController

#pragma mark - Object Life Cycle

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is init for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"Programmer Error! This initializer is initWithCoder for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    NSLog(@"Programmer Error! This initializer is initWithNibName for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    NSLog(@"Programmer Error! This initializer is initWithStyle for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithAlbum:(SCCAlbum *)album
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [self setTitle:[self localizedTitle]];
        _album = album;
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureView:[self view]];
    [self configureTableView:[self tableView]];

    _tracks = [SCCImporter buildTracksFromJson];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCCTrackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCCAlbumDetailViewTableViewController cellReuseIdentifier] forIndexPath:indexPath];
    SCCTrack *track = _tracks[(NSUInteger)[indexPath row]];
    [SCCAlbumDetailViewTableViewController setUpCell:cell withTrack:track];
    return cell;
}

#pragma mark - UITableView DataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[SCCAlbumDetailHeaderView alloc] initWithAlbum:_album];
}

#pragma mark - View Configuration

- (void)configureView:(nonnull UIView *)view
{
    [view setBackgroundColor:[UIColor whiteColor]];
}

- (void)configureTableView:(nonnull UITableView *)tableView
{
    [tableView registerClass:[SCCTrackTableViewCell class] forCellReuseIdentifier:[SCCAlbumDetailViewTableViewController cellReuseIdentifier]];
    [tableView setRowHeight:UITableViewAutomaticDimension];
    [tableView setEstimatedRowHeight:44.0];
    [tableView setSectionHeaderHeight:UITableViewAutomaticDimension];
    [tableView setEstimatedSectionHeaderHeight:50.0];
    [tableView setBounces:NO];
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
}

+ (void)setUpCell:(nonnull SCCTrackTableViewCell *)cell withTrack:(nonnull SCCTrack *)track
{
    [[cell trackDuration] setText:[self formatDuration:[track duration]]];
    [[cell trackName] setText:[track name]];
    [[cell trackNumber] setText:[NSString stringWithFormat:@"%d", [track trackNumber]]];
}

#pragma mark - String Formatting

+ (nonnull NSString *)formatDuration:(int32_t)duration
{
    long durationTotalSeconds = duration / 1000;
    long minutes = durationTotalSeconds / 60;
    long seconds = lround(durationTotalSeconds) % 60;
    return [NSString stringWithFormat:@"%lu:%02lu", minutes, seconds];
}

+ (nonnull NSString *)cellReuseIdentifier
{
    return NSStringFromClass([SCCTrackTableViewCell class]);
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedTitle
{
    return @"Album Details";
}

@end
