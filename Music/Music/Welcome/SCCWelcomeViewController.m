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

    //Temporary importer of .txt file to output Albums
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"JSON" ofType:@"txt"];
    NSData *fileContents = [[NSData alloc] initWithContentsOfFile:filepath];

    NSError *jsonError;
    NSArray *parsedJSONArray = [NSJSONSerialization JSONObjectWithData:fileContents options:NSJSONReadingMutableContainers error:&jsonError];
    if (jsonError){
        NSLog(@"Error reading NSData: %@", jsonError.localizedDescription);
    }

    NSArray *innerJSONResults = [[NSArray alloc] initWithArray:[parsedJSONArray valueForKey:@"results"]];
    NSMutableArray *albums = [[NSMutableArray alloc] init];

    for (int i = 0; i < innerJSONResults.count; i++){
        NSDictionary *tempDict = innerJSONResults[i];
        Album *albumToAdd = [[Album alloc] initWithJSON:[tempDict valueForKey:@"collectionName"]
                                              albumArtist:[tempDict valueForKey:@"artistName"]
                                                  albumID:[tempDict valueForKey:@"collectionId"]
                                              releaseDate:[tempDict valueForKey:@"releaseDate"]
                                           numberOfTracks:[tempDict valueForKey:@"trackCount"]
                                                    genre:[tempDict valueForKey:@"primaryGenreName"]
                                                    price:[tempDict valueForKey:@"collectionPrice"]
                                                  country:[tempDict valueForKey:@"country"]
                                              explictness:[tempDict valueForKey:@"collectionExplicitness"]];
        [albums addObject:albumToAdd];
    }

    for (int i =0; i < albums.count; i++){
        Album *albumToPrint = albums[i];
        NSLog(albumToPrint.description);
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
