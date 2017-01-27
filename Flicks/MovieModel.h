//
//  MovieModel.h
//  Flicks
//
//  Created by  Carol Hagler on 1/23/17.
//  Copyright © 2017  Carol Hagler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *movieDescription;
@property (nonatomic, strong) NSURL *posterURL;
@property (nonatomic, strong) NSURL *posterURLhigh;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSNumber *voteAve;


@end
