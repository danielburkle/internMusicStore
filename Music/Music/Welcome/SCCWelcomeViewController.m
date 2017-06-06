//
//  Created by Brian M Coyner on 5/20/14.
//  Copyright (c) 2014 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCWelcomeViewController.h"

#import "Album.h"

@implementation SCCWelcomeViewController

#pragma mark - Object Life Cycle

- (instancetype)init
{
    self = [super init];
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

    NSArray *albumArray = [self retrieveAlbumArrayFromDictionary:[self retrieveAlbumDictionaryFromJSONFile]];
    [self dumpAlbumObject:[self albumArrayFromDictionary:albumArray]];
}

#pragma mark - JSON Processing

- (nonnull NSDictionary<NSString *, id> *)retrieveAlbumDictionaryFromJSONFile
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"AlbumResults" ofType:@"json"];
    NSData *fileContents = [[NSData alloc] initWithContentsOfFile:filepath];
    NSError *jsonError;
    NSDictionary<NSString *, id> *parsedJSONArray = [NSJSONSerialization JSONObjectWithData:fileContents options:NSJSONReadingMutableContainers error:&jsonError];
    if (jsonError) {
        NSLog(@"Error reading NSData: %@", [jsonError localizedDescription]);
    }
    return parsedJSONArray;
}

- (nonnull NSArray<NSDictionary <NSString *, id> *> *)retrieveAlbumArrayFromDictionary:(nonnull NSDictionary<NSString *, id> *)JsonDictionary
{
    NSArray<NSDictionary <NSString *, id> *> *innerJsonResults = [[NSArray alloc] initWithArray:[JsonDictionary valueForKey:@"results"]];
    return innerJsonResults;
}

- (nonnull NSArray<Album *> *)albumArrayFromDictionary:(nonnull NSArray <NSDictionary<NSString *, id > *> *)dictionaryArray
{
    NSMutableArray<Album *> *albums = [[NSMutableArray alloc] init];
    for (int i = 0; i < [dictionaryArray count]; i++) {
        NSDictionary<NSString *, id> *tempDict = dictionaryArray[i];
        Album *albumToAdd = [[Album alloc] initWithAlbumName:[tempDict valueForKey:@"collectionName"]
                                                 albumArtist:[tempDict valueForKey:@"artistName"]
                                                     albumID:[tempDict valueForKey:@"collectionId"]
                                                 releaseDate:[tempDict valueForKey:@"releaseDate"]
                                              numberOfTracks:[tempDict valueForKey:@"trackCount"]
                                                       genre:[tempDict valueForKey:@"primaryGenreName"]
                                                       price:[tempDict valueForKey:@"collectionPrice"]
                                                     country:[tempDict valueForKey:@"country"]
                                                 explictness:[tempDict valueForKey:@"collectionExplicitness"]
                                                    artistID:[tempDict valueForKey:@"artistId"]];
        [albums addObject:albumToAdd];
    }
    NSArray<Album *> *nonMutableArray = [[NSArray alloc] initWithArray:albums];
    return nonMutableArray;
}

- (void)dumpAlbumObject:(nonnull NSArray<Album *> *)albumArray
{
    for (int i = 0; i < [albumArray count]; i++) {
        Album *albumToPrint = albumArray[i];
        NSLog([albumToPrint description]);
    }
}

#pragma mark - View Configuration

- (void)configureViewsForView:(nonnull UIView *)view
{
    [view setBackgroundColor:[UIColor whiteColor]];

    [self addWelcomeMessageLabelToView:view];
}

- (void)addWelcomeMessageLabelToView:(nonnull UIView *)view
{
    UILabel *welcomeLabel = [self labelForDisplayingWelcomeMessage];

    [view addSubview:welcomeLabel];

    [self addCenterConstraintsToLabel:welcomeLabel inView:view];
}

- (nonnull UILabel *)labelForDisplayingWelcomeMessage
{
    UILabel *label = [[UILabel alloc] init];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [label setText:[self localizedWelcomeMessage]];
    return label;
}

- (void)addCenterConstraintsToLabel:(nonnull UILabel *)label inView:(nonnull UIView *)view
{
    [NSLayoutConstraint activateConstraints:@[
        [[label centerXAnchor] constraintEqualToAnchor:[view centerXAnchor]],
        [[label centerYAnchor] constraintEqualToAnchor:[view centerYAnchor]]
    ]];
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedTitle
{
    return @"Welcome";
}

- (nonnull NSString *)localizedWelcomeMessage
{
    return @"Welcome To NISC!";
}

@end
