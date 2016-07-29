//
//  CPAssigneeTableViewController.h
//  Compound
//
//  Created by Ryan Cohen on 7/28/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPAssigneeDelegate <NSObject>

- (void)updatedAssignee:(NSString *)assignee;

@end

@interface CPAssigneeTableViewController : UITableViewController

@property (nonatomic, weak) id<CPAssigneeDelegate> delegate;

@end
