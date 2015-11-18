//
//  ImageModel.h
//  iOSTravisSample
//
//  Created by natanovia on 2015/11/18.
//  Copyright © 2015年 suwa-hayato.info. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ImageModel : JSONModel

/*
 width: 933,
 url: "http://ia.media-imdb.com/images/M/MV5BODU4MjU4NjIwNl5BMl5BanBnXkFtZTgwMDU2MjEyMDE@._V1_.jpg",
 height: 1388
 */

@property (assign, nonatomic) int width;
@property (assign, nonatomic) int height;
@property (strong, nonatomic) NSString* url;

@end
