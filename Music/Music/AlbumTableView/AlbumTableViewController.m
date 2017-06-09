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

    [self configureViewsForView:[self view]];

    [self.tableView registerClass:[SubtitleTableViewCell class] forCellReuseIdentifier:@"SubtitleTableView"];

    _albums = [Importer buildAlbumsFromJson];

    [Importer printAlbumDescription:_albums];
    [Importer printTrackDescription:[Importer buildTracksFromJson]];
}

#pragma mark - View Configuration

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubtitleTableView"
                                                            forIndexPath:indexPath];
    Album *album = _albums[indexPath.row];
    cell.textLabel.text = [album name];
    cell.detailTextLabel.text = [album artistName];

    return cell;
}

- (void)configureViewsForView:(nonnull UIView *)view
{
    [view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedTitle
{
    return @"Albums";
}

@end
