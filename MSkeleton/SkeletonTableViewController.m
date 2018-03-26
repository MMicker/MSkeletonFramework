//
//  SkeletonTableViewController.m
//  MSkeleton
//
//  Created by Micker on 2018/3/12.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "SkeletonTableViewController.h"
#import <MSkeletonFramework/MSkeletonFramework.h>

@interface UISkeletonTableViewCell :UITableViewCell
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *introLabel;
@end

@implementation UISkeletonTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        self.headImageView.isSkeletonable = YES;
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.layer.cornerRadius = 25.0;
        [self.contentView addSubview:self.headImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, CGRectGetWidth(self.bounds)-15, 30)];
        self.nameLabel.isSkeletonable = YES;
        [self.contentView addSubview:self.nameLabel];
        
        self.introLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 40, CGRectGetWidth(self.bounds)-15, 60)];
        self.introLabel.skeletonNumLines = 4;
        self.introLabel.isSkeletonable = YES;
        [self.contentView addSubview:self.introLabel];
    }
    return self;
}

@end

@interface SkeletonTableViewController ()<SkeletonTableViewDataSource>

@end

@implementation SkeletonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:NSClassFromString(@"UISkeletonTableViewCell") forCellReuseIdentifier:@"SkeletonDequeueReusableCellWithIdentifier"];
    self.tableView.estimatedRowHeight = 100;
    [self withTableViewHead];
    [self.view showSkeleton];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view hideSkeleton:YES];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.estimatedRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *dequeueReusableCellWithIdentifier = @"SkeletonDequeueReusableCellWithIdentifier";
    UISkeletonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusableCellWithIdentifier];
    if(!cell) {
        cell = [[UISkeletonTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dequeueReusableCellWithIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.nameLabel.text = self.data[indexPath.row][@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",self.data[indexPath.row][@"title"], @"Skeleton"];
    return cell;
}

- (NSString *)skeletonTableView:(UITableView *)tableView cellIdentifierForRowAt:(NSIndexPath *)indexPath {
    return @"SkeletonDequeueReusableCellWithIdentifier";
}

- (void) withTableViewHead {
    
}
@end

@implementation SkeletonHeaderTableViewController

- (void) withTableViewHead {
    {
        UIView *tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
        tableViewHeader.isSkeletonable = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        imageView.isSkeletonable = YES;
        imageView.backgroundColor = [UIColor orangeColor];
        [tableViewHeader addSubview:imageView];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 80, 80)];
        imageView.isSkeletonable = YES;
        imageView.backgroundColor = [UIColor orangeColor];
        imageView.layer.cornerRadius = CGRectGetWidth(imageView.bounds)/2.0f;
        imageView.layer.masksToBounds = YES;
        [tableViewHeader addSubview:imageView];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(190, 10, CGRectGetWidth(self.view.bounds)-200, 80)];
        label1.isSkeletonable = YES;
        label1.skeletonNumLines = 4;
        [tableViewHeader addSubview:label1];
        
        self.tableView.tableHeaderView = tableViewHeader;
    }
}
@end
