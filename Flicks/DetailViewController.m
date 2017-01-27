//
//  DetailViewController.m
//  Flicks
//
//  Created by  Carol Hagler on 1/24/17.
//  Copyright © 2017  Carol Hagler. All rights reserved.
//

#import "DetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *oneTitle;
@property (weak, nonatomic) IBOutlet UILabel *oneDescription;
@property (weak, nonatomic) IBOutlet UILabel *oneReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *oneVoteAve;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView setImageWithURL:self.movieModel.posterURLhigh];
    self.oneTitle.text = self.movieModel.title;
    self.oneDescription.text = self.movieModel.movieDescription;

    self.oneReleaseDate.text = self.movieModel.releaseDate;
    self.oneVoteAve.text = [NSString stringWithFormat:@"%.1f", self.movieModel.voteAve.doubleValue];
    
//    CGRect size = [self.oneDescription.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.oneDescription.bounds), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.oneDescription.font} context:nil];
    
    [self.oneDescription sizeToFit];
    [self.oneTitle sizeToFit];
    
    CGFloat maxY = CGRectGetMaxY(self.oneDescription.frame);
    CGRect contentFrame = self.contentView.frame;
    contentFrame.size.height = (maxY + 36);
    contentFrame.origin.y = ((maxY + 36) * .75);
    
    self.contentView.frame = contentFrame;
    
    CGFloat contentOffsetY = CGRectGetMaxY(self.contentView.frame);
    CGRect scrollViewFrame = self.scrollView.frame;
    scrollViewFrame.size.height = CGRectGetHeight(self.contentView.bounds);
    scrollViewFrame.origin.y = self.view.bounds.size.height - scrollViewFrame.size.height;
    self.scrollView.frame = scrollViewFrame;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, contentOffsetY);
    NSLog(@"%@", self.scrollView);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.imageView.frame = self.view.bounds;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
