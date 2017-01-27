//
//  MoviePosterCollViewCell.m
//  Flicks
//
//  Created by  Carol Hagler on 1/26/17.
//  Copyright © 2017  Carol Hagler. All rights reserved.
//

#import "MoviePosterCollViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MoviePosterCollViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MoviePosterCollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void) reloadData
{
    [self.imageView setImageWithURL:self.model.posterURLhigh];
    [self setNeedsLayout];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

@end
