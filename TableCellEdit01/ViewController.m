//
//  ViewController.m
//  TableCellEdit01
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
	NSMutableArray *data;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController {
	int numOfAdd;
}

- (BOOL)alertViewShouldShouldEnableFirstOtherButton:(UIAlertView *)alertView {
	NSString *inputStr = [alertView textFieldAtIndex:0].text;
	return [inputStr length] > 2;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	//TODO
	if(buttonIndex == alertView.firstOtherButtonIndex) {
		UITextField *newStr = [alertView textFieldAtIndex:0];
		if(newStr.text.length > 0) {
//			[data insertObject:newStr.text atIndex:(numOfAdd)];
			[data addObject:newStr.text];
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([data count]-1) inSection:0];
			NSArray *row = [NSArray arrayWithObject:indexPath];
			[self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
		}
		
	}
}

- (IBAction)toogleEdit:(id)sender {
	self.table.editing = !self.table.editing;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.row %3 == 0) {
		return UITableViewCellEditingStyleNone;
	} else if(indexPath.row %3 == 1) {
		return UITableViewCellEditingStyleDelete;
	} else {
		return UITableViewCellEditingStyleInsert;
	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if(UITableViewCellEditingStyleDelete == editingStyle) {
		NSLog(@"%d번째 삭제", indexPath.row);
		[data removeObjectAtIndex:indexPath.row];
		NSArray *rowList = [NSArray arrayWithObject:indexPath];
		[tableView deleteRowsAtIndexPaths:rowList withRowAnimation:UITableViewRowAnimationAutomatic];
	} else {
		NSLog(@"%d번째 추가", indexPath.row);
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"추가" message:nil delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
		alert.alertViewStyle = UIAlertViewStylePlainTextInput;
		[alert show];
		
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
//	cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
	cell.textLabel.text = data[indexPath.row];
	return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	data = [NSMutableArray arrayWithObjects:@"Item0",@"Item1",@"Item2",@"Item3",@"Item4",@"Item5",@"Item6",@"Item7", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end















