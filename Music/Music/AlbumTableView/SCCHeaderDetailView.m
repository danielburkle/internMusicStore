//
// Created by Daniel Burkle on 6/20/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCHeaderDetailView.h"

#import "Album.h"
#import "SCCAlbumPlaceholderArt.h"

@interface SCCHeaderDetailView () {
    Album *_album;
    UIImageView *_albumArt;
    NSMutableArray *_constraints;
}

@end

@implementation SCCHeaderDetailView

static NSString *const SCCHeaderDetailViewCleaned = @"cleaned";
static NSString *const SCCHeaderDetailViewNotExplicit = @"notExplicit";

#pragma mark - Object Life Cycle

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is init for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"Programmer Error! This initializer is initWithCoder for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    NSLog(@"Programmer Error! This initializer is initWithReuseIdentifier for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithAlbum:(Album *)album
{
    self = [super initWithReuseIdentifier:nil];
    if (self) {
        _album = album;
        [self configureHeader];
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)prepareForReuse
{
    [self applyFonts];
}

#pragma mark - Header Customization

- (void)configureHeader
{
    [self initializeAlbumArt];
    [self initializeLabels];
    [self updateLabelsForAlbum:_album];
    [self applyAutoLayoutConstraints];
    [self applyFonts];
    [[self contentView] setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)initializeAlbumArt
{
    _albumArt = [SCCAlbumPlaceholderArt placeholderArtFromLocalFile];
}

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
    [_releaseDate setText:[[self configureDateFormatter] stringFromDate:[album releaseDate]]];
}

#pragma mark - Variable Formatting

- (nonnull NSString *)formatExplicitness:(nonnull NSString *)explicitness
{
    if ([explicitness isEqualToString:SCCHeaderDetailViewNotExplicit] || [explicitness isEqualToString:SCCHeaderDetailViewCleaned]) {
        return [self localizedNotExplicit];
    } else {
        return [self localizedExplicit];
    }
}

- (nonnull NSDateFormatter *)configureDateFormatter
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
    NSArray *albumLabels = @[ _albumName, _artistName, _releaseDate, _explicitness, _genre, _country ];
    UIStackView *labelsStackView = [self verticalStackViewFromSubviews:albumLabels];
    NSArray *albumViews = @[ _albumArt, labelsStackView ];
    UIStackView *outerStackView = [self horizontalStackViewFromSubviews:albumViews];
    [self activateAlbumArtSizeConstraints];
    [self activateConstraints:outerStackView];
}

- (void)activateConstraints:(UIStackView *)stackView
{
    UIView *view = [self contentView];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addSubview:stackView];
    UILayoutGuide *marginsGuide = [self layoutMarginsGuide];
    [NSLayoutConstraint activateConstraints:@[
        [[stackView leadingAnchor] constraintEqualToAnchor:[marginsGuide leadingAnchor]],
        [[stackView trailingAnchor] constraintEqualToAnchor:[marginsGuide trailingAnchor]],
        [[stackView topAnchor] constraintEqualToAnchor:[[view layoutMarginsGuide] topAnchor]],
        [[stackView bottomAnchor] constraintEqualToAnchor:[[view layoutMarginsGuide] bottomAnchor]]
    ]];
}

- (void)activateAlbumArtSizeConstraints
{
    [_albumArt setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_albumArt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:110];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_albumArt attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_albumArt attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [_albumArt addConstraints:@[ widthConstraint, heightConstraint ]];
}

- (UIStackView *)verticalStackViewFromSubviews:(NSArray *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    [stackView setSpacing:0];
    [stackView setDistribution:UIStackViewDistributionFillProportionally];
    [stackView setAlignment:UIStackViewAlignmentLeading];
    return stackView;
}

- (UIStackView *)horizontalStackViewFromSubviews:(NSArray *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisHorizontal];
    [stackView setSpacing:15];
    [stackView setDistribution:UIStackViewDistributionFill];
    [stackView setAlignment:UIStackViewAlignmentLeading];
    return stackView;
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedNotExplicit
{
    return @"Not Explicit";
}

- (nonnull NSString *)localizedExplicit
{
    return @"Explicit";
}

@end