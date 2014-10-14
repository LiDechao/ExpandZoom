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

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

@synthesize expandZoomImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSArray arrayWithObjects:@"保保保保保保保保保保保保保保保保保保",
                                                @"证证证证证证证证证证证证证证证证证证",
                                                @"图图图图图图图图图图图图图图图图图图",
                                                @"片片片片片片片片片片片片片片片片片片片",
                                                @"的的的的的的的的的的的的的的的的的的的",
                                                @"比比比比比比比比比比比比比比比比比比比",
                                                @"例例例例例例例例例例例例例例例例例例例",
                                                @"不不不不不不不不不不不不不不不不不不不",
                                                @"变变变变变变变变变变变变变变变变变变变", nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    expandZoomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kImageOriginHight, self.tableView.frame.size.width, kImageOriginHight)];
    expandZoomImageView.image = [UIImage imageNamed:@"111.png"];
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
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    //cell的动态效果
    cell.contentView.alpha = 0.5;
    cell.contentView.frame = CGRectMake(-cell.contentView.frame.size.width, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    
    [UIView animateWithDuration:0.5 animations:^{
        cell.alpha = 1.0;
        cell.contentView.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    }];
    
    
    return cell;
}

@end
