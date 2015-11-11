//
//  Movie.m
//  RottenMangoes
//
//  Created by Samer Rohani on 2015-11-09.
//  Copyright © 2015 Samer Rohani. All rights reserved.
//

#import "Movie.h"

@implementation Movie


-(void)setupMovieInfoWith:(NSDictionary *)movieDetails {
    
    self.name = movieDetails[@"title"];
    self.imageURL = movieDetails[@"posters"][@"original"];
    self.imagePoster = [self imageURLChange:self.imageURL];
    self.movieReviewURL = [movieDetails[@"links"][@"reviews"] stringByAppendingString:@"?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=50"];

    
}


- (NSString *) imageURLChange:(NSString *)url {
    
    NSRange range = [self.imageURL rangeOfString:@"dkpu1dd"];

    
    if (range.length > 0) {
        NSString *subString = [self.imageURL substringFromIndex:range.location];
        NSString *httpString = @"http://";
        NSString *properImageSizeUrl = [httpString stringByAppendingString:subString];
        return properImageSizeUrl;
        
        
    } else {
        return url;
        
    }

    
}

@end
