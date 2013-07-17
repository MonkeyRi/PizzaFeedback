//
//  MapViewController.m
//  PizzaFeedback
//
//  Created by admin on 13-7-17.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import "MapViewController.h"
#import "Global.h"
#import "MapAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"";
        UIBarButtonItem     *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Navigate to..." style:UIBarButtonItemStylePlain target:self action:@selector(clickNavigate)];
        self.navigationItem.rightBarButtonItem = buttonItem;
        [buttonItem release];
    }
    return self;
}

- (void)clickNavigate
{
    NSLog(@"Navigate to......");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    LoadMap();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_mapView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
    CLLocationCoordinate2D location;
    location = CLLocationCoordinate2DMake(g_fLat, g_fLon);
    
	MKCoordinateSpan span = MKCoordinateSpanMake(0.02f, 0.02f);
	MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
	[self.mapView setRegion:region animated:YES];
	[self.mapView regionThatFits:region];
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MapAnnotation *annotation;
    NSMutableArray *annotations = [NSMutableArray array];
    
    annotation = [[[MapAnnotation alloc] init] autorelease];
    [annotation initWithCoordinate:g_fLat longitude:g_fLon];
    annotation.title = @"Address";
    annotation.subtitle = g_dataSetting.shop_address;
    
    [annotations addObject:annotation];
    
    [self.mapView addAnnotations:annotations];
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}
@end
