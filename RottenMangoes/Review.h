//
//  Review.h
//  RottenMangoes
//
//  Created by Samer Rohani on 2015-11-10.
//  Copyright © 2015 Samer Rohani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (nonatomic) NSString *critic;
@property (nonatomic) NSString *quote;
@property (nonatomic) NSMutableArray *reviewArray;

- (instancetype)initWithCritic:(NSString *)critic quote:(NSString *)quote;

@end
