//
//  expenseDetail.m
//  iCadivi
//
//  Created by Boris Polania on 9/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define sectionCount 1

#import "expenseDetail.h"
#import "gasto.h"
#import "cupo.h"
#import "iCadiviAppDelegate.h"
#import	"expense.h"



@implementation expenseDetail



#pragma mark -
#pragma mark View lifecycle


-(void)loadData:(id)sender {
	
	NSError *error;
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"gasto" 
											  inManagedObjectContext:moc];
	
	[fetchRequest setEntity:entity];
	NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	
	filteredMutableArray = [[NSMutableArray alloc] initWithArray:fetchedObjects];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"cupo == %i",delegate.selectedCupo]];
	[filteredMutableArray filterUsingPredicate:predicate];
	
	[fetchRequest release];
	
}

- (void)viewDidLoad {
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"cmv_bg" ofType:@"png"];
	
	UIImage *imagen = [[UIImage alloc] initWithContentsOfFile:path];	
	[myTable setBackgroundColor:[UIColor colorWithPatternImage:imagen]];
	
	[self loadData:nil];
	
	[filteredMutableArray release];
	
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
	
	//if ([myTable numberOfRowsInSection:0] > 0) {
		[self loadData:nil];
		[myTable reloadData];
		
	//}
	
    [super viewWillAppear:animated];
}

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
    return [filteredMutableArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSError *error;
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"cupo" 
											  inManagedObjectContext:moc];
	
	[fetchRequest setEntity:entity];
	NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	
	NSMutableArray *_filteredMutableArray = [[NSMutableArray alloc] initWithArray:fetchedObjects];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"ID == %i",delegate.selectedCupo]];
	[_filteredMutableArray filterUsingPredicate:predicate];
	
	
	NSString *gastosTitle = [NSString stringWithFormat:@"%@ - Disponible: $%1.2f",[[_filteredMutableArray objectAtIndex:0] nombre],[[[_filteredMutableArray objectAtIndex:0] current_ammount] doubleValue]];
	
	[_filteredMutableArray release];
	[fetchRequest release];
	
	return gastosTitle;
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd-MM-yyyy"];
	
	//Optionally for time zone converstions
	[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
	
	NSString *stringFromDate = [formatter stringFromDate:[[filteredMutableArray objectAtIndex:indexPath.row] fecha]];
	
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
	NSString *cellString = [NSString stringWithFormat:@"%@",[[filteredMutableArray objectAtIndex:indexPath.row] lugar]];
	[[cell textLabel]setText:cellString];
	[cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
	NSString *cellDetailString = [NSString stringWithFormat:@"Monto:$%1.2f       Fecha:%@",[[[filteredMutableArray objectAtIndex:indexPath.row] ammount] doubleValue],stringFromDate];
	[[cell detailTextLabel]setText:cellDetailString];
	[cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
		
	
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
	[formatter release];
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
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	delegate.selectedGasto = [[[filteredMutableArray objectAtIndex:indexPath.row] ID] integerValue];
	expense *_expense = [[expense alloc] initWithNibName:@"expense" bundle:nil];
	[self.navigationController pushViewController:_expense animated:YES];
	
	[_expense release];
	
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

-(void)viewDidDisappear:(BOOL)animated {
	
	self.view = nil;
	
}


- (void)dealloc {
	
	[filteredMutableArray release];
	[myTable release];
	
    [super dealloc];
}


@end

