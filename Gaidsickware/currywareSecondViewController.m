//
//  currywareSecondViewController.m
//  Gaidsickware
//
//  Created by Scot Curry on 6/16/14.
//  Copyright (c) 2014 Scot Curry. All rights reserved.
//

#import "currywareSecondViewController.h"

@interface currywareSecondViewController ()

@end

@implementation currywareSecondViewController

@synthesize webViewControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // AirWatch Code:
    // Pretty simple code.  This is just builds up the URL request and then ahd the WebView Controller load it.
    NSString *stringToWhatsMyIP = @"http://www.whatsmyip.org";
    NSURL *whatsMyIPURL = [NSURL URLWithString:stringToWhatsMyIP];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:whatsMyIPURL];
    [webViewControl loadRequest:urlRequest];
    // NSLog(@"Load Request Completed");
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
