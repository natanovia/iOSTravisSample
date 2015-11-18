//
//  ViewController.m
//  iOSTravisSample
//
//  Created by natanovia on 2015/11/18.
//  Copyright © 2015年 suwa-hayato.info. All rights reserved.
//

#import "ViewController.h"
#import "APIClient.h"
#import "ImdbMovie.h"
#import "ImdbMovies.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import <SAMCategories/UIScreen+SAMAdditions.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    APIClient *client = [APIClient sharedClient];
    [client getTop250:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Success -- %@", responseObject);
        
        [self parseData:responseObject];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Failure -- %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) parseData:(id) data {
    
    if ([data isKindOfClass:[NSData class]]) {
        NSLog(@"NSData");
    }
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSLog(@"NSDictionary");
    }
    
    if ([data isKindOfClass:[NSArray class]]) {
        NSLog(@"NSArray");
    }
    
    //    NSDictionary* dict = data;
    //    NSDictionary* movies = [[[dict valueForKey:@"data"] valueForKey:@"list"] valueForKey:@"list"];
    //    NSLog(@"count -- %lu", [movies count]);
    //    for ( NSDictionary* movie in movies ) {
    //
    //        NSLog(@"title -- %@", [movie valueForKey:@"title"]);
    //        NSLog(@"year -- %@", [movie valueForKey:@"year"]);
    //        NSLog(@"rating -- %@", [movie valueForKey:@"rating"]);
    //        NSLog(@"numVotes -- %@", [movie valueForKey:@"num_votes"]);
    //        NSLog(@"imageUrl -- %@", [[movie valueForKey:@"image"] valueForKey:@"url"]);
    //    }
    
    self.movies = [[ImdbMovies alloc] initWithDictionary:data error:nil];
    NSInteger count = [[self.movies items] count];
    NSLog(@"count -- %lu", count);
    
    for ( ImdbMovie* movie in [self.movies items] ) {
        
        NSLog(@"title -- %@", [movie title]);
        NSLog(@"year -- %@", [movie year]);
        NSLog(@"rating -- %f", [movie rating]);
        NSLog(@"numVotes -- %d", [movie num_votes]);
        NSLog(@"imageUrl -- %@", [[movie image] url]);
    }
    
    NSInteger index = 0;
    NSInteger pageLimit = 10;
    // Setup PageControl
    self.showsPageControl.numberOfPages = (count > pageLimit) ? pageLimit : count;
    self.showsPageControl.currentPage = index;
    
    // Setup ScrollView
    self.showsScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * count,
                                                  CGRectGetHeight(self.showsScrollView.frame));
    
    ImdbMovie *movie = [[self.movies items] objectAtIndex:index];
    [self loadMovie :movie :index];
}

- (void) loadMovie:(ImdbMovie*) movie
                  :(NSInteger) index {
    
    // Display the show title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                    index * CGRectGetWidth(self.showsScrollView.bounds) + 20, 20,
                                                                    CGRectGetWidth(self.showsScrollView.bounds) - 40, 40)];
    titleLabel.text = [NSString stringWithFormat:@"%@ - %@", [movie title], [movie year]];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0; // auto wordwrap
    
    // Add to scroll view
    [self.showsScrollView addSubview:titleLabel];
    
    // Get image
    NSString *posterUrl = [[movie image] url];
    //    if ([[UIScreen mainScreen] sam_isRetina]) {
    //        posterUrl = [posterUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@"-300.jpg"];
    //    } else {
    //        posterUrl = [posterUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@"-138.jpg"];
    //    }
    
    // Display image using image view
    UIImageView *posterImage = [[UIImageView alloc] init];
    posterImage.clipsToBounds = YES;
    [posterImage setContentMode:UIViewContentModeScaleAspectFill];
    NSUInteger width = lrintf(100 + CGRectGetWidth(self.view.frame) / 4);
    posterImage.frame = CGRectMake(index * CGRectGetWidth (self.view.frame) + (CGRectGetWidth(self.view.frame) - width) * 0.5, CGRectGetMaxY(titleLabel.frame) + 40, width, width * 16 / 9);
    
    [self.showsScrollView addSubview:posterImage];
    
    // Asynchronously load the image
    [posterImage setImageWithURL:[NSURL URLWithString:posterUrl]];// placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [self.showsScrollView addSubview:posterImage];
}

- (IBAction)pageChanged:(id) sender {
    // Set flag
    self.pageControlUsed = YES;
    
    // Get previous page number
    NSInteger page = self.showsPageControl.currentPage;
    self.previousPage = page;
    
    // Call loadMovie for the new page
    ImdbMovie *movie = [[self.movies items] objectAtIndex:page];
    [self loadMovie :movie :page];
    NSLog(@"pageChanged -- page:%ld", page);
    
    // Scroll to the new page
    CGRect frame = self.showsScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [UIView animateWithDuration:0.5f animations:^{
        [self.showsScrollView scrollRectToVisible:frame animated:NO];
    } completion:^(BOOL finished) {
        self.pageControlUsed = NO;
    }];
}

- (void) scrollViewDidScroll:(UIScrollView *) sender {
    
    // Was the scrolling initiated via page control?
    if ( self.pageControlUsed ) {
        return;
    }
    
    // Figure out page to scroll to
    CGFloat pageWidth = sender.frame.size.width;
    NSInteger page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    // Setup boundary
    NSInteger MAX_VALUE = sender.frame.size.width * (self.showsPageControl.numberOfPages - 1);
    CGPoint scrollViewOffset = sender.contentOffset;
    if (scrollViewOffset.x > MAX_VALUE) {
        scrollViewOffset.x = MAX_VALUE;
    }
    [sender setContentOffset:scrollViewOffset];
    
    // Do not do anything if we're trying to go beyond the available page range
    if ( page == self.previousPage || page < 0 || page >= self.showsPageControl.numberOfPages ) {
        return;
    }
    
    self.previousPage = page;
    // Set the page control page display
    self.showsPageControl.currentPage = page;
    
    NSLog(@"scrollViewDidScroll -- page:%ld", page);
    
    // Load the page
    ImdbMovie *movie = [[self.movies items] objectAtIndex:page];
    [self loadMovie :movie :page];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *) sender {
    self.pageControlUsed = NO;
}

@end
