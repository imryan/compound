//
//  CompoundKit.m
//  Compound
//
//  Created by Ryan Cohen on 7/27/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

#import "Keys.h"

#import <AFNetworking/AFNetworking.h>
#import <FontAwesomeKit/FontAwesomeKit.h>

#import "CompoundKit.h"

#define QUOTE_URL   @"http://quotes.rest/qod.json?category=inspire"
#define WEATHER_URL @"http://api.openweathermap.org/data/2.5/weather?q=Hoboken&APPID=%@"

@implementation CompoundKit

#pragma mark - API

+ (void)getQuoteWithCompletion:(CompoundKitGetQuote)completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:QUOTE_URL parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *content = responseObject[@"contents"][@"quotes"][0][@"quote"];
        NSString *author = responseObject[@"contents"][@"quotes"][0][@"author"];
        
        CPQuote *quote = [[CPQuote alloc] initWithQuote:content author:author];
        completion(quote, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

+ (void)getWeatherWithCompletion:(CompoundKitGetWeather)completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:WEATHER_URL, kOpenWeatherMapAPIKey];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSInteger identifier = [responseObject[@"weather"][0][@"main"] integerValue];
        double temperature = [self fahrenheitFromKelvin:[responseObject[@"main"][@"temp"] doubleValue]];
        
        CPWeatherCondition condition = CPWeatherConditionPartlySunny;
        
        if (identifier >= 200 && identifier <= 232) {
            condition = CPWeatherConditionStormy;
            
        } else if (identifier >= 300 && identifier <= 531) {
            condition = CPWeatherConditionRainy;
            
        } else if (identifier >= 600 && identifier <= 622) {
            condition = CPWeatherConditionSnowy;
            
        } else if (identifier >= 801 && identifier <= 804) {
            condition = CPWeatherConditionCloudy;
            
            if (identifier == 801) {
                condition = CPWeatherConditionPartlySunny;
            } else if (identifier == 800) {
                condition = CPWeatherConditionSunny;
            }
            
        } else if (identifier >= 900 && identifier <= 906) {
            condition = CPWeatherConditionStormy;
        }
        
        completion(temperature, condition, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(0, CPWeatherConditionStormy, error);
    }];
}

#pragma mark - Helpers

// F = (K - 273.15)* 1.8000 + 32.00

+ (double)fahrenheitFromKelvin:(double)kelvin {
    return (kelvin - 273.15) * 1.8000 + 32.00;
}

+ (UIImage *)taskIcon {
    FAKIonIcons *taskIcon = [FAKIonIcons clipboardIconWithSize:18.f];
    [taskIcon addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    
    return [taskIcon imageWithSize:CGSizeMake(15, 20)];
}

+ (UIImage *)eventIcon {
    FAKIonIcons *eventIcon = [FAKIonIcons iosCalendarOutlineIconWithSize:18.f];
    [eventIcon addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    
    return [eventIcon imageWithSize:CGSizeMake(15, 20)];
}

+ (UIImage *)noticeIcon {
    FAKIonIcons *noticeIcon = [FAKIonIcons alertCircledIconWithSize:18.f];
    [noticeIcon addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    
    return [noticeIcon imageWithSize:CGSizeMake(15, 20)];
}

+ (UIImage *)pathIcon {
    FAKIonIcons *pathIcon = [FAKIonIcons androidTrainIconWithSize:18.f];
    [pathIcon addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    
    return [pathIcon imageWithSize:CGSizeMake(15, 20)];
}

+ (UIImage *)sunnyWeatherIcon {
    FAKIonIcons *sunnyIcon = [FAKIonIcons iosSunnyIconWithSize:25.f];
    [sunnyIcon addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    
    return [sunnyIcon imageWithSize:CGSizeMake(18, 20)];
}

+ (UIImage *)partlySunnyIcon {
    FAKIonIcons *sunnyIcon = [FAKIonIcons iosPartlysunnyIconWithSize:25.f];
    [sunnyIcon addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    
    return [sunnyIcon imageWithSize:CGSizeMake(18, 20)];
}

+ (UIImage *)cloudyIcon {
    FAKIonIcons *cloudyIcon = [FAKIonIcons iosCloudyIconWithSize:25.f];
    [cloudyIcon addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    
    return [cloudyIcon imageWithSize:CGSizeMake(18, 20)];
}

+ (UIImage *)rainyIcon {
    FAKIonIcons *rainyIcon = [FAKIonIcons iosRainyIconWithSize:25.f];
    [rainyIcon addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    
    return [rainyIcon imageWithSize:CGSizeMake(18, 20)];
}

+ (UIImage *)stormyIcon {
    FAKIonIcons *stormyIcon = [FAKIonIcons iosThunderstormIconWithSize:25.f];
    [stormyIcon addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    
    return [stormyIcon imageWithSize:CGSizeMake(18, 20)];
}

+ (UIImage *)snowyIcon {
    FAKIonIcons *snowyIcon = [FAKIonIcons iosSnowyIconWithSize:25.f];
    [snowyIcon addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    
    return [snowyIcon imageWithSize:CGSizeMake(18, 20)];
}

+ (UIImage *)weatherIconForCondition:(CPWeatherCondition)condition {
    UIImage *image = [UIImage new];
    
    switch (condition) {
        case CPWeatherConditionSunny:
            image = [CompoundKit sunnyWeatherIcon];
            break;
        case CPWeatherConditionPartlySunny:
            image = [CompoundKit partlySunnyIcon];
            break;
        case CPWeatherConditionCloudy:
            image = [CompoundKit cloudyIcon];
            break;
        case CPWeatherConditionRainy:
            image = [CompoundKit rainyIcon];
            break;
        case CPWeatherConditionStormy:
            image = [CompoundKit stormyIcon];
            break;
        case CPWeatherConditionSnowy:
            image = [CompoundKit snowyIcon];
            break;
    }
    
    return image;
}

@end
