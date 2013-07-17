//
//  Global.h
//  PizzaFeedback
//
//  Created by admin on 13-7-16.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REFRESH_TIME        30

typedef struct _COLORS_SETTING_
{
    NSString        *bc_color;
    NSString        *box_color;
    NSString        *box_text_color;
    NSString        *header_color;
    NSString        *text_color;
} COLORS_SETTING;

typedef struct _CONTENT_SETTING_
{
    NSString        *header;
    NSString        *text;
} CONTENT_SETTING;

typedef struct _DATA_SETTING_
{
    NSString        *delivery_time;
    NSString        *shop_address;
    NSString        *shop_mail;
    NSString        *shop_phone;
    NSString        *shop_url;
} DATA_SETTING;

typedef struct _INFO_SETTING_
{
    NSString        *info;
} INFO_SETTING;

typedef struct _SLIDER_SETTING_
{
    NSString        *duration;
    NSString        *imgURL1;
    NSString        *imgURL2;
    NSString        *imgURL3;
} SLIDER_SETTING;

typedef struct _SOCIAL_SETTING_
{
    NSString        *imgURL;
    NSString        *link_url;
    NSString        *text;
    NSString        *title;
    UIImage         *image;
} SOCIAL_SETTING;

extern BOOL             g_biPhone5;
extern COLORS_SETTING   g_colorSetting;
extern CONTENT_SETTING  g_contentSetting;
extern DATA_SETTING     g_dataSetting;
extern INFO_SETTING     g_infoSetting;
extern SLIDER_SETTING   g_sliderSetting;
extern SOCIAL_SETTING   g_socialSetting;
extern float            g_fLon;
extern float            g_fLat;
extern int              g_nRequestID;

void Initialize();
void LoadSettings();
void LoadMap();
void FreeSettings();
UIColor *colorWithHexString(NSString *stringToConvert, float alpha);

