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

    NSArray<NSDictionary <NSString *, id> *> *albumArray = [self resultsFromDictionary:[self albumDictionary]];
    [self printAlbumDescription:[self objectsFromArray:albumArray]];
}

#pragma mark - JSON Processing

- (nonnull NSDictionary<NSString *, id> *)albumDictionary
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"AlbumResults" ofType:@"json"];
    NSData *fileContents = [[NSData alloc] initWithContentsOfFile:filepath];
    NSError *jsonError;
    NSDictionary<NSString *, id> *parsedJSONDictionary = [NSJSONSerialization JSONObjectWithData:fileContents options:NSJSONReadingMutableContainers error:&jsonError];
    if (parsedJSONDictionary == nil) {
        NSLog(@"Error reading NSData: %@", [jsonError localizedDescription]);
        return [[NSDictionary alloc] init];
    }
    return parsedJSONDictionary;
}

- (nonnull NSArray<NSDictionary <NSString *, id> *> *)resultsFromDictionary:(nonnull NSDictionary<NSString *, id> *)dictionary
{
    return [[NSArray alloc] initWithArray:[dictionary valueForKey:@"results"]];
}

- (nonnull NSArray<Album *> *)objectsFromArray:(nonnull NSArray <NSDictionary<NSString *, id > *> *)dictionaryArray
{
    NSMutableArray<Album *> *albums = [[NSMutableArray alloc] init];
    for (NSDictionary <NSString *, id> *albumDictionary in dictionaryArray) {
        Album *albumToAdd = [[Album alloc] initWithName:[albumDictionary objectForKey:@"collectionName"]
                                             artistName:[albumDictionary objectForKey:@"artistName"]
                                                     ID:[[albumDictionary objectForKey:@"collectionId"] intValue]
                                            releaseDate:[albumDictionary objectForKey:@"releaseDate"]
                                         numberOfTracks:[[albumDictionary objectForKey:@"trackCount"] intValue]
                                                  genre:[albumDictionary objectForKey:@"primaryGenreName"]
                                                  price:[[albumDictionary objectForKey:@"collectionPrice"] floatValue]
                                                country:[albumDictionary objectForKey:@"country"]
                                            explictness:[albumDictionary objectForKey:@"collectionExplicitness"]
                                               artistID:[[albumDictionary objectForKey:@"artistId"] intValue]];
        [albums addObject:albumToAdd];
    }
    return [albums copy];
}

- (void)printAlbumDescription:(nonnull NSArray<Album *> *)albumArray
{
    for (Album *album in albumArray) {
        NSLog(@"%@", [album description]);
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
