//
//  CompoundKit.h
//  Compound
//
//  Created by Ryan Cohen on 7/27/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

#import "CPQuote.h"

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CompoundKit : NSObject

typedef NS_ENUM(NSUInteger, CPWeatherCondition) {
    CPWeatherConditionSunny,
    CPWeatherConditionPartlySunny,
    CPWeatherConditionCloudy,
    CPWeatherConditionRainy,
    CPWeatherConditionStormy,
    CPWeatherConditionSnowy
};

typedef void (^CompoundKitGetQuote)(CPQuote *quote, NSError *error);
typedef void (^CompoundKitGetWeather)(double temperature, CPWeatherCondition condition, NSError *error);

+ (UIImage *)taskIcon;
+ (UIImage *)eventIcon;
+ (UIImage *)noticeIcon;
+ (UIImage *)pathIcon;
+ (UIImage *)weatherIconForCondition:(CPWeatherCondition)condition;

+ (void)getQuoteWithCompletion:(CompoundKitGetQuote)completion;

+ (void)getWeatherWithCompletion:(CompoundKitGetWeather)completion;

@end