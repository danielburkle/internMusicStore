//
//  Created by Daniel Burkle on 8/8/17.
//  Copyright © 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCArtist.h"

@implementation SCCArtist

static NSString *const ArtistName = @"artistName";
static NSString *const ArtistID = @"artistId";
static NSString *const ArtistGenre = @"primaryGenreName";

#pragma mark - Object Life Cycle

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithDictionary:(nonnull NSDictionary<NSString *, id> *)dictionary
{
    self = [super init];

    if (self) {
        _name = [dictionary objectForKey:ArtistName];
        _ID = [[dictionary objectForKey:ArtistID] intValue];
        _genre = [dictionary objectForKey:ArtistGenre];
    }
    return self;
}

#pragma mark - NSObject Implementation

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"Artist: %@, Artist ID: %d, Genre: %@", _name, _ID, _genre];
}

@end
