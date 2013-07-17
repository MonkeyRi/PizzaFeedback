//
//  AppDelegate.h
//  PizzaFeedback
//
//  Created by admin on 13-7-16.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class SplashViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SplashViewController *viewController;
@property (nonatomic, assign) Facebook *facebook;
@end
