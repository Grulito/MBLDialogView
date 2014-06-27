//
//  ViewController.m
//  MBLDialogView
//
//  Created by Administrateur on 27/06/2014.
//  Copyright (c) 2014 Administrateur. All rights reserved.
//

#import "ViewController.h"
#import "MBDialogView.h"

@interface ViewController ()
{
	NSArray *_feed;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.view.backgroundColor = [UIColor lightGrayColor];
	[self showDialog];
	[self showDialogTable];
}

- (void)showDialog
{
	MBDialogView *dialogView = [[MBDialogView alloc] initWithFrame:CGRectMake(10, 420, 200, 70) andArrowDirection:MBLDirectionSouth andOffset:20];
	UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15]; // light
    UILabel *headerLabel             = [[UILabel alloc] initWithFrame:CGRectInset([dialogView getDialogFrame], 10, 0)];
    headerLabel.text                     = @"Hello world ! How do you feel today ?";
	headerLabel.lineBreakMode = NSLineBreakByWordWrapping;
	headerLabel.numberOfLines = 0;
    headerLabel.font                     = font;
	[headerLabel setTextColor:[UIColor blackColor]];
	[dialogView addSubview:headerLabel];
	[self.view addSubview:dialogView];
}

- (void)showDialogTable
{
	MBDialogView *dialogView = [[MBDialogView alloc] initWithFrame:CGRectMake(150, 30, 150, 200) andArrowDirection:MBLDirectionSouth andOffset:20];
	[self.view addSubview:dialogView];
	
	UITableView *_tableViewer = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 200, 265) style:UITableViewStylePlain];
	_tableViewer.delegate = self;
	_tableViewer.dataSource = self;
	
    UIView *header                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dialogView.frame.size.width, 35)];
    header.backgroundColor             = [UIColor colorWithRed:240./255. green:240./255. blue:240./255. alpha:1.];
	
	UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17]; // light
    UITextField *headerLabel             = [[UITextField alloc] initWithFrame:header.frame];
    headerLabel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    headerLabel.text                     = @"Feed";
    headerLabel.font                     = font;
    headerLabel.textAlignment            = NSTextAlignmentCenter;
	headerLabel.enabled                  = NO;
	[headerLabel setTextColor:[UIColor blackColor]];
	
	[header addSubview:headerLabel];
	
	[dialogView addSubview:header];
	[dialogView addSubview:_tableViewer];
	
	_feed = @[@"Grulito connected",@"Data loaded",@"Game started"];
	[self.view addSubview:dialogView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
	return [_feed count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
	cell.textLabel.text = _feed[indexPath.row];
	return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
