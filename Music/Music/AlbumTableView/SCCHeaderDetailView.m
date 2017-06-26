//
// Created by Daniel Burkle on 6/20/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCHeaderDetailView.h"

#import "Album.h"

@implementation SCCHeaderDetailView

static NSString *const SCCHeaderDetailViewNotExplicit = @"notExplicit";

#pragma mark - Object Life Cycle

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithAlbum:(Album *)album
{
    self = [super init];
    if (self) {
        [self initializeLabels];
        [self updateLabelsForAlbum:album];
        [self applyAutoLayoutConstraints];
        [self applyFonts];
        [[self contentView] setBackgroundColor:[UIColor lightGrayColor]];
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)prepareForReuse
{
    [self applyFonts];
}

#pragma mark - Header Customization

- (void)initializeLabels
{
    _albumName = [[UILabel alloc] init];
    _artistName = [[UILabel alloc] init];
    _country = [[UILabel alloc] init];
    _explicitness = [[UILabel alloc] init];
    _genre = [[UILabel alloc] init];
    _releaseDate = [[UILabel alloc] init];
}

- (void)applyFonts
{
    [_albumName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [_artistName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [_country setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [_explicitness setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [_genre setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [_releaseDate setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
}

- (void)updateLabelsForAlbum:(nonnull Album *)album
{
    [_albumName setText:[album name]];
    [_artistName setText:[album artistName]];
    [_country setText:[album country]];
    [_explicitness setText:[self formatExplicitness:[album explicitness]]];
    [_genre setText:[album genre]];
    [_releaseDate setText:[[self dateFormatterProperties] stringFromDate:[album releaseDate]]];
}

#pragma mark - Variable Formatting

- (nonnull NSString *)formatExplicitness:(nonnull NSString *)explicitness
{
    if ([explicitness isEqualToString:SCCHeaderDetailViewNotExplicit]) {
        return [self localizedNotExplicit];
    } else {
        return explicitness;
    }
}

- (nonnull NSDateFormatter *)dateFormatterProperties
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return dateFormatter;
}

#pragma mark - Header Autolayout

- (void)applyAutoLayoutConstraints
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[ _albumName, _artistName, _releaseDate, _explicitness, _genre, _country ]];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    [stackView setSpacing:0];
    [stackView setDistribution:UIStackViewDistributionFillProportionally];
    [stackView setAlignment:UIStackViewAlignmentLeading];

    UIView *view = [self contentView];
    [view addSubview:stackView];

    UILayoutGuide *marginsGuide = [self layoutMarginsGuide];

    [NSLayoutConstraint activateConstraints:@[
        [[stackView leadingAnchor] constraintEqualToAnchor:[marginsGuide leadingAnchor]],
        [[stackView trailingAnchor] constraintEqualToAnchor:[marginsGuide trailingAnchor]],
        [[stackView topAnchor] constraintEqualToAnchor:[[view layoutMarginsGuide] topAnchor]],
        [[stackView bottomAnchor] constraintEqualToAnchor:[[view layoutMarginsGuide] bottomAnchor]]
    ]];
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedNotExplicit
{
    return @"Not Explicit";
}

@end