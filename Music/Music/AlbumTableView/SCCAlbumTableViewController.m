//
//  Created by Brian M Coyner on 5/20/14.
//  Copyright (c) 2014 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCAlbumTableViewController.h"

#import "SCCImporter.h"
#import "SCCAlbumTableViewCell.h"
#import "SCCAlbumDetailViewTableViewController.h"

@interface SCCAlbumTableViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSArray<SCCAlbum *> *_albums;
    SCCAlbum *_album;
}

@end

@implementation SCCAlbumTableViewController

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

    _albums = [SCCImporter buildAlbumsFromJson];
    [SCCImporter printAlbums:_albums];
    [SCCImporter printTracks:[SCCImporter buildTracksFromJson]];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCCAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCCAlbumTableViewController cellReuseIdentifier] forIndexPath:indexPath];
    return [SCCAlbumTableViewController updateCell:cell withAlbum:_albums[[indexPath row]]];
}

#pragma mark - View Configuration

- (void)configureView:(nonnull UIView *)view
{
    [view setBackgroundColor:[UIColor whiteColor]];
}

- (void)configureTableView:(nonnull UITableView *)tableView
{
    [tableView registerClass:[SCCAlbumTableViewCell class] forCellReuseIdentifier:[SCCAlbumTableViewController cellReuseIdentifier]];
    [tableView setRowHeight:UITableViewAutomaticDimension];
    [tableView setEstimatedRowHeight:75.0];
}

+ (nonnull UITableViewCell *)updateCell:(nonnull SCCAlbumTableViewCell *)cell withAlbum:(nonnull SCCAlbum *)album
{
    [[cell albumName] setText:[album name]];
    [[cell artistName] setText:[album artistName]];
    [[cell releaseYear] setText:[self formattedYearFromDate:[album releaseDate]]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _album = _albums[(NSUInteger)[indexPath row]];
    SCCAlbumDetailViewTableViewController *albumDetailView = [[SCCAlbumDetailViewTableViewController alloc] initWithAlbum:_album];
    [[self navigationController] pushViewController:albumDetailView animated:YES];
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedTitle
{
    return @"Albums";
}

@end
