//
//  mainCuposView.m
//  iCadivi
//
//  Created by Boris Polania on 9/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define sectionCount 1

#import "mainCuposView.h"
#import "iCadiviAppDelegate.h"
#import "cupo.h"
#import "cupoView.h"



@implementation mainCuposView

@synthesize selectedCupo;
@synthesize cView, myImage,expensesDetailButton;

-(IBAction)doAlert {

	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate changeTabIndex:1];
	
	
		UIAlertView *alertDialog;
		alertDialog = [[UIAlertView alloc] initWithTitle:@"iCadivi" message:@"No se ha registrado ningun cupo en la aplicacion. Debera crear uno nuevo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertDialog show];
		[alertDialog release];	
		

}    


-(void)loadData:(id) sender {
	
	NSError *error;
	NSFetchRequest *fetchRequest;
	NSEntityDescription *entity;
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
	
	fetchRequest = [[NSFetchRequest alloc] init];
	entity = [NSEntityDescription entityForName:@"cupo" 
											  inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	for (cupo *info in fetchedObjects) {
		NSArray *cupoArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@", info.nombre],[NSString stringWithFormat:@"%@",info.total_ammount],[NSString stringWithFormat:@"%@",info.current_ammount],info.ID,nil];
		[cuposArray addObject:cupoArray];
	}
	
	if ([cuposArray count] < 1) {
		[self performSelector:@selector(doAlert) withObject:nil afterDelay:2.5];
	}
	

	[fetchRequest release];
	
}

-(IBAction)back:(id)sender {
	
	[self.navigationController popToRootViewControllerAnimated:YES];
	
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {

	NSString *path = [[NSBundle mainBundle] pathForResource:@"cmv_bg" ofType:@"png"];
	
	UIImage *imagen = [[UIImage alloc] initWithContentsOfFile:path];	
	[myTable setBackgroundColor:[UIColor colorWithPatternImage:imagen]];
	
	[imagen release];

	[super viewDidLoad];
	

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
	
		cuposArray = [[NSMutableArray alloc] init];
		[self loadData:nil];
		[myTable reloadData];


    [super viewWillAppear:animated];
}


/*
- (void)viewDidAppear:(BOOL)animated {
	
	
	
    [super viewDidAppear:animated];
}
 */


- (void)viewWillDisappear:(BOOL)animated {
    
	[cuposArray release];
	
	[super viewWillDisappear:animated];
}


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
    return [fetchedObjects count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	return @"Cupos Disponibles";
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
   
	// Configure the cell...
	
	NSString *cellString = [NSString stringWithFormat:@"%@",[[cuposArray objectAtIndex:indexPath.row] objectAtIndex:0]];
	[[cell textLabel]setText:cellString];
	[cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
	NSString *cellDetailString = [NSString stringWithFormat:@"Aprobado:$%1.2f       Disponible:$%1.2f",[[[cuposArray objectAtIndex:indexPath.row] objectAtIndex:1] doubleValue],[[[cuposArray objectAtIndex:indexPath.row] objectAtIndex:2] doubleValue]];
	[[cell detailTextLabel]setText:cellDetailString];
	[cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
	
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	
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
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	delegate.selectedCupo = [[[cuposArray objectAtIndex:indexPath.row] objectAtIndex:3] integerValue];

	cupoView *_cView = [[cupoView alloc] initWithNibName:@"cupoView" bundle:nil];
	[self.navigationController pushViewController:_cView animated:YES];

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
	
	[cuposArray release];	
	[fetchedObjects release];	
	[myTable release];
	[myImage release];
	[cView release];
	[expensesDetailButton release];
	
    [super dealloc];
}


@end

