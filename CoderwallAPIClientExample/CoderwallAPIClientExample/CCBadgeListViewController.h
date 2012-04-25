//
//  CCBadgeListViewController.h
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/25.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCBadgeListViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
