//
//  currywareAppDelegate.m
//  Gaidsickware
//
//  Created by Scot Curry on 6/16/14.
//  Copyright (c) 2014 Scot Curry. All rights reserved.
//

#import "currywareAppDelegate.h"

@implementation currywareAppDelegate

// AirWatch Code:
// We need to be able to access the AWContoller object from the view controllers, so we need this property for that.
@synthesize airWatchController;
 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // AirWatch Code - Start Here:
    // There are a couple of items that you will need to look at the documentation to get this project to work.
    // You need to add all of the appropriate frameworks to the project, and add a linker flag.  These are covered
    // well in the documentation.  You will also need to set the URL Scheme for callbacks.  Again covered in the
    // documentation.
    
    // AirWatch Code:
    // This line instantiates the AirWatch Controller.  We are using the property so we can pass this controller around.
    airWatchController = [AWController clientInstance];
    
    // AirWatch Code:
    // This line has got to match the URL Schemes in the Info.plist file.  You should have already created this
    // based on the documentation.  The documentation blurs out the URL Scheme, and it just has to match what you
    // put here.
    airWatchController.callbackScheme = @"AWURLScheme";
    
    // AirWatch Code:
    // Delegates "listen" for certain things that the operating system say is going on.  Since there is communication
    // between the AirWatch agent and the device that this application is going to run on we have to define who is
    // is going listen for these events.  "self" means that this object is going to listen for events.  You need to
    // add some handlers (initialCheckDoneWithError, receivedProfiles, unlock, lock, wipe, stopNetworkActivity, and
    // resumeNetworkActivity).  These are all right below this method.
    airWatchController.delegate = self;

    // AirWatch Code:
    // iOS programs communication through messages (thing of touching a button).  When you touch the button a message
    // gets sent out that a button was touched.  Someone has to be listening for that button.  Those types of messages
    // flow throught the NotificationCenter in iOS.
    
    // In the case of the SDK the AW Agent may check in or somehow find out that a profile has been updated.  When it
    // does it is going to tell the Notification center tell anyone that is listening that the profile was updated.  What
    // the following section does is tell the notification center that if it sees a notfication that something with the
    // name kAWProfileUpdated comes it that this application wants to handle it, and it is going to use a delegate called
    // handleUpdatedProfile to do it.
    NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
    [notifCenter addObserver:self selector:@selector(handleUpdatedProfile:) name:@"kAWProfileUpdated" object:nil];
    
    // Override point for customization after application launch.
    return YES;
}

// AirWatch Code:
// When the AirWatchController starts, it needs have a way to listen if it is being told that there are new profiles for
// it to deal with.  The first part of this was added in the didFinishLaunchingWithOptions section were the
// NotificationCenter was created.  There was a selector statement in that setup.  This is the implementation of that
// selector setup.
-(void)handleUpdatedProfile: (NSNotification *)airwatchNotification {
    AWProfile *profile = airwatchNotification.object;
    if (profile.certificatePayload) { // We know we have a certificate payload.  Application profile
        NSLog(@"This is a certificate profile.  This isn't implemented");
    } else {
        if (profile.customPayload) {
            NSString *customSettings = profile.customPayload.settings;
            NSLog(@"Custom Settings String: %@", customSettings);
        }
    }
}

// AirWatch Code:
// You are just trying to initialize the AirWatch code, so it you get an error here you have big problems.
-(void)initialCheckDoneWithError:(NSError *)error {
    
    // So if there is an error there is a log output that is going to put whatever is in the description, if not just
    // say it initalizd.
    if (error == nil)
        NSLog(@"Initialized without Error");
    else
        NSLog(@"Error Description: %@", error.description);
}

// AirWatch Code:
// Each time the app runs it checks to see there are any changes to the profile.  If there are they will be passed down as
// an array.  You cycle through this array to see what the new profiles are.
-(void)receivedProfiles:(NSArray *)profiles {
    for (AWProfile *currentProfile in profiles) {
        NSLog(@"%@", currentProfile.displayName);
    }
}

// AirWatch Code:
// I need to get some documentation on why you would use this.  My guess is that you maybe decrypt something now that you
// know we have a valid user.
-(void)unlock {
    NSLog(@"This delegate is run each time the device is unlocked with the correct passcode");
}

// AirWatch Code:
// This code is run when an SSO session expires.  I really need to put the debugger on this and make sure to know that this
// is the passcode timeout.
-(void)lock {
    NSLog(@"This is the delegate that is run when an SSO session expires");
}

// AirWatch Code:
// This code is run when the device has been enterprise wiped or unenrolled from AirWatch.  It is also runs when the
// maximum number of passcode attempts has been exceeded.
-(void)wipe {
    NSLog(@"This delegate is run when the device is unenrolled, wiped, or the maximum number of passcodes has been exceeded");
}

// AirWatch Code:
// I don't see a setting that matches up with the documentation so I'm not sure how this would be implemented.  The protocol
// requires that this delegate be impelmented so I'm doing it here for a clean compile.
-(void)stopNetworkActivity {
    NSLog(@"stopNetworkActivity has been called.  Not sure when it is used");
}

// AirWatch Code:
// Same as stopNetWorkActivity.  Not really sure where you build this into the profile.
-(void)resumeNetworkActivity {
    NSLog(@"resumeNetworkActivity has been called.  Not sure when it is used.");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // AirWatch Code:
    // There is a note in the guide as to why the particular piece of code goes in this delegate as opposed to the
    // didFinishLoading delegate.  This project uses storyboards, so the note is relevant to this example.
    [[AWController clientInstance] start];
    
    // AirWatch Code:
    // This is the statement that starts the handleUpdate observer.  This was the code above that told this application to
    // listen for message that are sent by the AirWatch agent.
    [[AWCommandManager sharedManager] loadCommands];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[AWController clientInstance] handleOpenURL:url fromApplication:sourceApplication];
}

@end
