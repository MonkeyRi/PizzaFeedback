//
//  RatingViewController.m
//  PizzaFeedback
//
//  Created by admin on 13-7-17.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import "RatingViewController.h"

@interface RatingViewController ()

@end

@implementation RatingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tapScroll];
    [tapScroll release];
    
    CGFloat       fWidth, fHeight;
    
    fWidth = [UIScreen mainScreen].applicationFrame.size.width;
    fHeight = [UIScreen mainScreen].applicationFrame.size.height;
    fHeight = fHeight - self.navigationController.navigationBar.bounds.size.height;
    
    self.scrollView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=CGSizeMake(fWidth, fHeight)};
    self.scrollView.contentSize = CGSizeMake(320, 739);
    
    self.rateView1.alignment = RateViewAlignmentCenter;
    self.rateView1.editable = YES;
    self.rateView1.delegate = self;
    self.rateView1.tag = 1;
    
    self.rateView2.alignment = RateViewAlignmentCenter;
    self.rateView2.editable = YES;
    self.rateView2.delegate = self;
    self.rateView2.tag = 2;

    self.rateView3.alignment = RateViewAlignmentCenter;
    self.rateView3.editable = YES;
    self.rateView3.delegate = self;
    self.rateView3.tag = 3;
    
    self.rateView4.alignment = RateViewAlignmentCenter;
    self.rateView4.editable = YES;
    self.rateView4.delegate = self;
    self.rateView4.tag = 4;

    self.rateView5.alignment = RateViewAlignmentCenter;
    self.rateView5.editable = YES;
    self.rateView5.delegate = self;
    self.rateView5.tag = 5;

    self.rateView6.alignment = RateViewAlignmentCenter;
    self.rateView6.editable = YES;
    self.rateView6.delegate = self;
    self.rateView6.tag = 6;
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)dealloc {
    [_rateView1 release];
    [_scrollView release];
    [_rateView2 release];
    [_rateView3 release];
    [_rateView4 release];
    [_rateView5 release];
    [_rateView6 release];
    [_txtName release];
    [_txtMail release];
    [_txtComment release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setRateView1:nil];
    [self setScrollView:nil];
    [self setRateView2:nil];
    [self setRateView3:nil];
    [self setRateView4:nil];
    [self setRateView5:nil];
    [self setRateView6:nil];
    [self setTxtName:nil];
    [self setTxtMail:nil];
    [self setTxtComment:nil];
    [super viewDidUnload];
}

#pragma mark - DYRateViewDelegate

- (void)rateView:(DYRateView *)rateView changedToNewRate:(NSNumber *)rate {
    NSLog(@"Rate: %d, %d", rateView.tag, rate.intValue);
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIView  *activeField;
    if(self.txtName.isFirstResponder)
    {
        activeField = self.txtName;
    }
    else if(self.txtMail.isFirstResponder)
    {
        activeField = self.txtMail;
    }
    else
    {
        activeField = self.txtComment;
    }
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint scrollPoint;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        scrollPoint = CGPointMake(0.0, activeField.frame.origin.y+self.navigationController.navigationBar.bounds.size.height-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)HideAllList
{
    [self.txtName resignFirstResponder];
    [self.txtMail resignFirstResponder];
    [self.txtComment resignFirstResponder];
}

- (void) tapped {
    [self HideAllList];
}

@end
