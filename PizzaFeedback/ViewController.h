//
//  ViewController.h
//  PizzaFeedback
//
//  Created by admin on 13-7-16.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "KIImagePager.h"

@interface ViewController : UIViewController<UINavigationControllerDelegate, MFMailComposeViewControllerDelegate>

@property (retain, nonatomic) IBOutlet KIImagePager *imgPager;
@property (retain, nonatomic) IBOutlet UILabel *lblContentHeader;
@property (retain, nonatomic) IBOutlet UITextView *txtText;

@property (retain, nonatomic) IBOutlet UIView *viewShop;
@property (retain, nonatomic) IBOutlet UIButton *btnShop;

@property (retain, nonatomic) IBOutlet UIView *viewRating;

@property (retain, nonatomic) IBOutlet UIView *viewLocation;

@property (retain, nonatomic) IBOutlet UIView *viewKNOB;

@property (retain, nonatomic) IBOutlet UIView *viewEmail;
@property (retain, nonatomic) IBOutlet UIView *viewPhone;
@property (retain, nonatomic) IBOutlet UIView *viewFacebook;
@property (retain, nonatomic) IBOutlet UIView *viewTwitter;
@property (retain, nonatomic) IBOutlet UIView *viewInfo;

- (IBAction)clickShop:(id)sender;
- (IBAction)clickRating:(id)sender;
- (IBAction)clickMap:(id)sender;
- (IBAction)clickMail:(id)sender;
- (IBAction)clickPhone:(id)sender;
- (IBAction)clickFacebook:(id)sender;
- (IBAction)clickTwitter:(id)sender;
- (IBAction)clickInfo:(id)sender;

@end
