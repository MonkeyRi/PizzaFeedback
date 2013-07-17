//
//  ViewController.m
//  PizzaFeedback
//
//  Created by admin on 13-7-16.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "SMTwitterShare.h"
#import "Global.h"
#import "RatingViewController.h"
#import "MyBrowserViewController.h"
#import "InfoBrowserViewController.h"
#import "MapViewController.h"
#import "ASFBPostController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
        
    self.view.backgroundColor = colorWithHexString(g_colorSetting.bc_color, 1.0f);
    self.lblContentHeader.textColor = colorWithHexString(g_colorSetting.header_color, 1.0f);
    self.txtText.textColor = colorWithHexString(g_colorSetting.text_color, 1.0f);
    
    self.viewShop.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    [self.btnShop setTitleColor:colorWithHexString(g_colorSetting.box_text_color, 1.0f) forState:UIControlStateNormal];
    
    self.viewRating.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    
    self.viewLocation.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    
    self.viewKNOB.backgroundColor = colorWithHexString(g_colorSetting.bc_color, 1.0f);
    
    self.viewEmail.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    self.viewPhone.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    self.viewFacebook.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    self.viewTwitter.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    self.viewInfo.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    
    self.lblContentHeader.text = g_contentSetting.header;
    self.txtText.text = g_contentSetting.text;

    
//    [NSTimer scheduledTimerWithTimeInterval:REFRESH_TIME target:self selector:@selector(processTimer:) userInfo:nil repeats:YES];
}

- (void)processTimer:(NSTimer *)aTimer
{
    NSLog(@"Timer");
    Initialize();
    
    LoadSettings();
    [NSThread detachNewThreadSelector:@selector(loadingImage) toTarget:self withObject:nil];
    
    self.view.backgroundColor = colorWithHexString(g_colorSetting.bc_color, 1.0f);
    self.lblContentHeader.textColor = colorWithHexString(g_colorSetting.header_color, 1.0f);
    self.txtText.textColor = colorWithHexString(g_colorSetting.text_color, 1.0f);
    
    self.viewShop.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    [self.btnShop setTitleColor:colorWithHexString(g_colorSetting.box_text_color, 1.0f) forState:UIControlStateNormal];
    
    self.viewRating.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    
    self.viewLocation.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    
    self.viewKNOB.backgroundColor = colorWithHexString(g_colorSetting.bc_color, 1.0f);
    
    self.viewEmail.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    self.viewPhone.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    self.viewFacebook.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    self.viewTwitter.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    self.viewInfo.backgroundColor = colorWithHexString(g_colorSetting.box_color, 1.0f);
    
    self.lblContentHeader.text = g_contentSetting.header;
    self.txtText.text = g_contentSetting.text;
    
    [self.imgPager reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)dealloc {
    [_imgPager release];
    [_lblContentHeader release];
    [_txtText release];
    [_viewShop release];
    [_btnShop release];
    [_viewRating release];
    [_viewLocation release];
    [_viewKNOB release];
    [_viewEmail release];
    [_viewPhone release];
    [_viewFacebook release];
    [_viewTwitter release];
    [_viewInfo release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setImgPager:nil];
    [self setLblContentHeader:nil];
    [self setTxtText:nil];
    [self setViewShop:nil];
    [self setBtnShop:nil];
    [self setViewRating:nil];
    [self setViewLocation:nil];
    [self setViewKNOB:nil];
    [self setViewEmail:nil];
    [self setViewPhone:nil];
    [self setViewFacebook:nil];
    [self setViewTwitter:nil];
    [self setViewInfo:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages
{
    return [NSArray arrayWithObjects:
            g_sliderSetting.imgURL1,
            g_sliderSetting.imgURL2,
            g_sliderSetting.imgURL3,
            nil];
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFill;
}

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{
    NSLog(@"%s %d", __PRETTY_FUNCTION__, index);
}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    NSLog(@"%s %d", __PRETTY_FUNCTION__, index);
}


- (IBAction)clickShop:(id)sender {
    MyBrowserViewController *vc = [[MyBrowserViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navVC animated:YES completion:^{}];
    [vc loadUrl:[NSURL URLWithString:g_dataSetting.shop_url]];
    [vc release];
}

- (IBAction)clickRating:(id)sender {
    RatingViewController *vc = [[RatingViewController alloc] initWithNibName:@"RatingViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)clickMap:(id)sender {
    MapViewController *vc = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)clickMail:(id)sender {
    MFMailComposeViewController *controller = [[[MFMailComposeViewController alloc] init] autorelease];
    controller.delegate = self;
    if([MFMailComposeViewController canSendMail])
    {
        controller.mailComposeDelegate = self;
        [controller setSubject:nil];
        [controller setToRecipients:[NSArray arrayWithObjects:g_dataSetting.shop_mail, nil]];
        [controller setMessageBody:nil isHTML:NO];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (IBAction)clickPhone:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", g_dataSetting.shop_phone]]];
}

- (IBAction)clickFacebook:(id)sender {
    if([SMCommon isSocialFrameworkAvailable])
    {
        SLComposeViewController *fbController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        SLComposeViewControllerCompletionHandler completionHandler = ^(SLComposeViewControllerResult result)
        {
            [fbController dismissViewControllerAnimated:YES completion:Nil];
        };
        [fbController setCompletionHandler:completionHandler];
        
        [fbController setInitialText:g_socialSetting.text];
        if(g_socialSetting.image)
        {
            [fbController addImage:g_socialSetting.image];
        }
        [fbController addURL:[NSURL URLWithString:[g_socialSetting.link_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        [self presentViewController:fbController animated:YES completion:nil];
    }
    else
    {
        ASFBPostController *c = [[ASFBPostController alloc] init];
        c.thumbnailImage = g_socialSetting.image;
        c.originalImage = g_socialSetting.image;
        c.text = g_socialSetting.text;
        c.url = [NSURL URLWithString:[g_socialSetting.link_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:c];
        n.modalPresentationStyle = UIModalPresentationFormSheet;
        [c release];
        [self presentModalViewController:n animated:YES];
        [n release];

    }
}

- (IBAction)clickTwitter:(id)sender {
    SMTwitterShare *twShare = [[SMTwitterShare alloc] init];
    [twShare shareWithMessage:g_socialSetting.text Image:g_socialSetting.image Url:[NSURL URLWithString:[g_socialSetting.link_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] target:self];
}

- (IBAction)clickInfo:(id)sender {
    InfoBrowserViewController *vc = [[InfoBrowserViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navVC animated:YES completion:^{}];
    [vc loadString:g_infoSetting.info];
    [vc release];
}

// mail delegate
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
			break;
		case MessageComposeResultSent:
            NSLog(@"Sent");
			break;
		default:
			break;
	}
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
