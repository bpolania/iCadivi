//
//  manualTableViewController.m
//  iCadivi
//
//  Created by Boris Polania on 11/12/10.
//  Copyright 2010 Lake Lewis Tehcnologies. All rights reserved.
//

#define sectionCount 3
#define manualRowCount 8
#define faqRowCount 7
#define troubleShootRowCount 5

#import "manualTableViewController.h"
#import "iCadiviAppDelegate.h"
#import "manualTextsViewController.h"


@implementation manualTableViewController

@synthesize myTable;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
		
	self.title = @"Instrucciones";
	
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
    switch (section) {
		case 0:
			return manualRowCount;
			break;
		case 1:
			return faqRowCount;
			break;
		case 2:
			return troubleShootRowCount;
			break;
		default:
			return 0;
			break;
	}


}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSInteger fontSize;
	
	NSArray *ayudaArray;
    // Configure the cell...
	
	switch (indexPath.section) {
		case 0:
			ayudaArray = [NSArray arrayWithObjects:@"Crear un nuevo cupo",@"Eliminar un Cupo",@"Registrar gastos en un cupo",@"Consultar gastos registrados en un cupo",@"Eliminar un gasto registrado",@"Enviar un reporte de gastos",@"Visualizar reportes en Excel",@"Visualizar reportes en formato texto",nil];
			fontSize = 14;
			break;
		case 1:
			ayudaArray = [NSArray arrayWithObjects:@"¿Cómo puedo configurar la aplicación iCadivi?",@"¿Es iCadivi multi-divisa?",@"¿Qué información registra iCadivi?",@"¿En qué moneda se registra la comisión del ATM?",@"¿Qué es un reporte Excel?",@"¿Qué es un reporte en formato texto?",@"¿Porqué los reportes Excel tienen la extension .xml?",nil];
			fontSize = 11;
			break;
		case 2:
			ayudaArray = [NSArray arrayWithObjects:@"No aparece la tasa de cambio",@"No se puede enviar reportes",@"Botón \"iCadivi\" no funciona",@"Botón \"Enviar\" no funciona",@"No se puede agregar gastos a un cupo",nil];
			fontSize = 12;
			break;
		default:
			break;
	}
	
	NSString *cellString = [ayudaArray objectAtIndex:indexPath.row];
	[[cell textLabel]setText:cellString];
	[cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:fontSize]];
	
	    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	switch (section) {
		case 0:
			return @"Ayuda";
			break;
		case 1:
			return @"FAQ";
			break;
		case 2:
			return @"Solución de Problemas";
			break;
		default:
			return @"unknown";
			break;
	}
	
	
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
	
	manualTextsViewController *instruccionesTextViewController = [[manualTextsViewController alloc] initWithNibName:@"manualTextsViewController" bundle:nil];
	
	// ...
	// Pass the selected object to the new view controller.
	
	switch (indexPath.section) {
		case 0:
			delegate.selectedHelpSection = 0;
			delegate.selectedItem = indexPath.row;
			[self.navigationController pushViewController:instruccionesTextViewController animated:YES];
			break;
		case 1:
			delegate.selectedHelpSection = 1;
			delegate.selectedItem = indexPath.row;
			[self.navigationController pushViewController:instruccionesTextViewController animated:YES];		
			break;
		case 2:
			delegate.selectedHelpSection = 2;
			delegate.selectedItem = indexPath.row;
			[self.navigationController pushViewController:instruccionesTextViewController animated:YES];		
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

