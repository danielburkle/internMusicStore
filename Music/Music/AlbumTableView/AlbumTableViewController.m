//
//  Created by Brian M Coyner on 5/20/14.
//  Copyright (c) 2014 National Information Solutions Cooperative. All rights reserved.
//

#import "AlbumTableViewController.h"

#import "Importer.h"
#import "SubtitleTableViewCell.h"

@interface AlbumTableViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSArray<Album *> *_albums;
}

@end

@implementation AlbumTableViewController

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

    _albums = [Importer buildAlbumsFromJson];
    [Importer printAlbums:_albums];
    [Importer printTracks:[Importer buildTracksFromJson]];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_albums count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SubtitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AlbumTableViewController cellReuseIdentifier] forIndexPath:indexPath];
    return [AlbumTableViewController updateCell:cell withAlbum:_albums[[indexPath row]]];
}

#pragma mark - View Configuration

- (void)configureView:(nonnull UIView *)view
{
    [view setBackgroundColor:[UIColor whiteColor]];
}

- (void)configureTableView:(nonnull UITableView *)tableView
{
    [tableView registerClass:[SubtitleTableViewCell class] forCellReuseIdentifier:[AlbumTableViewController cellReuseIdentifier]];
    [tableView setRowHeight:UITableViewAutomaticDimension];
    [tableView setEstimatedRowHeight:75.0];
}

+ (nonnull UITableViewCell *)updateCell:(nonnull SubtitleTableViewCell *)cell withAlbum:(nonnull Album *)album
{
    [[cell albumName] setText:[album name]];
    [[cell artistName] setText:[album artistName]];
    [[cell releaseYear] setText:[self releaseYearFromReleaseDate:[album releaseDate]]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark - String Formatting

+ (nonnull NSString *)releaseYearFromReleaseDate:(nonnull NSDate *)releaseDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    return [dateFormatter stringFromDate:releaseDate];
}

+ (nonnull NSString *)cellReuseIdentifier
{
    return NSStringFromClass([SubtitleTableViewCell class]);
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedTitle
{
    return @"Albums";
}

@end
