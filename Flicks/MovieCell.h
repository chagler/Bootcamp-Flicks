//
//  MovieCell.h
//  Flicks
//
//  Created by  Carol Hagler on 1/23/17.
//  Copyright © 2017  Carol Hagler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;

@end
