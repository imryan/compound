//
//  ViewController.m
//  Compound
//
//  Created by Ryan Cohen on 7/27/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

#import "CompoundKit.h"

#import "CPBaseViewController.h"

@interface CPBaseViewController ()

@property (nonatomic, assign) CPWeatherCondition condition;
@property (nonatomic, strong) NSString *temperature;

@property (nonatomic, weak) IBOutlet UILabel *quoteLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation CPBaseViewController

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? 3 : 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return (section == 0) ? @"Today" : @"Status";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [CompoundKit taskIcon];
            cell.textLabel.text = @"Tasks";
            cell.detailTextLabel.text = @"0";
        } else if (indexPath.row == 1) {
            cell.imageView.image = [CompoundKit eventIcon];
            cell.textLabel.text = @"Events";
            cell.detailTextLabel.text = @"0";
        } else if (indexPath.row == 2) {
            cell.imageView.image = [CompoundKit noticeIcon];
            cell.textLabel.text = @"Notices";
            cell.detailTextLabel.text = @"0";
        }
        
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.imageView.image = [CompoundKit pathIcon];
            cell.textLabel.text = @"PATH";
            cell.detailTextLabel.text = @"Good";
        } else if (indexPath.row == 1) {
            cell.imageView.image = [CompoundKit weatherIconForCondition:self.condition];
            cell.textLabel.text = @"Weather";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@˚F", self.temperature];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CompoundKit getQuoteWithCompletion:^(CPQuote *quote, NSError *error) {
        if (!error) {
            NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\"%@\"", quote.quote]];
            NSAttributedString *author = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\n– %@", quote.author]];
            [content appendAttributedString:author];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               self.quoteLabel.attributedText = content; 
            });
        }
    }];
    
    [CompoundKit getWeatherWithCompletion:^(double temperature, CPWeatherCondition condition, NSError *error) {
        if (!error) {
            self.condition = condition;
            self.temperature = [NSString stringWithFormat:@"%.1f", temperature];
            
            [self.tableView reloadData];
        }
    }];
    
    // Fetch weather
     self.condition = CPWeatherConditionSunny;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if ([identifier isEqualToString:@"ToTasks"]) {
        if (indexPath == [NSIndexPath indexPathForRow:0 inSection:0]) {
            return true;
        }
    }
    
    return false;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
}

@end
