//
//  RatingViewController.h
//  PizzaFeedback
//
//  Created by admin on 13-7-17.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"

@interface RatingViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate, DYRateViewDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet DYRateView *rateView1;
@property (retain, nonatomic) IBOutlet DYRateView *rateView2;
@property (retain, nonatomic) IBOutlet DYRateView *rateView3;
@property (retain, nonatomic) IBOutlet DYRateView *rateView4;
@property (retain, nonatomic) IBOutlet DYRateView *rateView5;
@property (retain, nonatomic) IBOutlet DYRateView *rateView6;

@property (retain, nonatomic) IBOutlet UITextField *txtName;
@property (retain, nonatomic) IBOutlet UITextField *txtMail;
@property (retain, nonatomic) IBOutlet UITextView *txtComment;

@end
