//
//  Created by Brian M Coyner on 5/20/14.
//  Copyright (c) 2014 National Information Solutions Cooperative. All rights reserved.
//

#import "AlbumTableViewController.h"

#import "Importer.h"
#import "SubtitleTableViewCell.h"

@interface AlbumTableViewController () {
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

    [self.tableView registerClass:[SubtitleTableViewCell class] forCellReuseIdentifier:[SubtitleTableViewCell cellReuseIdentifier]];

    [[self tableView] setRowHeight:UITableViewAutomaticDimension];
    [[self tableView] setEstimatedRowHeight:75.0];

    _albums = [Importer buildAlbumsFromJson];

    [Importer printAlbums:_albums];
    [Importer printTracks:[Importer buildTracksFromJson]];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_albums count];
}

- (nonnull UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubtitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SubtitleTableViewCell cellReuseIdentifier] forIndexPath:indexPath];
    return [AlbumTableViewController setCellProperties:cell album:_albums[[indexPath row]]];
}

#pragma mark - View Configuration

- (void)configureView:(nonnull UIView *)view
{
    [view setBackgroundColor:[UIColor whiteColor]];
}

+ (nonnull UITableViewCell *)setCellProperties:(SubtitleTableViewCell *)cell album:(Album *)album
{
    [cell setAlbumName:[album name]];
    [cell setArtistName:[album artistName]];
    [cell setReleaseYear:[Album dateString:[album releaseDate]]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedTitle
{
    return @"Albums";
}

@end
