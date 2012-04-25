//
//  CCBadgeListViewController.m
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/25.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#define kCoderwallUsername @"slightair"
#define kProfileInfoSectionCellIdentifier @"profileInfoSectionCell"
#define kBadgeSectionCellIdentifier @"badgeSectionCell"

#import "CCBadgeListViewController.h"
#import "CoderwallAPIClient.h"

enum tableViewSections {
    kTableViewSectionProfileInfo = 0,
    kTableViewSectionBadges,
    kNumberOfTableViewSections
};

enum profileInfoSectionCells {
    kProfileInfoSectionCellUsername = 0,
    kProfileInfoSectionCellName,
    kProfileInfoSectionCellLocation,
    kProfileInfoSectionCellEndorsements,
    kNumberOfProfileInfoSectionCells
};

@implementation CCBadgeListViewController
{
    CoderwallUserProfile *profile_;
    BOOL isLoading_;
}

@synthesize navigationBar = navigationBar_;
@synthesize tableView = tableView_;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    profile_ = nil;
    isLoading_ = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!profile_ && !isLoading_) {
        [[CoderwallAPIClient sharedClient] profileForUsername:kCoderwallUsername
                                                   completion:^(CoderwallUserProfile *profile){
                                                       profile_ = profile;
                                                       
                                                       [tableView_ reloadData];
                                                   }
                                                      failure:^(NSError *error){
                                                          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                          [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
                                                      }];
    }
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (!profile_) {
        return 0;
    }
    
    return kNumberOfTableViewSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (!profile_) {
        return 0;
    }
    
    NSInteger rows = 0;
    switch (section) {
        case kTableViewSectionProfileInfo:
            rows = kNumberOfProfileInfoSectionCells;
            break;
        case kTableViewSectionBadges:
            rows = [profile_.badges count];
            break;
        default:
            rows = 0;
            break;
    }
    
    return rows;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case kTableViewSectionProfileInfo:
            cell = [tableView dequeueReusableCellWithIdentifier:kProfileInfoSectionCellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kProfileInfoSectionCellIdentifier];
            }
            switch (indexPath.row) {
                case kProfileInfoSectionCellUsername:
                    cell.textLabel.text = @"Username";
                    cell.detailTextLabel.text = profile_.username;
                    break;
                    
                case kProfileInfoSectionCellName:
                    cell.textLabel.text = @"Name";
                    cell.detailTextLabel.text = profile_.name;
                    break;
                    
                case kProfileInfoSectionCellLocation:
                    cell.textLabel.text = @"Location";
                    cell.detailTextLabel.text = profile_.location;
                    break;
                    
                case kProfileInfoSectionCellEndorsements:
                    cell.textLabel.text = @"Endorsements";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%u", profile_.endorsements];
                    break;
                    
                default:
                    cell.textLabel.text = @"";
                    cell.detailTextLabel.text = @"";
                    break;
            }
            
            break;
        case kTableViewSectionBadges:
            cell = [tableView dequeueReusableCellWithIdentifier:kBadgeSectionCellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kBadgeSectionCellIdentifier];
            }
            
            CoderwallBadge *badge = [profile_.badges objectAtIndex:indexPath.row];
            cell.textLabel.text = badge.name;
            cell.detailTextLabel.text = badge.description;
            [cell.imageView setImageWithURL:badge.badge placeholderImage:[UIImage imageNamed:@"placeholder"]];
            
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    
    switch (section) {
        case kTableViewSectionProfileInfo:
            title = @"Profile";
            break;
        case kTableViewSectionBadges:
            title = @"Badges";
            break;
        default:
            title = @"";
            break;
    }
    
    return title;
}

@end
