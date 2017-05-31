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

- (nonnull UIWindow *)instantiateMainWindow
{
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    return [[UIWindow alloc] initWithFrame:windowFrame];
}

@end
