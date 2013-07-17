//
//  MapViewController.h
//  PizzaFeedback
//
//  Created by admin on 13-7-17.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@end
