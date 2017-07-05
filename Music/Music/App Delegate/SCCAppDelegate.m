//
//  Created by Brian M Coyner on 5/20/14.
//  Copyright (c) 2014 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCAppDelegate.h"

#import "SCCAlbumTableViewController.h"

@implementation SCCAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    SCCAlbumTableViewController *albumViewController = [[SCCAlbumTableViewController alloc] init];

    UINavigationController *navigationController = [[UINavigationController alloc] init];
    [navigationController pushViewController:albumViewController animated:NO];

    _window = [self instantiateMainWindow];
    [_window setRootViewController:navigationController];
    [_window makeKeyAndVisible];

    return YES;
}

#pragma mark - Main Window Creation

- (nonnull UIWindow *)instantiateMainWindow
{
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    return [[UIWindow alloc] initWithFrame:windowFrame];
}

@end
