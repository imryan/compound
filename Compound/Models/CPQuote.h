//
//  CPQuote.h
//  Compound
//
//  Created by Ryan Cohen on 7/27/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPQuote : NSObject

@property (nonatomic, readonly) NSString *quote;
@property (nonatomic, readonly) NSString *author;

- (instancetype)initWithQuote:(NSString *)quote author:(NSString *)author;

@end
