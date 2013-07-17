//
//  MapAnnotation.m
//  ProxyDriverTest
//
//  Created by 대사 on 10. 10. 8..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation
@synthesize title;
@synthesize coordinate;
@synthesize subtitle;

- (id) initWithCoordinate:(float)fLat longitude:(float)fLon
{
	if (self = [super init])
    {
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(fLat, fLon);
        coordinate = loc;
    }
	return self;
}

-(void) dealloc
{
	self.title = nil;
	self.subtitle = nil;
	[super dealloc];
}
@end
