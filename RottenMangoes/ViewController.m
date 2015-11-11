//
//  ViewController.m
//  RottenMangoes
//
//  Created by Samer Rohani on 2015-11-09.
//  Copyright © 2015 Samer Rohani. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"
#import "Review.h"
#import "MovieCollectionViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

@property (weak, nonatomic) IBOutlet UILabel *review1Header;
@property (weak, nonatomic) IBOutlet UILabel *reviewText1;

@property (weak, nonatomic) IBOutlet UILabel *review2Header;
@property (weak, nonatomic) IBOutlet UILabel *reviewText2;

@property (weak, nonatomic) IBOutlet UILabel *reviewHeader3;
@property (weak, nonatomic) IBOutlet UILabel *reviewText3;

@property (nonatomic) NSMutableArray *reviewArray;
@property (nonatomic) Review *review;
@property (nonatomic) MovieCollectionViewCell *cell;

@property (nonatomic) NSURLSessionTask *imageTask;
@property (nonatomic) NSURLSessionTask *reviewTask;

@end

@implementation ViewController



- (void) configureView {
    
    self.movieTitle.text = self.movie.name;
    [self fetchImages:self.movie.imagePoster];
    

    

  
    
    
    [self.reviewTask suspend];
    [self.reviewTask cancel];
    
    NSURL *url = [NSURL URLWithString:self.movie.movieReviewURL];
    NSURLSession *session = [NSURLSession sharedSession];
    self.reviewTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            NSDictionary *reviews = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSArray *reviewDetails = reviews[@"reviews"];
            NSMutableArray *reviewTempArray = [NSMutableArray array];
            
            for (NSMutableDictionary *eachReview in reviewDetails) {
                
                NSString *reviewQuote = eachReview[@"quote"];
                NSString *reviewCritic = eachReview[@"critic"];
                
                NSMutableDictionary *reviews = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                reviewQuote, @"movie review",
                                                reviewCritic, @"movie critic",
                                                nil];
                
                [reviewTempArray addObject:reviews];
                
                
                
            }
            self.movie.movieReview = reviewTempArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *review1 = self.movie.movieReview[0];
                self.review1Header.text = review1[@"movie critic"];
                self.reviewText1.text = review1[@"movie review"];
                
                NSDictionary *review2 = self.movie.movieReview[1];
                self.review2Header.text = review2[@"movie critic"];
                self.reviewText2.text = review2[@"movie review"];
                
                NSDictionary *review3 = self.movie.movieReview[2];
                self.reviewHeader3.text = review3[@"movie critic"];
                self.reviewText3.text = review3[@"movie review"];
                
                
                
            });
        }
        
    }];
    [self.reviewTask resume];
    

    
}







-(void) fetchImages:(NSString *)stringOfImage {
    
    
    
    [self.imageTask suspend];
    [self.imageTask cancel];
    
    NSURL *url = [NSURL URLWithString:stringOfImage];
    NSURLSession *session = [NSURLSession sharedSession];
    self.imageTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            UIImage *image = [UIImage imageWithData:data];

            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.movieImage.image = image;
                
                
            });
        }
        
    }];
    [self.imageTask resume];
    
    
}







- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
