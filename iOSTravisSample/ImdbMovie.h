//
//  ImdbMovie.h
//  iOSTravisSample
//
//  Created by natanovia on 2015/11/18.
//  Copyright © 2015年 suwa-hayato.info. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ImageModel.h"

@protocol ImdbMovie @end

@interface ImdbMovie : JSONModel

/*
 num_votes: 1556753,
 tconst: "tt0111161",
 type: "feature",
 title: "The Shawshank Redemption",
 can_rate: true,
 rating: 9.3,
 image: {
 width: 933,
 url: "http://ia.media-imdb.com/images/M/MV5BODU4MjU4NjIwNl5BMl5BanBnXkFtZTgwMDU2MjEyMDE@._V1_.jpg",
 height: 1388
 },
 year: "1994"
 */

@property (assign, nonatomic) int num_votes;
@property (strong, nonatomic) NSString* title;
@property (assign, nonatomic) double rating;
@property (strong, nonatomic) ImageModel* image;
@property (strong, nonatomic) NSString* year;

@end
