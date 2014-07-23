//
//  currywareFirstViewController.h
//  Gaidsickware
//
//  Created by Scot Curry on 6/16/14.
//  Copyright (c) 2014 Scot Curry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

// AirWatch Code:
// To access functionality you will need to import the appropriate header files.  Check the code notes to see what
// call needs which header file.
#import <AWSDK/AWLog.h>
#import <AWSDK/AWAnalytics.h>
#import <AWSDK/AWController.h>
#import <AWSDK/AWDataSampler.h>
#import <AWSDK/AWCommandManager.h>
#import <AWSDK/AWEnrollmentAccount.h>
#import <AWSDK/AWDataSamplerConfiguration.h>

@interface currywareFirstViewController : UIViewController

// AirWatch Code:  All of this is AirWatch code, XCode only created the interface and end statements.
// We are defining the variables that are going to hold the value.  The UITextField is where we put something
// in a field.  The UILabel field is where we are going to put the output when we push the button.

// Nonatomic means that more than one thread can access this property.
// Weak has to do with reference counting which has to do with memory managment and garbage collection.
// IBOutlet is used to make sure Interface Builder knows what to do with this.
@property (weak, nonatomic) IBOutlet UILabel *labelHelloOutput;
@property (weak, nonatomic) IBOutlet UITextField *textFieldInput;
@property (weak, nonatomic) IBOutlet UILabel *myIPReachability;
@property (weak, nonatomic) IBOutlet UITextField *textFieldHelloWorldOutput;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAirWatchUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAirWatchPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAirWatchGroupID;

// This is where we define a method.  The method is defined as an IBAction method.  This particular identifier
// is what makes this code work with Interface Builder.  Make special not to look at the little circles to the
// left of the two properites and this method.
-(IBAction)clickedHello:(UIButton *) sender;
-(IBAction)clickedGetAWCredntials:(UIButton *)sender;
-(IBAction)clickedUseBrandingProfile:(id)sender;
-(IBAction)clickedDoAnalytics:(id)sender;

// Setting up the properties for the Reachability class.  This is how to test to make sure you have a connection to
// get out.
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

@end
