//
//  Movie.h
//  RottenMangoes
//
//  Created by Samer Rohani on 2015-11-09.
//  Copyright © 2015 Samer Rohani. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;



@interface Movie : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString *imagePoster;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *movieReviewURL;
@property (nonatomic) NSMutableArray *movieReview;


-(void)setupMovieInfoWith:(NSDictionary *)movieDetails;
- (NSString *) imageURLChange:(NSString *)url;

@end
