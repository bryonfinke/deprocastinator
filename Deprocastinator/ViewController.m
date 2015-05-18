//
//  ViewController.m
//  Deprocastinator
//
//  Created by Bryon Finke on 5/18/15.
//  Copyright (c) 2015 Bryon Finke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray *textInputs;
@property (weak, nonatomic) IBOutlet UITableView *tasksTableView;

@property BOOL edit;

@property NSInteger cellToDelete;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.edit = NO;
    [super viewDidLoad];
    self.textInputs = [[NSMutableArray alloc] init];
}
- (IBAction)onAddButtonPressed:(id)sender {
    [self.textInputs addObject:self.textField.text];
    [self.tasksTableView reloadData];
    self.textField.text = @"";
    [self.view endEditing:YES];
}
- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"Edit"]) {
        sender.title = @"Done";
        self.edit = YES;
        self.tasksTableView.editing = YES;
    } else {
        sender.title = @"Edit";
        self.edit = NO;
        self.tasksTableView.editing = NO;
    }
}
- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.tasksTableView];
    NSIndexPath *swipedIndexPath = [self.tasksTableView indexPathForRowAtPoint:point];
    UITableViewCell *swipedCell = [self.tasksTableView cellForRowAtIndexPath:swipedIndexPath];
    NSArray *colorsArray = [NSArray arrayWithObjects:[UIColor redColor],
                            [UIColor yellowColor],
                            [UIColor greenColor],
                            nil];
    if ([swipedCell.textLabel.textColor isEqual:colorsArray[0]]) {
        swipedCell.textLabel.textColor = colorsArray[1];
    }
    else if ([swipedCell.textLabel.textColor isEqual:colorsArray[1]]) {
        swipedCell.textLabel.textColor = colorsArray[2];
    }
    else {
        swipedCell.textLabel.textColor = colorsArray[0];
    }
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
    if (self.edit) {
        [self.textInputs removeObjectAtIndex:indexPath.row];
        [self.tasksTableView reloadData];
    } else {
        [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor greenColor];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *deleteAlert = [UIAlertView new];
        deleteAlert.title = @"Are you sure?";
        [deleteAlert addButtonWithTitle:@"Yes"];
        [deleteAlert addButtonWithTitle:@"Cancel"];
        deleteAlert.delegate = self;
        self.cellToDelete = indexPath.row;
        [deleteAlert show];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.textInputs removeObjectAtIndex:self.cellToDelete];
        [self.tasksTableView reloadData];
    }
}

@end
