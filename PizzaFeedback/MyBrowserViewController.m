//
//  MyBrowserViewController.m
//  Test
//
//  Created by jinni ahn on 11/2/12.
//  Copyright (c) 2012 jinni. All rights reserved.
//

#import "MyBrowserViewController.h"

@interface MyBrowserViewController () < UIWebViewDelegate, UIActionSheetDelegate >

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIBarButtonItem *buttonForward;
@property (nonatomic, retain) UIBarButtonItem *buttonBackward;

- (IBAction)onClose:(id)sender;
- (IBAction)onBackward:(id)sender;
- (IBAction)onForward:(id)sender;
//- (IBAction)onRefresh:(id)sender;


@end

@implementation MyBrowserViewController

@synthesize activityIndicator = _activityIndicator;
@synthesize webView = _webView;
@synthesize buttonForward = _buttonForward;
@synthesize buttonBackward = _buttonBackward;

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    
    return self;
}


// XIB를 사용하지 않고 UI를 구성하기 위해서 loadView를 사용
- (void)loadView
{
    // 툴바 사용
    [self.navigationController setToolbarHidden:NO];
    
    // 화면 사이즈를 가져와서 네비게이션과 툴바의 사이즈만큼을 뺀
    // webview가 보일 수 있는 영역을 구한다.
    CGRect viewRect = self.navigationController.view.bounds;
    if (! self.navigationController.isNavigationBarHidden) {
        viewRect.size.height -= 44;
    }
    if (! self.navigationController.isToolbarHidden){
        viewRect.size.height -= 44;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:viewRect];
    
    // Orientaion이 변경되도 화면을 꽉채울 수 있도록 설정
    UIViewAutoresizing completeFlexibleFlag = UIViewAutoresizingFlexibleLeftMargin
                                                | UIViewAutoresizingFlexibleLeftMargin
                                                | UIViewAutoresizingFlexibleWidth
                                                | UIViewAutoresizingFlexibleRightMargin
                                                | UIViewAutoresizingFlexibleTopMargin
                                                | UIViewAutoresizingFlexibleHeight
                                                | UIViewAutoresizingFlexibleBottomMargin ;

    [view setAutoresizingMask: completeFlexibleFlag];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:viewRect];
    [webView setAutoresizingMask:completeFlexibleFlag];
    webView.delegate = self;
    self.webView = webView;
    [view addSubview:webView];

    self.view = view;

    self.view.autoresizesSubviews = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Loading.";

    // 네비게이션 설정
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(onClose:)];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    self.activityIndicator = activityIndicator;

    // 툴바 설정
    UIBarButtonItem *btnBackward = [[UIBarButtonItem alloc] initWithTitle:@"◀\U0000FE0E"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(onBack:)];

    UIBarButtonItem *btnForward = [[UIBarButtonItem alloc] initWithTitle:@"▶\U0000FE0E"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(onForward:)];

    UIBarButtonItem *btnReload = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                  target:self
                                                                                  action:@selector(onReload:)];


    UIBarButtonItem *btnAction = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                  target:self
                                                                                  action:@selector(onAction:)];

    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:nil
                                                                           action:nil];
    
    self.buttonBackward = btnBackward;
    self.buttonForward = btnForward;
    self.buttonBackward.enabled = NO;
    self.buttonForward.enabled = NO;

    self.toolbarItems = [[NSArray alloc] initWithObjects:space, btnBackward, space, btnForward, space, btnReload, space, btnAction, space, nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.toolbarHidden = YES;
}

- (void)dealloc
{
    [_activityIndicator release];
    [_webView release];
    [_buttonForward release];
    [_buttonBackward release];

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadUrl:(NSURL*) url
{
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
}
- (void) loadString:(NSString*) url
{
    [self.webView loadHTMLString:url baseURL:nil];
}

#pragma mark - webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.buttonForward.enabled = webView.canGoForward;
    self.buttonBackward.enabled = webView.canGoBack;

    [self.activityIndicator  stopAnimating];

    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark - UIActionSheetDelegate handler

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 /* open in safari */) {
        if( [[UIApplication sharedApplication] canOpenURL:self.webView.request.URL ]){
            [[UIApplication sharedApplication] openURL:self.webView.request.URL];
        }
    }
}

#pragma mark - event handler

- (IBAction)onBackward:(id)sender{
    [self.webView goBack];
}

- (IBAction)onForward:(id)sender{
    [self.webView goForward];
    
}

- (IBAction)onReload:(id)sender{
    [self.webView reload];
}

- (IBAction)onClose:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}

- (IBAction)onAction:(id)sender {
    
    NSString* textCancel = @"Cancel";
    NSString* textOpenSafari = @"Open in Safari";
    
    UIActionSheet *acitonSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:textCancel
                                               destructiveButtonTitle:textOpenSafari
                                                    otherButtonTitles:nil ];
    
    [acitonSheet showFromToolbar:self.navigationController.toolbar];
}


@end
