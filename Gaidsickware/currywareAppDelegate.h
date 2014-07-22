//
//  currywareAppDelegate.h
//  Gaidsickware
//
//  Created by Scot Curry on 6/16/14.
//  Copyright (c) 2014 Scot Curry. All rights reserved.
//

#import <UIKit/UIKit.h>

// AirWatch Code;
// Need to add this to get any of the SDK functionality.  You need to read the implementation guide to make sure you
// have added all of the frameworks correctly.  If you have the XCode intellisense function will show this as soon
// as you hit <A
#import <AWSDK/AWController.h>

// AirWatch Code:
// This was a requirement to enumerate the profiles that are implemented in the receivedProfiles delegate
#import <AWSDK/AWProfile.h>

// AirWatch Code:
// Command manager is used to retreive the latest SDK or Application profile is something new is out there.  This header
// is used to call the loadCommands delegate in the 
#import <AWSDK/AWCommandManager.h>

// AirWatch Code:  This imports the Reachability header file that is used to test if we can get to websites.
#import "Reachability.h"

@interface currywareAppDelegate : UIResponder <UIApplicationDelegate, AWSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

// AirWatch Code:  The sets up the delegate to handle changes to the profile.
-(void)handleUpdatedProfile: (NSNotification *)airwatchNotification;

// AirWatch Code:  We are going to need to send the AWController object to other view controllers so we need to
// make a property we can grab from the view controllers.
@property AWController *airWatchController;

@end
