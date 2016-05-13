//
//  Created by Brian M Coyner on 5/20/14.
//  Copyright (c) 2014 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCWelcomeViewController.h"

@implementation SCCWelcomeViewController

#pragma mark - Object Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setTitle:@"Welcome"];
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *welcomeLabel = [[UILabel alloc] init];
    [welcomeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [welcomeLabel setText:@"Welcome To NISC"];
    
    UIView *view = [self view];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:welcomeLabel];
    
    [NSLayoutConstraint activateConstraints:@[
         [[welcomeLabel centerXAnchor] constraintEqualToAnchor:[view centerXAnchor]],
         [[welcomeLabel centerYAnchor] constraintEqualToAnchor:[view centerYAnchor]]
    ]];
}

@end
