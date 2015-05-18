//
//  ViewController.m
//  Deprocastinator
//
//  Created by Bryon Finke on 5/18/15.
//  Copyright (c) 2015 Bryon Finke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray *textInputs;
@property (weak, nonatomic) IBOutlet UITableView *tasksTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textInputs = [[NSMutableArray alloc] init];
}
- (IBAction)onAddButtonPressed:(id)sender {
    [self.textInputs addObject:self.textField.text];
    [self.tasksTableView reloadData];
    self.textField.text = @"";
    [self.view endEditing:YES];
}
- (IBAction)onEditButtonPressed:(id)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textInputs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    cell.textLabel.text = self.textInputs[indexPath.row];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor greenColor];
}

@end
