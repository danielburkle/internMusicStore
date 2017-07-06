//
// Created by Daniel Burkle on 6/30/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCTrackTableViewCell.h"

@implementation SCCTrackTableViewCell

#pragma mark - Object Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCell];
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)prepareForReuse
{
    [super prepareForReuse];
}

#pragma mark - Cell Customization

- (void)configureCell
{
    [self initializeLabels];
    [self applyAutoLayoutConstraints];
    [self applyFonts];
}

- (void)initializeLabels
{
    _trackDuration = [[UILabel alloc] init];
    _trackName = [[UILabel alloc] init];
    _trackNumber = [[UILabel alloc] init];
}

- (void)applyFonts
{
    [_trackDuration setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [_trackName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [_trackNumber setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
}

#pragma mark - Cell Autolayout

- (void)applyAutoLayoutConstraints
{
    NSArray<UILabel *> *trackLabels = @[ _trackNumber, _trackName, _trackDuration ];
    [_trackDuration setContentCompressionResistancePriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_trackDuration setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    UIStackView *labelsStackView = [self horizontalStackViewFromSubviews:trackLabels];
    [self applyTrackNumberConstraints];
    [self activateConstraints:labelsStackView];
}

- (nonnull UIStackView *)horizontalStackViewFromSubviews:(nonnull NSArray<UILabel *> *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisHorizontal];
    [stackView setSpacing:0];
    [stackView setDistribution:UIStackViewDistributionFill];
    [stackView setAlignment:UIStackViewAlignmentLeading];
    return stackView;
}

- (void)applyTrackNumberConstraints
{
    [_trackNumber setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_trackNumber attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30];
    [_trackNumber addConstraint:widthConstraint];
}

- (void)activateConstraints:(nonnull UIStackView *)stackView
{
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

@end