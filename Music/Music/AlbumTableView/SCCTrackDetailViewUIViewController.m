//
// Created by Daniel Burkle on 7/6/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCTrackDetailViewUIViewController.h"

#import "SCCImageUtility.h"
#import "SCCTrack.h"
#import "SCCAlbumDetailViewTableViewController.h"
#import "SCCAlbumDetailHeaderView.h"

@interface SCCTrackDetailViewUIViewController () {
    SCCTrack *_track;
    UIImageView *_trackArtImageView;
}

@end

@implementation SCCTrackDetailViewUIViewController

#pragma mark - Object Life Cycle

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is init for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"Programmer Error! This initializer is initWithNibName for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    NSLog(@"Programmer Error! This initializer is initWithCoder for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithTrack:(SCCTrack *)track
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self setTitle: [self localizedTitle]];
        _track = track;
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureView];
    [[[self navigationController] navigationBar] setTranslucent:NO];
}

#pragma mark - UIViewController Datasource

- (void)setUILabelText
{
    [_albumArtist setText:[NSString stringWithFormat:@"%@", [_track artistName]]];
    [_albumName setText:[NSString stringWithFormat:@"%@", [_track albumName]]];
    [_diskCount setText:[NSString stringWithFormat:@"Disk Count: %d", [_track diskCount]]];
    [_diskNumber setText:[NSString stringWithFormat:@"Disk Number: %d", [_track diskNumber]]];
    [_trackDuration setText:[NSString stringWithFormat:@"%@", [SCCAlbumDetailViewTableViewController formatDuration:[_track duration]]]];
    [_trackExplicitness setText:[SCCAlbumDetailHeaderView formatExplicitness:[_track explicitness]]];
    [_trackName setText:[NSString stringWithFormat:@"%@", [_track name]]];
    [_trackNumber setText:[NSString stringWithFormat:@"Track Number: %d", [_track trackNumber]]];
    [_trackPrice setText:[NSString stringWithFormat:@"$%g", [_track price]]];
}

- (void)initializeTrackArt
{
    _trackArtImageView = [SCCImageUtility trackPlaceHolderImageView];
}

#pragma mark - View Configuration

- (void)configureView
{
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    [self initializeTrackArt];
    [self initializeLabels];
    [self setUILabelText];
    [self applyFonts];
    [self applyAutoLayoutConstraints];
}

- (void)initializeLabels
{
    _albumArtist = [[UILabel alloc] init];
    _albumName =[[UILabel alloc] init];
    _diskCount = [[UILabel alloc] init];
    _diskNumber =[[UILabel alloc] init];
    _trackDuration = [[UILabel alloc] init];
    _trackExplicitness = [[UILabel alloc] init];
    _trackName = [[UILabel alloc] init];
    _trackNumber = [[UILabel alloc] init];
    _trackPrice = [[UILabel alloc] init];
}

- (void)applyFonts
{
    [_albumArtist setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [_albumName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [_diskCount setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [_diskNumber setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [_trackDuration setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [_trackExplicitness setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [_trackName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle2]];
    [_trackNumber setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [_trackPrice setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
}

- (void)resizeTrackArtForOrientation
{
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) {
        [self activateLandscapeTrackArtSizeConstraints];
    }
    else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        [self activateLandscapeTrackArtSizeConstraints];
    }
    else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        [self activatePortraitTrackArtSizeConstraints];
    }
    else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
        [self activatePortraitTrackArtSizeConstraints];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [_trackArtImageView removeConstraints:[_trackArtImageView constraints]];
    [self resizeTrackArtForOrientation];
}

#pragma mark - Autolayout

- (void)applyAutoLayoutConstraints
{
    NSArray<UILabel *> *leftTrackLabels = @[  _trackDuration, _trackPrice, _trackExplicitness ];
    UIStackView *leftLabelsStackView = [self innerVerticalStackViewFromSubviews:leftTrackLabels];
    NSArray<UILabel *> *rightTrackLabels = @[ _diskNumber, _trackNumber, _diskCount ];
    UIStackView *rightLabelsStackView = [self innerVerticalStackViewFromSubviews:rightTrackLabels];
    NSArray<UILabel *> *centerTrackLabels = @[ _trackName, _albumArtist, _albumName ];
    UIStackView *centerLabelsStackView = [self centerVerticalStackViewFromSubviews:centerTrackLabels];
    NSArray<UIView *> *allLabels = @[ leftLabelsStackView, rightLabelsStackView];
    UIStackView *allLabelsStackView = [self horizontalStackViewFromSubviews:allLabels];
    NSArray<UIView *> *trackViews = @[ _trackArtImageView, centerLabelsStackView, allLabelsStackView];
    UIStackView *outerStackView = [self outerVerticalStackViewFromSubviews:trackViews];
    [self resizeTrackArtForOrientation];
    [self activateConstraints:outerStackView];
}

- (void)activatePortraitTrackArtSizeConstraints
{
    [_trackArtImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_trackArtImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_trackArtImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_trackArtImageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [_trackArtImageView addConstraints:@[ widthConstraint, heightConstraint ]];
}

- (void)activateLandscapeTrackArtSizeConstraints
{
    [_trackArtImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_trackArtImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_trackArtImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_trackArtImageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [_trackArtImageView addConstraints:@[ widthConstraint, heightConstraint ]];
}

- (nonnull UIStackView *)centerVerticalStackViewFromSubviews:(nonnull NSArray<UIView *> *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    [stackView setSpacing:10];
    [stackView setDistribution:UIStackViewDistributionFill];
    [stackView setAlignment:UIStackViewAlignmentCenter];
    return stackView;
}

- (nonnull UIStackView *)innerVerticalStackViewFromSubviews:(nonnull NSArray<UIView *> *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    [stackView setSpacing:10];
    [stackView setDistribution:UIStackViewDistributionFill];
    [stackView setAlignment:UIStackViewAlignmentLeading];
    return stackView;
}

- (nonnull UIStackView *)outerVerticalStackViewFromSubviews:(nonnull NSArray<UIView *> *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    [stackView setSpacing:15];
    [stackView setDistribution:UIStackViewDistributionFill];
    [stackView setAlignment:UIStackViewAlignmentCenter];
    return stackView;
}

- (nonnull UIStackView *)horizontalStackViewFromSubviews:(nonnull NSArray<UIView *> *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisHorizontal];
    [stackView setSpacing:15];
    [stackView setDistribution:UIStackViewDistributionFill];
    [stackView setAlignment:UIStackViewAlignmentLeading];
    return stackView;
}

- (void)activateConstraints:(nonnull UIStackView *)stackView
{
    UIView *view = [self view];
    [view addSubview:stackView];
    UILayoutGuide *marginsGuide = [view layoutMarginsGuide];
    [NSLayoutConstraint activateConstraints:@[
        [[stackView leadingAnchor] constraintEqualToAnchor:[marginsGuide leadingAnchor]],
        [[stackView trailingAnchor] constraintEqualToAnchor:[marginsGuide trailingAnchor]],
        [[stackView topAnchor] constraintEqualToAnchor:[[view layoutMarginsGuide] topAnchor] constant:15],
        [[stackView bottomAnchor] constraintEqualToAnchor:[[view layoutMarginsGuide] bottomAnchor]]
    ]];
}

#pragma mark - Localized Strings

- (nonnull NSString *)localizedTitle
{
    return @"Track Details";
}

@end