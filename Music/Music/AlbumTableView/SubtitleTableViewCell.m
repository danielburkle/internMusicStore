//
// Created by Daniel Burkle on 6/9/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SubtitleTableViewCell.h"

@implementation SubtitleTableViewCell {
    UILabel *_albumNameValue;
    UILabel *_artistNameValue;
    UILabel *_releaseYearValue;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SubtitleTableViewCell cellReuseIdentifier]];
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureConstraints];
    }
    return self;
}

#pragma mark - Setter Overrides

- (void)setAlbumName:(NSString *)album
{
    if (![album isEqualToString:_albumName]) {
        _albumName = [album copy];
        [_albumNameValue setText:_albumName];
        [_albumNameValue setFont:[UIFont boldSystemFontOfSize:15]];
    }
}

- (void)setArtistName:(NSString *)artist
{
    if (![artist isEqualToString:_artistName]) {
        _artistName = [artist copy];
        [_artistNameValue setText:_artistName];
        [_artistNameValue setFont:[UIFont systemFontOfSize:15]];
    }
}

- (void)setReleaseYear:(NSString *)year
{
    if (![year isEqualToString:_releaseYear]) {
        _releaseYear = [year copy];
        [_releaseYearValue setText:[_releaseYear substringWithRange:NSMakeRange(0, 4)]];
        [_releaseYearValue setFont:[UIFont systemFontOfSize:15]];
    }
}

- (void)configureConstraints
{
    [self initializeUILabels];
    NSMutableArray<NSLayoutConstraint *> *constraints = [[NSMutableArray alloc] init];
    [constraints addObjectsFromArray:[self albumConstraints]];
    [constraints addObjectsFromArray:[self artistConstraints]];
    [constraints addObjectsFromArray:[self releaseYearConstraints]];
    [NSLayoutConstraint activateConstraints:[constraints copy]];
}

- (void)initializeUILabels
{
    _albumNameValue = [[UILabel alloc] init];
    [_albumNameValue setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self contentView] addSubview:_albumNameValue];
    _artistNameValue = [[UILabel alloc] init];
    [_artistNameValue setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self contentView] addSubview:_artistNameValue];
    _releaseYearValue = [[UILabel alloc] init];
    [_releaseYearValue setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self contentView] addSubview:_releaseYearValue];
}

- (nonnull NSArray<NSLayoutConstraint *> *)albumConstraints
{
    NSMutableArray<NSLayoutConstraint *> *albumConstraints = [[NSMutableArray alloc] init];
    NSLayoutConstraint *albumLeftConstraint = [NSLayoutConstraint constraintWithItem:_albumNameValue
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:[self contentView]
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1.0
                                                                            constant:15];
    NSLayoutConstraint *albumTopConstraint = [NSLayoutConstraint constraintWithItem:_albumNameValue
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:[self contentView]
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1.0
                                                                           constant:10];
    NSLayoutConstraint *albumRightConstraint = [NSLayoutConstraint constraintWithItem:_albumNameValue
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:[self contentView]
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0
                                                                             constant:0];
    [albumConstraints addObject:albumLeftConstraint];
    [albumConstraints addObject:albumTopConstraint];
    [albumConstraints addObject:albumRightConstraint];
    return [albumConstraints copy];
}

- (nonnull NSArray<NSLayoutConstraint *> *)artistConstraints
{
    NSMutableArray<NSLayoutConstraint *> *artistConstraints = [[NSMutableArray alloc] init];
    NSLayoutConstraint *artistLeftConstraint = [NSLayoutConstraint constraintWithItem:_artistNameValue
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:_albumNameValue
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0
                                                                             constant:0];
    NSLayoutConstraint *artistTopConstraint = [NSLayoutConstraint constraintWithItem:_artistNameValue
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:_albumNameValue
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0
                                                                            constant:0];
    NSLayoutConstraint *artistRightConstraint = [NSLayoutConstraint constraintWithItem:_artistNameValue
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:_albumNameValue
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1.0
                                                                              constant:0];
    [artistConstraints addObject:artistLeftConstraint];
    [artistConstraints addObject:artistTopConstraint];
    [artistConstraints addObject:artistRightConstraint];
    return [artistConstraints copy];
}

- (nonnull NSArray<NSLayoutConstraint *> *)releaseYearConstraints
{
    NSMutableArray<NSLayoutConstraint *> *releaseYearConstraints = [[NSMutableArray alloc] init];
    NSLayoutConstraint *releaseYearLeftConstraint = [NSLayoutConstraint constraintWithItem:_releaseYearValue
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:_artistNameValue
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                multiplier:1.0
                                                                                  constant:0];
    NSLayoutConstraint *releaseYearTopConstraint = [NSLayoutConstraint constraintWithItem:_releaseYearValue
                                                                                attribute:NSLayoutAttributeTop
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:_artistNameValue
                                                                                attribute:NSLayoutAttributeBottom
                                                                               multiplier:1.0
                                                                                 constant:0];
    NSLayoutConstraint *releaseYearRightConstraint = [NSLayoutConstraint constraintWithItem:_releaseYearValue
                                                                                  attribute:NSLayoutAttributeRight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:_artistNameValue
                                                                                  attribute:NSLayoutAttributeRight
                                                                                 multiplier:1.0
                                                                                   constant:0];
    NSLayoutConstraint *releaseYearBottomConstraint = [NSLayoutConstraint constraintWithItem:_releaseYearValue
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:[self contentView]
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                  multiplier:1.0
                                                                                    constant:-10];
    [releaseYearConstraints addObject:releaseYearLeftConstraint];
    [releaseYearConstraints addObject:releaseYearTopConstraint];
    [releaseYearConstraints addObject:releaseYearRightConstraint];
    [releaseYearConstraints addObject:releaseYearBottomConstraint];
    return [releaseYearConstraints copy];
}

+ (nonnull NSString *)cellReuseIdentifier
{
    return NSStringFromClass([SubtitleTableViewCell class]);
}

@end
