//
//  MovieCollectionViewController.m
//  RottenMangoes
//
//  Created by Samer Rohani on 2015-11-09.
//  Copyright © 2015 Samer Rohani. All rights reserved.
//

#import "MovieCollectionViewController.h"
#import "MovieCollectionViewCell.h"
#import "ViewController.h"
#import "Movie.h"

@interface MovieCollectionViewController ()

@property (nonatomic) NSMutableArray *moviesList;
@property (nonatomic) Movie *movie;

@end

@implementation MovieCollectionViewController

static NSString * const reuseIdentifier = @"movieCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=50";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *movies = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSArray *movieDetails = movies[@"movies"];  
            
            
            NSMutableArray *moviesArray = [NSMutableArray array];
            
            for (NSDictionary *eachMovie in movieDetails) {
                
                self.movie = [[Movie alloc] init];
                [self.movie setupMovieInfoWith:eachMovie];
                [moviesArray addObject:self.movie];
                
//                NSDictionary *imagePosters = [eachMovie objectForKey:@"posters"];
//                NSRange range = [imagePosters[@"original"] rangeOfString:@"dkpu1dd"];
//                NSLog(@"%lu",(unsigned long)range.length);
//                if (range.length > 0) {
//                    NSString *subString = [imagePosters[@"original"] substringFromIndex:range.location];
//                    NSString *httpString = @"http://";
//                    NSString *properImageSizeUrl = [httpString stringByAppendingString:subString];
//                    NSURL *url = [NSURL URLWithString:properImageSizeUrl];
//                    
//                } else {
//                    NSURL *url = [NSURL URLWithString:imagePosters[@"original"]];
//                }
                
                
                
            }
            self.moviesList = moviesArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                
            });

        }
        
        
        
    }];
    
    
    [task resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems]lastObject];
        Movie *movie = self.moviesList[indexPath.item];
        ViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.movie = movie;
        
    }
    
    
    
}
//NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
//Movie *object = self.movies[indexPath.row];
//[[segue destinationViewController] setDetailItem:object];

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {  
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return self.moviesList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Movie *movie = self.moviesList[indexPath.item];
    [cell fetchImages:movie.imagePoster];
    cell.movieImage.image = movie.image;
//    [cell fetchImages:movie.url];
    
    return cell;
    
    
//    NSData *imageData = [[NSData alloc] initWithContentsOfURL: movie.url];
//    UIImage *image = [UIImage imageWithData:imageData];
    //    movie.image = image;
//        cell.movieImage.image = image;
    
    
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
