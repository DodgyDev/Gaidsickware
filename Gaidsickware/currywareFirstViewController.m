//
//  currywareFirstViewController.m
//  Gaidsickware
//
//  Created by Scot Curry on 6/16/14.
//  Copyright (c) 2014 Scot Curry. All rights reserved.
//

#import "currywareFirstViewController.h"

@interface currywareFirstViewController ()

@end

@implementation currywareFirstViewController

// AirWatch Code:
// This is where we tell this part that runs the code to pull in the variables we created in the header file
@synthesize labelHelloOutput;
@synthesize textFieldInput;
@synthesize myIPReachability;
@synthesize textFieldHelloWorldOutput;
@synthesize textFieldAirWatchUserName;
@synthesize textFieldAirWatchPassword;
@synthesize textFieldAirWatchGroupID;

// AirWatch Code:
// There is lot of code that checks to see if we have a network connection.  Not really related to the SDK, but
// we are so dependant on network connectivity we need this.
@synthesize hostReachability;
@synthesize internetReachability;
@synthesize wifiReachability;

// AirWatch Code:
// This is where we implement the method that make something actually happen when we click the button.
-(IBAction)clickedHello:(UIButton *)sender {
    // We are just creating a string with static content here that we are going to append the value we put in
    // the text field to.
    textFieldHelloWorldOutput.text = @"Hello.  You pushed the button.";
}

// AirWatch Code:
// This is the implementation of the SSO functionality of the SDK.  Once the user logs in with their passcode, you
// can get the AirWatch login credentials.  This is in the AWEnrollmentAccount.h file.
-(IBAction)clickedGetAWCredntials:(UIButton *)sender {
    
    AWEnrollmentAccount *awAccount = [[AWController clientInstance] account];
    textFieldAirWatchUserName.text = [awAccount username];
    textFieldAirWatchPassword.text = [awAccount password];

    NSInteger groupID = [awAccount identifier];
    textFieldAirWatchGroupID.text = [NSString stringWithFormat:@"%d", groupID];
}

// AirWatch Code:
// This shows how to use the branding profile.
-(IBAction)clickedUseBrandingProfile:(id)sender {
    
    AWCommandManager *commandManager = [AWCommandManager sharedManager];
    AWProfile *currentProfile = [commandManager sdkProfile];
    if (currentProfile == nil) {
        NSLog(@"There is not AW Profile");
    }
    else {
        AWBrandingPayload *brandingPayload = [currentProfile brandingPayload];
        if (brandingPayload != nil) {
            UIColor *toolbarColor = [brandingPayload toolbarColor];
            UIColor *primaryColor = [brandingPayload primaryColor];
            UIColor *primaryTextColor = [brandingPayload primaryTextColor];
            
            self.view.backgroundColor = toolbarColor;
            self.textFieldAirWatchGroupID.backgroundColor = primaryColor;
            self.textFieldAirWatchGroupID.textColor = primaryTextColor;
            self.textFieldAirWatchPassword.backgroundColor = primaryColor;
            self.textFieldAirWatchPassword.textColor = primaryTextColor;
        }
    }
}

// AirWatch Code:
// This is an SDK specific function.  Analytics sends information about functions to the console.
- (void)doAnalytics {
    
    AWDataSamplerConfiguration *samplerConfig = [[AWDataSamplerConfiguration init] alloc];
    samplerConfig.urlScheme = @"https://demo2.awmdm.com";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // AirWatch Code:
    // This is added to for the reachability class.  We are registering a listener to detect when the network status
    // changes.  See https://developer.apple.com/Library/ios/samplecode/Reachability/Introduction/Intro.html
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    // AirWatch Code:
    // This isn't really related to the SDK.  This is the implementation of the Reachability class, that was cobbed
    // from the Apple sample code site.  Check to make sure the whatsmyip web site can be reached.
    NSString *whatsMyIpWebURL = @"www.whatsmyip.org";
    self.hostReachability = [Reachability reachabilityWithHostName:whatsMyIpWebURL];
    [self.hostReachability startNotifier];
    [self updateLogWithReachability:self.hostReachability];
    
    // This checks to see if there is an Internet connection.
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateLogWithReachability:self.internetReachability];
    
    // This checks to see if there is an Wifi connection.
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    [self updateLogWithReachability:self.wifiReachability];
}

// AirWatch Code:
// This is the implementation of the Reachability class that returns the status of the network.  Not at all related to
// the AirWatch SDK.  See https://developer.apple.com/Library/ios/samplecode/Reachability/Introduction/Intro.html
- (void)updateLogWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
	{
        //NetworkStatus netStatus = [reachability currentReachabilityStatus];
        NSString *reachableText = @"Reachable via Wifi";
        // NSLog(@"Host Reachability: %@", [self getReachabilityString:reachability]);
        if ([self getReachabilityString:reachability] == reachableText)
        {
            myIPReachability.textColor = [[UIColor alloc]initWithRed: 1.000000 green: 1.000000 blue: 1.000000 alpha: 1 ];
            myIPReachability.text = @"WhatsMyIP Is Reachable";
        }
    }
    
	if (reachability == self.internetReachability)
	{
		// NSLog(@"Internet Reachability: %@", [self getReachabilityString:reachability]);
	}
    
	if (reachability == self.wifiReachability)
	{
		// NSLog(@"Wifi Reachability: %@", [self getReachabilityString:reachability]);
	}
}

- (NSString *)getReachabilityString:(Reachability *)reachability
{
    NSString *returnString = @"";
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable:
            returnString = @"Hostname Not Reachable";
            break;
            
        case ReachableViaWWAN:
            returnString = @"Reachable via WWAN";
            break;
            
        case ReachableViaWiFi:
            returnString = @"Reachable via Wifi";
            break;
    }
    
    return returnString;
}

// AirWatch Code:
// This is the listener that handles any change to network reachability.  We a device becomes active it seems that the
// status does change.  I've tried implementing this without this and the status always returns not connected.
- (void) reachabilityChanged:(NSNotification *)note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
	[self updateLogWithReachability:curReach];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
