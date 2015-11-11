//
//  Review.m
//  RottenMangoes
//
//  Created by Samer Rohani on 2015-11-10.
//  Copyright © 2015 Samer Rohani. All rights reserved.
//

#import "Review.h"

@implementation Review

- (instancetype)initWithCritic:(NSString *)critic quote:(NSString *)quote
{
    self = [super init];
    if (self) {
        self.critic = critic;
        self.quote = quote;
    }
    return self;
}

@end
