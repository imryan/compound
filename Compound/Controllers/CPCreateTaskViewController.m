//
//  CPCreateTaskViewController.m
//  Compound
//
//  Created by Ryan Cohen on 7/27/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

#import "CPTaskInputCell.h"
#import "CPAssigneeTableViewController.h"

#import "CPCreateTaskViewController.h"

@interface CPCreateTaskViewController () <CPAssigneeDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *assignee;

- (IBAction)create:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@implementation CPCreateTaskViewController

#pragma mark - Functions

- (IBAction)create:(id)sender {
    NSLog(@"Created");
    
    [self cancel:sender];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - CPAssigneeDelegate

- (void)updatedAssignee:(NSString *)assignee {
    self.assignee = assignee;
}

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return (section == 0) ? @"Task" : @"Assignee";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *inputCellId = @"InputCellId";
    static NSString *cellId = @"CellId";
    
    if (indexPath.section == 0) {
        CPTaskInputCell *inputCell = (CPTaskInputCell *)[tableView dequeueReusableCellWithIdentifier:inputCellId];
        
        if (!inputCell) {
            inputCell = [[CPTaskInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inputCellId];
        }
        
        if (indexPath.row == 0) {
            [inputCell.textField becomeFirstResponder];
        }
        
        return inputCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.text = self.assignee;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - View

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.assignee = @"None";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CPAssigneeTableViewController *assigneeController = (CPAssigneeTableViewController *)[segue destinationViewController];
    assigneeController.delegate = self;
}

@end
