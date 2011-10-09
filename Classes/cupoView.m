//
//  cupoView.m
//  iCadivi
//
//  Created by Boris Polania on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "expenseDetail.h"
#import "newExpense.h"
#import "newCupo.h"
#import "cupoView.h"
#import "mainCuposView.h"
#import "iCadiviAppDelegate.h"
#import "cupo.h"
#import "gasto.h"


@implementation cupoView

@synthesize nExpense, eDetail, mcView;
@synthesize nameLabel, totalLabel, currentLabel, typeLabel;
@synthesize selectedCupo, expensesDetailButton;


-(IBAction)doAlert:(id)sender {
	
		UIAlertView *alertDialog;
		alertDialog = [[UIAlertView alloc] initWithTitle:@"¿Está seguro que desea eliminar este cupo?" message:@"" delegate:self cancelButtonTitle:@"Si" otherButtonTitles:@"No",nil];
		[alertDialog show];
		[alertDialog release];
}    

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	NSString *buttonTitle=[alertView buttonTitleAtIndex:buttonIndex];
	
	if ([buttonTitle isEqualToString:@"Si"]) {
		[self eliminar:nil];
		[self.navigationController popViewControllerAnimated:NO];
				
	}
	
	
}


-(void)displayData:(id)sender {
	
	NSError *error;
	NSFetchRequest *fetchRequest;
	NSEntityDescription *entity;
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
	
	fetchRequest = [[NSFetchRequest alloc] init];
	entity = [NSEntityDescription entityForName:@"cupo" 
											  inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	for (cupo *info in fetchedObjects) {
		
		if ([info.ID integerValue] == delegate.selectedCupo) {
			
			NSString *tipoString;
			
			switch ([info.tipo integerValue]) {
				case 0:
					tipoString = @"Viajero";
					break;
				case 1:
					tipoString = @"Internet";
					break;
				default:
					break;
			}
			
			self.title = info.nombre;
			nameLabel.text = info.nombre;
			totalLabel.text = [NSString stringWithFormat:@"$%1.2f",[info.total_ammount doubleValue]];
			currentLabel.text = [NSString stringWithFormat:@"$%1.2f",[info.current_ammount doubleValue]];
			typeLabel.text = tipoString;
			
		}
	}
	
	[fetchRequest release];
	
	fetchRequest = [[NSFetchRequest alloc] init];
	entity = [NSEntityDescription entityForName:@"gasto" 
						 inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	NSArray *_fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	
	NSMutableArray *_filteredMutableArray = [[NSMutableArray alloc] initWithArray:_fetchedObjects];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"cupo == %i",delegate.selectedCupo]];
	[_filteredMutableArray filterUsingPredicate:predicate];
	
	if ([_filteredMutableArray count] < 1) {
		[expensesDetailButton setTitle:@"No hay gastos registrados" forState:UIControlStateNormal];
		[expensesDetailButton.titleLabel setTextAlignment:UITextAlignmentCenter];
		expensesDetailButton.enabled = NO;

	} else {
		[expensesDetailButton setTitle:@"Ver detalle de gastos realizados" forState:UIControlStateNormal];
		[expensesDetailButton.titleLabel setTextAlignment:UITextAlignmentCenter];
		expensesDetailButton.enabled = YES;
	}

	[_filteredMutableArray release];
	
	double threshold = 0;
	
	if ([currentLabel.text doubleValue] < threshold ) {
		
		currentLabel.textColor = [UIColor redColor];
		currentLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(14.0)];
		
	}
	
	[fetchRequest release];
		
}


-(IBAction)addNewExpense:(id)sender {
	
	double threshold = 0;
	
	if ([currentLabel.text doubleValue] < threshold ) {
		UIAlertView *alertDialog;
		alertDialog = [[UIAlertView alloc] initWithTitle:@"Cupo Excedido" message:@"El monto asignado para este cupo ha sido excedido, si considera esto un error elimine aquellos gastos que hayan sido registrados erroneamente." delegate:nil cancelButtonTitle:@"Volver" otherButtonTitles:nil];
		[alertDialog show];
		[alertDialog release];
		
	} else {
		[self.navigationController pushViewController:nExpense animated:YES];
	}
	
}

-(IBAction)showExpenseDetail:(id)sender {
	
	[self.navigationController pushViewController:eDetail animated:YES];
	
	
}



-(IBAction)eliminar:(id)sender {
	
	NSError *error;
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
	

	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [[NSEntityDescription alloc] init];
	NSArray *fetchedObjects = [[NSArray alloc] init];
	NSMutableArray *filteredMutableArray = [[NSMutableArray alloc] init];
	NSPredicate *predicate = [[NSPredicate alloc] init];
	
	[entity release];
	
	entity = [NSEntityDescription entityForName:@"cupo" 
											  inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	
    fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	
	[filteredMutableArray release];
	
	filteredMutableArray = [[NSMutableArray alloc] initWithArray:fetchedObjects];
	
	[predicate release];
	
	predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"ID == %i",delegate.selectedCupo]];
	[filteredMutableArray filterUsingPredicate:predicate];
	
	
	[moc deleteObject:[filteredMutableArray objectAtIndex:0]];
	
	entity = [NSEntityDescription entityForName:@"gasto" 
											  inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	
	[entity release];
	
	fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	
	[filteredMutableArray release];
	
	filteredMutableArray = [[NSMutableArray alloc] initWithArray:fetchedObjects];
	
	predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"ID == %i",delegate.selectedCupo]];
	[filteredMutableArray filterUsingPredicate:predicate];
	
	for (gasto *info in filteredMutableArray) {
		
			[moc deleteObject:info];	
		
	}
	 
	[self.navigationController popToRootViewControllerAnimated:NO];

	[fetchRequest release];
	[filteredMutableArray release];

}
	

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
		
		[self viewDidLoad];
		
		// Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[self displayData:nil];
		
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	
	[self displayData:nil];
	
    [super viewWillAppear:animated];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[nExpense release];
	[eDetail release];
	[mcView release];
	[nameLabel release];
	[totalLabel release];
	[currentLabel release];
	[typeLabel release];
	[expensesDetailButton release];
	
    [super dealloc];
}


@end
