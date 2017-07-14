//
//  Created by Brian M Coyner on 5/20/14.
//  Copyright (c) 2014 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCAlbumTableViewController.h"

#import "SCCImporter.h"
#import "SCCAlbumTableViewCell.h"
#import "SCCAlbumDetailViewTableViewController.h"
#import "SCCPerformSearchOperation.h"

@interface SCCAlbumTableViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    NSArray<SCCAlbum *> *_albums;
    SCCAlbum *_album;
    UISearchController *_searchController;
    UIActivityIndicatorView *_loadingIcon;
    SCCPerformSearchOperation *_searchOperation;
}

@end

static NSString *const SCCAlbumTableViewControllerQueueName = @"coop.nisc.scc.backgroundqueue";

@implementation SCCAlbumTableViewController

CGFloat const albumCellEstimatedHeight = 75.0;
static NSString *const searchPlaceholder = @"Search Albums";

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

    [self configureSearchController];
    [self setDefinesPresentationContext:YES];
    [self configureView:[self view]];
    [self configureNavigationItem:[self navigationItem] searchController:_searchController];
    [self configureTableView:[self tableView]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self cancelOperation];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCCAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCCAlbumTableViewController cellReuseIdentifier] forIndexPath:indexPath];
    return [SCCAlbumTableViewController updateCell:cell withAlbum:_albums[(NSUInteger)[indexPath row]]];
}

#pragma mark - View Configuration

- (void)configureView:(nonnull UIView *)view
{
    [view setBackgroundColor:[UIColor whiteColor]];
    [[self tableView] setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (void)configureNavigationItem:(UINavigationItem *)navigationItem searchController:(UISearchController *)searchController
{
    [navigationItem setTitleView:[searchController searchBar]];
}

- (void)configureSearchController
{
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [_searchController setHidesNavigationBarDuringPresentation:NO];
    [_searchController setDimsBackgroundDuringPresentation:YES];
    [self configureSearchBarForSearchController:_searchController];
}

- (void)configureSearchBarForSearchController:(UISearchController *)searchController
{
    UISearchBar *searchBar = [searchController searchBar];
    [searchBar setPlaceholder:searchPlaceholder];
    [searchBar setDelegate:self];
    [searchBar sizeToFit];
    [searchBar setBarStyle:UIBarStyleDefault];
}

- (void)configureTableView:(nonnull UITableView *)tableView
{
    [tableView registerClass:[SCCAlbumTableViewCell class] forCellReuseIdentifier:[SCCAlbumTableViewController cellReuseIdentifier]];
    [tableView setRowHeight:UITableViewAutomaticDimension];
    [tableView setEstimatedRowHeight:albumCellEstimatedHeight];
}

+ (nonnull UITableViewCell *)updateCell:(nonnull SCCAlbumTableViewCell *)cell withAlbum:(nonnull SCCAlbum *)album
{
    [[cell albumName] setText:[album name]];
    [[cell artistName] setText:[album artistName]];
    [[cell releaseYear] setText:[self formattedYearFromDate:[album releaseDate]]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
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

#pragma mark - UISearchController Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_loadingIcon stopAnimating];
    [_searchController resignFirstResponder];
    [self activityIndicatorStartAnimating];
    [self cancelOperation];
    SCCAlbumTableViewController *__weak weakSelf = self;
    _searchOperation = [[SCCPerformSearchOperation alloc] initWithSearchCriteria:[[NSString alloc] initWithFormat:@"%@", [searchBar text]]];
    [_searchOperation setOperationCompletion:^(NSArray<SCCAlbum *> *albums, NSError *error) {
        if (albums != nil) {
            _albums = albums;
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
    [_searchController setActive:NO];
}

- (nonnull NSOperationQueue *)searchOperationQueue
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:1];
    [queue setName:SCCAlbumTableViewControllerQueueName];
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
    _album = _albums[(NSUInteger)[indexPath row]];
    SCCAlbumDetailViewTableViewController *albumDetailView = [[SCCAlbumDetailViewTableViewController alloc] initWithAlbum:_album];
    [[self navigationController] pushViewController:albumDetailView animated:YES];
}

#pragma mark - String Formatting

+ (nonnull NSString *)formattedYearFromDate:(nonnull NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    return [dateFormatter stringFromDate:date];
}

+ (nonnull NSString *)cellReuseIdentifier
{
    return NSStringFromClass([SCCAlbumTableViewCell class]);
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedTitle
{
    return @"Albums";
}

@end
