//
//  CPQuote.m
//  Compound
//
//  Created by Ryan Cohen on 7/27/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

#import "CPQuote.h"

@interface CPQuote ()

@property (nonatomic, copy) NSString *quote;
@property (nonatomic, copy) NSString *author;


@end

@implementation CPQuote

- (instancetype)initWithQuote:(NSString *)quote author:(NSString *)author {
    self = [super init];
    
    if (self) {
        self.quote = quote;
        self.author = author;
    }
    
    return self;
}

@end
