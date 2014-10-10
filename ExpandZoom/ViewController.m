//
//  ViewController.m
//  ExpandZoom
//
//  Created by mfw on 14-10-9.
//  Copyright (c) 2014年 MFW. All rights reserved.
//

#import "ViewController.h"

static CGFloat kImageOriginHight = 240.f;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *expandZoomImageView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

@synthesize expandZoomImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    expandZoomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kImageOriginHight, self.tableView.frame.size.width, kImageOriginHight)];
    expandZoomImageView.image = [UIImage imageNamed:@"LaraCroft.png"];
    expandZoomImageView.contentMode = UIViewContentModeScaleAspectFill; //保证图片比例不变，但是是填充整个ImageView的，可能只有部分图片显示出来。
//    expandZoomImageView.contentMode = UIViewContentModeScaleToFill; //默认,会导致图片变形,所有的相关变量需要自己设置
//    expandZoomImageView.contentMode = UIViewContentModeScaleAspectFit; //会保证图片比例不变，而且全部显示在ImageView中，这意味着ImageView会有部分空白
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(kImageOriginHight, 0, 0, 0);
    [self.tableView addSubview:expandZoomImageView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -kImageOriginHight) {
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        self.expandZoomImageView.frame = f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    return cell;
}

@end
