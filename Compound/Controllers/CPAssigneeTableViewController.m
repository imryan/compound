//
//  CPAssigneeTableViewController.m
//  Compound
//
//  Created by Ryan Cohen on 7/28/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

#import "CPAssigneeTableViewController.h"

@interface CPAssigneeTableViewController ()

@property (nonatomic, strong) NSString *assignee;

@end

@implementation CPAssigneeTableViewController

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Roommates";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"ryan"];
    cell.textLabel.text = @"Ryan";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.assignee = @"None";
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.assignee = cell.textLabel.text;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - View

- (void)viewWillDisappear:(BOOL)animated {
    [self.delegate updatedAssignee:self.assignee];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.assignee = @"None";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
