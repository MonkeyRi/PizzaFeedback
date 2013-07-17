//
//  Global.m
//  PizzaFeedback
//
//  Created by admin on 13-7-16.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import "Global.h"
#import "JSONKit.h"

BOOL                g_biPhone5 = FALSE;
COLORS_SETTING      g_colorSetting;
CONTENT_SETTING     g_contentSetting;
DATA_SETTING        g_dataSetting;
INFO_SETTING        g_infoSetting;
SLIDER_SETTING      g_sliderSetting;
SOCIAL_SETTING      g_socialSetting;
float               g_fLon;
float               g_fLat;
int                 g_nRequestID = 1;


UIColor *colorWithHexString(NSString *stringToConvert, float alpha)
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
        if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

void Initialize()
{
    g_colorSetting.bc_color = nil;
    g_colorSetting.box_color = nil;
    g_colorSetting.box_text_color = nil;
    g_colorSetting.header_color = nil;
    g_colorSetting.text_color = nil;
    
    g_contentSetting.header = nil;
    g_contentSetting.text = nil;
    
    g_dataSetting.delivery_time = nil;
    g_dataSetting.shop_address = nil;
    g_dataSetting.shop_mail = nil;
    g_dataSetting.shop_phone = nil;
    g_dataSetting.shop_url = nil;
    
    g_infoSetting.info = nil;
    
    g_sliderSetting.duration = nil;
    g_sliderSetting.imgURL1 = nil;
    g_sliderSetting.imgURL2 = nil;
    g_sliderSetting.imgURL3 = nil;
    
    g_socialSetting.imgURL = nil;
    g_socialSetting.link_url = nil;
    g_socialSetting.text = nil;
    g_socialSetting.title = nil;
    g_socialSetting.image = nil;
}

void LoadSettings()
{
    NSString *jsonUrl = [NSString stringWithFormat:@"http://www.pizza-fox.de/scripts/webservice.php?type=get_settings_apps&d=i&v=%d", g_nRequestID];
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:jsonUrl]];
    
    JSONDecoder *jsonKitDecoder = [JSONDecoder decoder];
    NSDictionary *items = [jsonKitDecoder objectWithData:jsonData];
	
    NSLog(@"total items: %d", [items count]);
    
    NSDictionary        *settings;
    NSDictionary        *colors;
    NSDictionary        *content;
    NSDictionary        *data;
    NSDictionary        *slider;
    NSDictionary        *social;
    
    settings = [items objectForKey:@"settings"];
    colors = [settings objectForKey:@"colors"];
    content = [settings objectForKey:@"content"];
    data = [settings objectForKey:@"data"];
    slider = [settings objectForKey:@"slider"];
    social = [settings objectForKey:@"social"];
    
    NSLog(@"%@", settings);
    
    FreeSettings();
    
    g_colorSetting.bc_color = [[colors objectForKey:@"bc_color"] retain];
    g_colorSetting.box_color = [[colors objectForKey:@"box_color"] retain];
    g_colorSetting.box_text_color = [[colors objectForKey:@"box_text_color"] retain];
    g_colorSetting.header_color = [[colors objectForKey:@"header_color"] retain];
    g_colorSetting.text_color = [[colors objectForKey:@"text_color"] retain];
    
    g_contentSetting.header = [[content objectForKey:@"header"] retain];
    g_contentSetting.text = [[content objectForKey:@"text"] retain];
    
    g_dataSetting.delivery_time = [[data objectForKey:@"delivery_time"] retain];
    g_dataSetting.shop_address = [[data objectForKey:@"shop_adress"] retain];
    g_dataSetting.shop_mail = [[data objectForKey:@"shop_mail"] retain];
    g_dataSetting.shop_phone = [[data objectForKey:@"shop_phone"] retain];
    g_dataSetting.shop_url = [[data objectForKey:@"shop_url"] retain];
    
    g_infoSetting.info = [[settings objectForKey:@"info"] retain];
    
    g_sliderSetting.duration = [[slider objectForKey:@"duration"] retain];
    g_sliderSetting.imgURL1 = [[[slider objectForKey:@"img"] objectForKey:@"1"] retain];
    g_sliderSetting.imgURL2 = [[[slider objectForKey:@"img"] objectForKey:@"2"] retain];
    g_sliderSetting.imgURL3 = [[[slider objectForKey:@"img"] objectForKey:@"3"] retain];
    
    g_socialSetting.imgURL = [[social objectForKey:@"image"] retain];
    g_socialSetting.link_url = [[social objectForKey:@"link_url"] retain];
    g_socialSetting.text = [[social objectForKey:@"text"] retain];
    g_socialSetting.title = [[social objectForKey:@"title"] retain];
}

void LoadMap()
{
    NSString *jsonUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false", g_dataSetting.shop_address];
    
    jsonUrl = [jsonUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", jsonUrl);
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:jsonUrl]];
    
    JSONDecoder *jsonKitDecoder = [JSONDecoder decoder];
    NSDictionary *items = [jsonKitDecoder objectWithData:jsonData];
	
    NSLog(@"total items: %d", [items count]);
    
    NSDictionary        *results;
    NSArray             *geometry;
    
    results = [items objectForKey:@"status"];
    if([results isEqual:@"OK"])
    {
        geometry = [items  objectForKey:@"results"];
        NSLog(@"%@", geometry);
        NSLog(@"%@", [[[geometry objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"]);
        
        g_fLat = [[[[[geometry objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] floatValue];
        g_fLon = [[[[[geometry objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] floatValue];
    }
    else
    {
        g_fLat = 0.0f;
        g_fLon = 0.0f;
    }
}

void FreeSettings()
{
    if(!g_colorSetting.bc_color)
        return;
    
    [g_colorSetting.bc_color release];
    [g_colorSetting.box_color release];
    [g_colorSetting.box_text_color release];
    [g_colorSetting.header_color release];
    [g_colorSetting.text_color release];
    
    [g_contentSetting.header release];
    [g_contentSetting.text release];
    
    [g_dataSetting.delivery_time release];
    [g_dataSetting.shop_address release];
    [g_dataSetting.shop_mail release];
    [g_dataSetting.shop_phone release];
    [g_dataSetting.shop_url release];
    
    [g_infoSetting.info release];
    
    [g_sliderSetting.duration release];
    [g_sliderSetting.imgURL1 release];
    [g_sliderSetting.imgURL2 release];
    [g_sliderSetting.imgURL3 release];
    
    [g_socialSetting.imgURL release];
    [g_socialSetting.link_url release];
    [g_socialSetting.text release];
    [g_socialSetting.title release];
    if(g_socialSetting.image)
        [g_socialSetting.image release];
    
    Initialize();
}
