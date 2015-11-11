//
//  MovieCollectionViewCell.h
//  RottenMangoes
//
//  Created by Samer Rohani on 2015-11-09.
//  Copyright © 2015 Samer Rohani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieCollectionViewCell : UICollectionViewCell

@property (nonatomic) Movie *movieCell;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;

-(void) fetchImages:(NSString *)stringOfImage;

@end
