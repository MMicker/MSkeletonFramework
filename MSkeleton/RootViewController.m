//
//  RootViewController.m
//  MSkeleton
//
//  Created by Micker on 2018/3/8.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "RootViewController.h"
#import <MSkeletonFramework/MSkeletonFramework.h>

@interface RootViewController ()<UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.isSkeletonable = YES;
        [_tableView registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:@"AdequeueReusableCellWithIdentifier"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *) data {
    if (!_data) {
        _data = [NSMutableArray array];
        [_data addObject:@{@"title":@"UIKit",@"class":@"UIKitViewController"}];
        [_data addObject:@{@"title":@"UIScrollView",@"class":@"UIScrollViewController"}];
        [_data addObject:@{@"title":@"UITableView",@"class":@"SkeletonTableViewController"}];
        [_data addObject:@{@"title":@"UITableView-Head",@"class":@"SkeletonHeaderTableViewController"}];
        [_data addObject:@{@"title":@"UICollectionView-V",@"class":@"SkeletonCollectionViewController"}];
        [_data addObject:@{@"title":@"UICollectionView-H",@"class":@"SkeletonHCollectionViewController"}];
    }
    return _data;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *dequeueReusableCellWithIdentifier = @"AdequeueReusableCellWithIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusableCellWithIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dequeueReusableCellWithIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.data[indexPath.row][@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",self.data[indexPath.row][@"title"], @"Skeleton"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *classString = self.data[indexPath.row][@"class"];
    Class newClass = NSClassFromString(classString);
    UIViewController *controller = [[newClass alloc] init];
    controller.title = self.data[indexPath.row][@"title"];
    if (controller)
        [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
