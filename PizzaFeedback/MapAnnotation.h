//
//  MapAnnotation.h
//  ProxyDriverTest
//
//  Created by 대사 on 10. 10. 8..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject<MKAnnotation> {
	NSString *title;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

- (id) initWithCoordinate:(float)fLat longitude:(float)fLon;

@end
