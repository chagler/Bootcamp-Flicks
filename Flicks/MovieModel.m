//
//  MovieModel.m
//  Flicks
//
//  Created by  Carol Hagler on 1/23/17.
//  Copyright © 2017  Carol Hagler. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = dictionary[@"original_title"];
        self.movieDescription = dictionary[@"overview"];
        self.releaseDate = dictionary[@"release_date"];
        NSString *urlString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w45%@", dictionary[@"poster_path"] ];
        self.posterURL = [NSURL URLWithString:urlString];
        NSString *urlString2 = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/original%@", dictionary[@"poster_path"] ];
        self.posterURLhigh = [NSURL URLWithString:urlString2];
        self.voteAve = dictionary[@"vote_average"];
    }
    return self;
}

@end
