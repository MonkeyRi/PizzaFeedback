//
//  SplashViewController.m
//  LoveHunter
//
//  Created by Gentleman on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SplashViewController.h"
#import "Reachability.h"
#import "Global.h"
#import "ViewController.h"

@implementation SplashViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

- (void)loadingImage
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    g_socialSetting.image = [[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[g_socialSetting.imgURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]] retain];
    
    [pool release];
}

- (void)viewDidAppear:(BOOL)animated
{
    Reachability *internetReachableFoo = [Reachability reachabilityWithHostname:@"www.apple.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:1.0f];

            if([[UIScreen mainScreen] bounds].size.height == 568.0f)
            {
                g_biPhone5 = YES;
            }
            else
            {
                g_biPhone5 = NO;
            }
            
            Initialize();
            
            LoadSettings();
            [NSThread detachNewThreadSelector:@selector(loadingImage) toTarget:self withObject:nil];

            
            ViewController  *vc;
            if(g_biPhone5)
            {
                vc = [[[ViewController alloc] initWithNibName:@"ViewControllerFive" bundle:nil] autorelease];
            }
            else
            {
                vc = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
            }
            
            [self.navigationController pushViewController:vc animated:YES];
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No InternetConnection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        });
    };
    
    [internetReachableFoo startNotifier];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
