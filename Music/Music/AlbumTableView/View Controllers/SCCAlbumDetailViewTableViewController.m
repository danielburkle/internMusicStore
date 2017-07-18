//
// Created by Daniel Burkle on 6/21/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCAlbumDetailViewTableViewController.h"

#import "SCCAlbumDetailHeaderView.h"
#import "SCCTrackTableViewCell.h"
#import "SCCTrackDetailViewUIViewController.h"
#import "SCCUtility.h"
#import "SCCPerformSearchOperation.h"
#import "SCCAlbum.h"
#import "SCCTrack.h"

@interface SCCAlbumDetailViewTableViewController () {
    NSArray<SCCTrack *> *_tracks;
    UIActivityIndicatorView *_loadingIcon;
    SCCPerformSearchOperation *_searchOperation;
}

@end

static NSString *const SCCAlbumDetailViewTableViewControllerQueueName = @"coop.nisc.scc.backgroundqueue";

@implementation SCCAlbumDetailViewTableViewController

CGFloat const trackCellEstimatedHeight = 44.0;
CGFloat const albumHeaderEstimatedHeight = 50.0;

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
    [self updateSearchResults];
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
    [tableView setEstimatedRowHeight:trackCellEstimatedHeight];
    [tableView setSectionHeaderHeight:UITableViewAutomaticDimension];
    [tableView setEstimatedSectionHeaderHeight:albumHeaderEstimatedHeight];
    [tableView setBounces:NO];
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
}

+ (void)setUpCell:(nonnull SCCTrackTableViewCell *)cell withTrack:(nonnull SCCTrack *)track
{
    [[cell trackDuration] setText:[SCCUtility formatDuration:[track duration]]];
    [[cell trackName] setText:[track name]];
    [[cell trackNumber] setText:[NSString stringWithFormat:@"%d", [track trackNumber]]];
}

- (void)activityIndicatorStartAnimating
{
    [[self tableView] setUserInteractionEnabled:NO];
    _loadingIcon = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_loadingIcon startAnimating];
    [_loadingIcon setCenter:[[self view] center]];
    [[self view] addSubview:_loadingIcon];
}

- (void)configureErrorAlertWithError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Search Failed"
                                                                   message:[[NSString alloc] initWithFormat:@"%@", [error localizedDescription]]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                          }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Search Operation Delegate

- (void)updateSearchResults
{
    [_loadingIcon stopAnimating];
    [self activityIndicatorStartAnimating];
    [self cancelOperation];
    SCCAlbumDetailViewTableViewController *__weak weakSelf = self;
    _searchOperation = [[SCCPerformSearchOperation alloc] initWithSearchCriteria:[[NSString alloc] initWithFormat:@"%d", [_album albumID]] entityType:NSStringFromClass([SCCTrack class])];
    [_searchOperation setOperationCompletion:^(NSArray<SCCTrack *> *tracks, NSError *error) {
        if (tracks != nil) {
            _tracks = tracks;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf searchOperationDidFinish];
            });
        }
        if (error != NULL) {
            [weakSelf searchOperationDidFinishWithError:error];
        }
    }];
    [[self searchOperationQueue] addOperation:_searchOperation];
}

- (void)searchOperationDidFinish
{
    [[self tableView] reloadData];
    [_loadingIcon stopAnimating];
    [[self tableView] setUserInteractionEnabled:YES];
}

- (nonnull NSOperationQueue *)searchOperationQueue
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:1];
    [queue setName:SCCAlbumDetailViewTableViewControllerQueueName];
    return queue;
}

- (void)cancelOperation
{
    [_searchOperation cancel];
    _searchOperation = nil;
}

- (void)searchOperationDidFinishWithError:(nonnull NSError *)error
{
    [_loadingIcon stopAnimating];
    [self configureErrorAlertWithError:error];
    [[self tableView] reloadData];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCCTrack *track = _tracks[(NSUInteger)[indexPath row]];
    SCCTrackDetailViewUIViewController *trackDetailView = [[SCCTrackDetailViewUIViewController alloc] initWithTrack:track];
    [[self navigationController] pushViewController:trackDetailView animated:YES];
}

#pragma mark - String Formatting

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
