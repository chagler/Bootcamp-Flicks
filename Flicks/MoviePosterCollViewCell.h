//
//  MoviePosterCollViewCell.h
//  Flicks
//
//  Created by  Carol Hagler on 1/26/17.
//  Copyright © 2017  Carol Hagler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface MoviePosterCollViewCell : UICollectionViewCell

@property (nonatomic, strong) MovieModel *model;

- (void)reloadData;

@end
