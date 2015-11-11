//
//  MovieCollectionViewCell.m
//  RottenMangoes
//
//  Created by Samer Rohani on 2015-11-09.
//  Copyright © 2015 Samer Rohani. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import "Movie.h"

@interface MovieCollectionViewCell ()

@property (nonatomic) NSURLSessionTask *downloadImageTask;



@end

@implementation MovieCollectionViewCell

-(void) fetchImages:(NSString *)stringOfImage {
    
    
    
    [self.downloadImageTask suspend];
    [self.downloadImageTask cancel];
    
    NSURL *url = [NSURL URLWithString:stringOfImage];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.movieImage.image = image;
                
                
            });
        }
        
    }];
    [task resume];
    self.downloadImageTask = task;
    
}


- (void)prepareForReuse {
    
    [super prepareForReuse];
    self.movieImage.image = nil;
    
    
    
}












@end
