//
//  ayuda.m
//  iCadivi
//
//  Created by Boris Polania on 10/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define sectionCount 1
#define rowCount 2

#import "ayuda.h"
#import	"about.h"
#import "manualTableViewController.h"



@implementation ayuda

@synthesize myTable;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {

	NSString *path = [[NSBundle mainBundle] pathForResource:@"cmv_bg" ofType:@"png"];	
	UIImage *imagen = [[UIImage alloc] initWithContentsOfFile:path];	
	[myTable setBackgroundColor:[UIColor colorWithPatternImage:imagen]];
    [super viewDidLoad];
	


    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return sectionCount;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return rowCount;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
	
	
	NSArray *ayudaArray = [NSArray arrayWithObjects:@"Instrucciones,FAQ y Solución de Problemas",@"Acerca de iCadivi",nil];
	
	NSString *cellString = [ayudaArray objectAtIndex:indexPath.row];
	[[cell textLabel]setText:cellString];
	[cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:13]];
	
	
	
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	about *aboutViewController = [[about alloc] initWithNibName:@"about" bundle:nil];
	manualTableViewController *instruccionesViewController = [[manualTableViewController alloc] initWithNibName:@"manualTableViewController" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 
	switch (indexPath.row) {
		case 0:
			[self.navigationController pushViewController:instruccionesViewController animated:YES];
			break;
		case 1:
			[self.navigationController pushViewController:aboutViewController animated:YES];
			break;
		default:
			break;
	}
	 
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	
	[myTable release];
	
    [super dealloc];
}


@end

