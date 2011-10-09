//
//  mainViewController.m
//  iCadivi
//
//  Created by Boris Polania on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "mainViewController.h"
#import "cupoView.h"
#import "noCupoView.h"
#import "cupo.h"
#import "mainCuposView.h"
#import "iCadiviAppDelegate.h"

@implementation mainViewController

@synthesize cView, ncView, mainView;

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	
	if ([viewController.title isEqualToString:@"mvc"]) {
		NSLog(@"celta loco");
		[[viewController view] reloadInputViews];

		[self setInitialView:nil];
	}
	
}

-(void)setInitialView:(id)sender {
	
	if (tempBool) {
		[self.navigationController pushViewController:mainView animated:YES];
	} else if (!tempBool) {
		[self.navigationController pushViewController:ncView animated:YES];
	}
	
	
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	tempBool = YES;
	
	NSError *error;
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [[NSEntityDescription alloc] init];
	NSArray *fetchedObjects = [[NSArray alloc] init];
	
	entity = [NSEntityDescription entityForName:@"cupo" 
						 inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	
	if ([fetchedObjects count] < 1) {
		tempBool = NO;
	}
	
	
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)viewDidDisappear:(BOOL)animated {

	self.view = nil;
		
}

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
    [super dealloc];
}


@end
