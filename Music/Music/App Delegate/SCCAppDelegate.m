//
//  Created by Brian M Coyner on 5/13/16.
//  Copyright © 2016 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCAppDelegate.h"

#import "SCCWelcomeViewController.h"

@implementation SCCAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    SCCWelcomeViewController *welcomeViewController = [[SCCWelcomeViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    [navigationController pushViewController:welcomeViewController animated:NO];
    
    _window = [self instantiateMainWindow];
    [_window setRootViewController:navigationController];
    [_window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Main Window Creation

- (UIWindow *)instantiateMainWindow
{
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    return [[UIWindow alloc] initWithFrame:windowFrame];
}

@end