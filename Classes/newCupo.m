//
//  newCupo.m
//  iCadivi
//
//  Created by Boris Polania on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cupo.h"
#import "gasto.h"
#import "newCupo.h"
#import "noCupoView.h"
#import "iCadiviAppDelegate.h"
//#import "mainCuposView.h"


@implementation newCupo

@synthesize nameTextField, ammountTextField, accountTypeControl;

-(IBAction)doAlert:(id)sender {
	
	if ([ammountTextField.text isEqualToString:@""] || [nameTextField.text isEqualToString:@""]) {
		UIAlertView *alertDialog;
		alertDialog = [[UIAlertView alloc] initWithTitle:@"Falta Información" message:@"Todos los campos del formulario deben estar completados" delegate:nil cancelButtonTitle:@"Volver" otherButtonTitles:nil];
		[alertDialog show];
		[alertDialog release];
	} else {
		UIAlertView *alertDialog;
		alertDialog = [[UIAlertView alloc] initWithTitle:@"¿Está seguro que desea agregar este nuevo cupo?" message:@"" delegate:self cancelButtonTitle:@"Si" otherButtonTitles:@"No",nil];
		[alertDialog show];
		[alertDialog release];
	}

}    

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	NSString *buttonTitle=[alertView buttonTitleAtIndex:buttonIndex];
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if ([buttonTitle isEqualToString:@"Si"]) {
		[self commitInfo:nil];
		[delegate changeTabIndex:0];
	}
	
	
}


-(IBAction)hideKeyboard:(id)sender {
	
	[nameTextField resignFirstResponder];
	[ammountTextField resignFirstResponder];
	[accountTypeControl resignFirstResponder];
	
}

-(IBAction)commitInfo:(id)sender {
	
	NSError *error;
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
		
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"cupo" 
												  inManagedObjectContext:moc];
		[fetchRequest setEntity:entity];
		NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
		
		for (cupo *_cupo in fetchedObjects) {
			
			lastID = [_cupo.ID integerValue];
		}
		
		if ([fetchedObjects count] > 0) {
			lastID++;
		}
		
		NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
		[f setNumberStyle:NSNumberFormatterDecimalStyle];
		NSNumber * ammountNumber = [f numberFromString:ammountTextField.text];
		NSNumber * idNumber = [NSNumber numberWithInt:lastID];
		NSNumber * tipoNumber = [NSNumber numberWithInt: accountTypeControl.selectedSegmentIndex];
		[f release];
		
		
		cupo *nuevoCupo = [NSEntityDescription insertNewObjectForEntityForName:@"cupo" inManagedObjectContext:moc];		
				
		nuevoCupo.ID = idNumber;
		nuevoCupo.tipo = tipoNumber;
		nuevoCupo.nombre = nameTextField.text;
		nuevoCupo.total_ammount = ammountNumber;
		nuevoCupo.current_ammount = ammountNumber;
		
		if (![moc save:&error]) {
			NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
		}

	nameTextField.text	= @"";
	ammountTextField.text = @"";
	[accountTypeControl setSelectedSegmentIndex:0];
	[fetchRequest release];
	
}

-(IBAction)cancel:(id)sender {
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	[delegate changeTabIndex:0];
	
}



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    

	
	[super viewDidLoad];
}
/*

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
	
	[nameTextField release];
	[accountTypeControl release];
	[ammountTextField release];
    [super dealloc];
}


@end
