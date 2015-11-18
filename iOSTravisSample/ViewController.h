//
//  ViewController.h
//  iOSTravisSample
//
//  Created by natanovia on 2015/11/18.
//  Copyright © 2015年 suwa-hayato.info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImdbMovies.h"

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *showsScrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *showsPageControl;
@property (nonatomic, strong) ImdbMovies* movies;
@property (nonatomic) BOOL pageControlUsed;
@property (nonatomic) NSInteger previousPage;
- (IBAction)pageChanged:(id)sender;

@end

