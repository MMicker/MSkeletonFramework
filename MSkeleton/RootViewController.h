//
//  RootViewController.h
//  MSkeleton
//
//  Created by Micker on 2018/3/8.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource>
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) NSMutableArray *data;

@end
