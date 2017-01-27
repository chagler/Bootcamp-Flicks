//
//  ViewController.m
//  Flicks
//
//  Created by  Carol Hagler on 1/23/17.
//  Copyright © 2017  Carol Hagler. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "MovieCell.h"
#import "MovieModel.h"
#import "MoviePosterCollViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <MBProgressHUD.h>

typedef NS_ENUM(NSInteger, MovieListType) {
    MovieListTypeNowPlaying,
    MovieListTypeTopRated,
};

@interface ViewController () <UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *movieTableView;
@property (weak, nonatomic) IBOutlet UIView *ErrorView;

@property (strong, nonatomic) NSArray<MovieModel *> *movies;
@property (nonatomic, assign) MovieListType type;
@property (nonatomic, strong) UIRefreshControl *tableRefreshControl;
@property (nonatomic, strong) UIRefreshControl *collRefreshControl;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *viewSelector;

@end

@implementation ViewController

- (IBAction)updateLayout:(id)sender {
    if (self.viewSelector.selectedSegmentIndex == 0)
    {
        self.collectionView.hidden = YES;
        self.movieTableView.hidden = NO;
    } else {
        self.collectionView.hidden = NO;
        self.movieTableView.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.movieTableView.dataSource = self;
    
    static NSDictionary<NSString *, NSNumber *> *restorationIdentifierToTypeMapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        restorationIdentifierToTypeMapping = @{
            @"now_playing": @(MovieListTypeNowPlaying),
            @"top_rated": @(MovieListTypeTopRated),
        };
    });
    self.type = restorationIdentifierToTypeMapping[self.restorationIdentifier].integerValue;
    
    self.tableRefreshControl = [[UIRefreshControl alloc] init];
    self.collRefreshControl = [[UIRefreshControl alloc] init];
    [self.tableRefreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.collRefreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.movieTableView addSubview:self.tableRefreshControl];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
    CGFloat itemHeight = 150;
    CGFloat itemWidth = screenWidth / 3;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 64) collectionViewLayout: layout];
    [collectionView registerClass:[MoviePosterCollViewCell class] forCellWithReuseIdentifier:@"MoviePosterCollViewCell"];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    collectionView.hidden = YES;
    self.movieTableView.hidden = NO;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [self.collectionView addSubview:self.collRefreshControl];
    [self fetchMovies];
}

- (void)fetchMovies {
    self.ErrorView.hidden = YES;
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
    NSString *typePathComponent;
    switch (self.type) {
        case MovieListTypeNowPlaying:
            typePathComponent = @"now_playing";
            break;
        case MovieListTypeTopRated:
            typePathComponent = @"top_rated";
        break;    }
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@", typePathComponent, apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
        delegate:nil
        delegateQueue:[NSOperationQueue mainQueue]];
    
    // Display HUD right before the request is made
    [MBProgressHUD showHUDAddedTo:self.view animated:(YES)];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
        completionHandler:^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
            if (!error) {
                NSError *jsonError = nil;
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                NSLog(@"Response: %@", responseDictionary);
                NSArray *results = responseDictionary[@"results"];
                
                NSMutableArray *models = [NSMutableArray array];
                
                for (NSDictionary *result in results) {
                    MovieModel *model = [[MovieModel alloc] initWithDictionary:result];
                    NSLog(@"Model - %@", model);
                    [models addObject:model];
                }
                self.movies = models;
                [self.movieTableView reloadData];
                [self.collectionView reloadData];
            } else {
                NSLog(@"An error occurred: %@", error.description);
                self.ErrorView.hidden = NO;
                [self.view bringSubviewToFront:self.ErrorView];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableRefreshControl endRefreshing];
            [self.collRefreshControl endRefreshing];
        }];
    [task resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// data source
- (NSInteger)tableView:(UITableView *)movieTableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    
    MovieModel *model = [self.movies objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = model.title ;
    cell.overviewLabel.text = model.movieDescription;
    cell.posterImage.contentMode = UIViewContentModeScaleAspectFit;
    [cell.posterImage setImageWithURL:model.posterURL];

    
    NSLog(@"row number = %ld", indexPath.row);
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[NSIndexPath class]])
    {
        MovieModel *model = [self.movies objectAtIndex:((NSIndexPath *)sender).row];
        DetailViewController *dvc = segue.destinationViewController;
        dvc.movieModel = model;
    }
    else if ([sender isKindOfClass:[MovieCell class]])
    {
        MovieCell *cellPtr = sender;
        NSIndexPath *indexPath = [self.movieTableView indexPathForCell:cellPtr];
        MovieModel *model = [self.movies objectAtIndex:indexPath.row];
        DetailViewController *dvc = segue.destinationViewController;
        dvc.movieModel = model;
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (__kindof UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoviePosterCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoviePosterCollViewCell" forIndexPath:indexPath];
    MovieModel *model = [self.movies objectAtIndex:indexPath.item];
    cell.model = model;
    [cell reloadData];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
    self.movieTableView.frame = self.view.bounds;
}

@end
