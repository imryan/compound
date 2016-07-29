//
//  CPTaskCell.h
//  Compound
//
//  Created by Ryan Cohen on 7/28/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPTaskCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *taskLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdAtLabel;
@property (nonatomic, weak) IBOutlet UIButton *completedButton;

@end
