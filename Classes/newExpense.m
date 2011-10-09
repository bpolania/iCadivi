//
//  newExpense.m
//  iCadivi
//
//  Created by Boris Polania on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "newExpense.h"
#import "gasto.h"
#import "cupo.h"
#import "mainCuposView.h"
#import "iCadiviAppDelegate.h"
#import "expenseDetail.h"
#import "cupoView.h"


@implementation newExpense

@synthesize ammountTextField, lugarTextField, dayTextField, monthTextField, yearTextField, ATMTextField, ATMLabel, currencyLabel, expenseTypeControl, exchangeLabel, exchangeRateTextField;
@synthesize montoEnUSDLabel, tazaLabel, lugarLabel, diaLabel, mesLabel, anoLabel, doneButton;
@synthesize mcView;
@synthesize theScroller;

- (BOOL)isConnected:(id)sender
{
	NSURL *url = [[[NSURL alloc] initWithString:@"http://www.google.com/finance/converter?a=1&from=USD&to=USD"] autorelease];
	NSString *fileString = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:nil]; // reads file into memory as an NSString
	
	
	BOOL connected;
		
	if (fileString == nil) {
		connected = NO;
	} else {
		connected = YES;
	}

	return connected;
}

-(IBAction)doAlert:(id)sender {
	
	if ([ammountTextField.text isEqualToString:@""]) {
		UIAlertView *alertDialog;
		alertDialog = [[UIAlertView alloc] initWithTitle:@"Falta Informacion" message:@"Debe especificar al menos un monto para la transacción" delegate:nil cancelButtonTitle:@"Volver" otherButtonTitles:nil];
		[alertDialog show];
		[alertDialog release];
	} else {
		UIAlertView *alertDialog;
		alertDialog = [[UIAlertView alloc] initWithTitle:@"¿Está seguro que desea agregar este nuevo gasto?" message:@"" delegate:self cancelButtonTitle:@"Si" otherButtonTitles:@"No",nil];
		[alertDialog show];
		[alertDialog release];		
	}

}    

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	NSString *buttonTitle=[alertView buttonTitleAtIndex:buttonIndex];
	
	if ([buttonTitle isEqualToString:@"Si"]) {
		[self commitInfo:nil];
		[self.navigationController popViewControllerAnimated:NO];
		
	}
	
	
}


-(void)formatOneDigitDate:(id)sender {
	
	if ([monthTextField.text integerValue] < 10 && [monthTextField.text integerValue] > 0 && [monthTextField.text length] < 2) {

		monthTextField.text = [NSString stringWithFormat:@"0%@",monthTextField.text];
	}
	
	if ([dayTextField.text integerValue] < 10 && [dayTextField.text integerValue] > 0 && [dayTextField.text length] < 2) {
		
		dayTextField.text = [NSString stringWithFormat:@"0%@",dayTextField.text];
	}
	
}

-(void)arrangeFieldsAndLabels:(id)sender {
	
	ammountTextField.text = @"";
	exchangeRateTextField.text = @"";
	lugarTextField.text = @"";
	ATMTextField.text = @"";	
	
	if ([selectedCurrency isEqualToString:@"USD"]) {
		exchangeLabel.hidden = YES;
		montoEnUSDLabel.hidden = YES;
		tazaLabel.hidden = YES;
		exchangeRateTextField.hidden = YES;
		lugarLabel.frame = CGRectMake(20, 55, 74, 21);
		diaLabel.frame = CGRectMake(23, 100, 38, 21);
		mesLabel.frame = CGRectMake(127, 100, 38, 21);
		anoLabel.frame = CGRectMake(221, 100, 38, 21);
		ATMLabel.frame = CGRectMake(166, 140, 125, 21);
		lugarTextField.frame = CGRectMake(101.0, 50.0, 206.0, 31.0);
		dayTextField.frame = CGRectMake(71.0, 95.0, 45.0, 31.0);
		monthTextField.frame = CGRectMake(165.0, 95.0, 45.0, 31.0);
		yearTextField.frame = CGRectMake(262.0, 95.0, 45.0, 31.0);
		ATMTextField.frame = CGRectMake(267.0, 135.0, 40.0, 31.0);
		expenseTypeControl.frame = CGRectMake(17, 135, 136, 28);
		doneButton.frame = CGRectMake(131, 200, 111, 48);
		
	} else {
		exchangeLabel.hidden = NO;
		montoEnUSDLabel.hidden = NO;
		tazaLabel.hidden = NO;
		exchangeRateTextField.hidden = NO;
		tazaLabel.frame = CGRectMake(166, 45, 43, 21); 
		montoEnUSDLabel.frame = CGRectMake(18, 45, 97, 21); 
		exchangeLabel.frame = CGRectMake(123, 45, 42, 21); 
		lugarLabel.frame = CGRectMake(20, 80, 74, 21);
		diaLabel.frame = CGRectMake(23, 110, 38, 21);
		mesLabel.frame = CGRectMake(127, 110, 38, 21);
		anoLabel.frame = CGRectMake(221, 110, 38, 21);
		ATMLabel.frame = CGRectMake(166, 155, 125, 21);
		lugarTextField.frame = CGRectMake(101.0, 75.0, 206.0, 31.0);
		dayTextField.frame = CGRectMake(71.0, 110.0, 45.0, 25.0);
		monthTextField.frame = CGRectMake(165.0, 110.0, 45.0, 31.0);
		yearTextField.frame = CGRectMake(262.0, 110.0, 45.0, 31.0);
		ATMTextField.frame = CGRectMake(267.0, 150.0, 40.0, 31.0);
		exchangeRateTextField.frame = CGRectMake(221.0, 40.0, 86.0, 30.0); 
		expenseTypeControl.frame = CGRectMake(17, 150, 136, 28);		
		doneButton.frame = CGRectMake(131, 210, 111, 48);
	}	
	
}

-(void)convert:(id)sender {
	
	double finalAmmount;
	double reverseExchange;
	
	if ([self isConnected:nil]) {
		if ([selectedCurrency isEqualToString:@"USD"]) {
			reverseExchange = 1.00;
		} else {
			reverseExchange = [self getExchangeRateToCurrency:selectedCurrency];
		}
		
		finalAmmount = [ammountTextField.text doubleValue] / reverseExchange;
		
		exchangeRateTextField.text = [NSString stringWithFormat:@"%1.2f", reverseExchange];
		currencyLabel.text = [NSString stringWithFormat:@"Monto en Moneda Local (%@):", selectedCurrency];
		exchangeLabel.text = [NSString stringWithFormat:@"%1.2f",finalAmmount];
		
	} else {
		
		if ([selectedCurrency isEqualToString:@"USD"]) {
		
			reverseExchange = 1.00;
		
		} else {
			
			reverseExchange = [exchangeRateTextField.text doubleValue];
	
		}
		
		finalAmmount = [ammountTextField.text doubleValue] / reverseExchange;
		
		exchangeRateTextField.text = [NSString stringWithFormat:@"%1.2f", reverseExchange];
		currencyLabel.text = [NSString stringWithFormat:@"Monto en Moneda Local (%@):", selectedCurrency];
		exchangeLabel.text = [NSString stringWithFormat:@"%1.2f",finalAmmount];
		
	}
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	
	[self convert:selectedCurrency];
	
}

- (double)getExchangeRateToCurrency:(NSString *)currency {
	
	double exValue;
	
	NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.google.com/finance/converter?a=1&from=USD&to=%@",currency]];
	
	NSString *fileString = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:nil]; // reads file into memory as an NSString
	NSArray *lines = [fileString componentsSeparatedByString:@"\n"]; // each line, adjust character for line endings
	
	[url release];
	
	for (NSString *mySTR in lines) {
		
		NSRange range = [mySTR rangeOfString:@"id=currency_converter_result" options:(NSCaseInsensitiveSearch)];
		
		if (range.length > 0) {
			
			mySTR = [mySTR stringByReplacingOccurrencesOfString:@"<div id=currency_converter_result>1 USD = <span class=bld>" withString:@""];
			mySTR = [mySTR stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@</span>",currency] withString:@""];
			
			exValue = [mySTR doubleValue];
			
			
		}
		
	}
	
	return exValue;

}
-(IBAction)enableATMData:(id)sender {
	
	if ([expenseTypeControl selectedSegmentIndex] == 1) {
		ATMTextField.enabled = YES;
		ATMLabel.enabled = YES;
	} else if ([expenseTypeControl selectedSegmentIndex] == 0) {
		ATMTextField.enabled = NO;
		ATMLabel.enabled = NO;
	}
		
}

-(IBAction)hideKeyboard:(id)sender {
	
	[ammountTextField resignFirstResponder];
	[lugarTextField resignFirstResponder];
	[dayTextField resignFirstResponder];
	[monthTextField resignFirstResponder];
	[yearTextField resignFirstResponder];
	[ATMTextField resignFirstResponder];
	[expenseTypeControl resignFirstResponder];
	[exchangeRateTextField resignFirstResponder];
	
	[self formatOneDigitDate:nil];

}

-(IBAction)commitInfo:(id)sender {

	int lastID;
	
	NSError *error;
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
		
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"gasto" 
											  inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
		
	for (gasto *info in fetchedObjects) {
		lastID = ([info.ID integerValue]);			
	}
	
	if ([fetchedObjects count] > 0) {
		lastID++;
	}
	
	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber * ammountNumber = [f numberFromString:exchangeLabel.text];
	NSNumber * gastoIdNumber = [NSNumber numberWithInt:lastID];
	NSNumber * tipoNumber = [NSNumber numberWithInt: expenseTypeControl.selectedSegmentIndex];
	NSNumber * idNumber = [NSNumber numberWithInt:delegate.selectedCupo]; 
	NSString * dateString = [NSString stringWithFormat:@"%@-%@-%@",yearTextField.text,monthTextField.text,dayTextField.text];
	NSNumber * commisionNumber = [f numberFromString:ATMTextField.text];
	NSNumber * rateNumber = [NSNumber numberWithFloat:[exchangeRateTextField.text doubleValue]];
	NSNumber *sum = [NSNumber numberWithFloat:([ammountNumber floatValue] + [commisionNumber floatValue])];
	
	
	//Fecha
	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];	
	NSDate *dateFromString = [[[NSDate alloc] init] autorelease];	
	dateFromString = [dateFormatter dateFromString:dateString];
	
	[dateFormatter release];
	
	//commit al core data

		gasto *nuevoGasto = [NSEntityDescription insertNewObjectForEntityForName:@"gasto" inManagedObjectContext:moc];		
		
		nuevoGasto.ID = gastoIdNumber;
		nuevoGasto.tipo = tipoNumber;
		nuevoGasto.lugar = lugarTextField.text;
		nuevoGasto.ammount = sum;
		nuevoGasto.fecha = dateFromString;
		nuevoGasto.cupo = idNumber;
		nuevoGasto.currency = selectedCurrency;
		nuevoGasto.rate = rateNumber;
		
	
		if ([expenseTypeControl selectedSegmentIndex] == 1) {
			nuevoGasto.ATMcommision = commisionNumber;
		}
		
		entity = [NSEntityDescription entityForName:@"cupo" 
							 inManagedObjectContext:moc];
		[fetchRequest setEntity:entity];
		fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
		
		NSMutableArray *filteredMutableArray = [[NSMutableArray alloc] initWithArray:fetchedObjects];

		NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"ID == %i",delegate.selectedCupo]];
		[filteredMutableArray filterUsingPredicate:predicate];
	
		double newCurrent = [[[filteredMutableArray objectAtIndex:0] current_ammount] doubleValue] - [sum doubleValue];
		NSNumber * currentNumber = [NSNumber numberWithFloat:newCurrent];
		[[filteredMutableArray objectAtIndex:0]setCurrent_ammount:currentNumber];
		
		if (![moc save:&error]) {
			NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
		}
	
	[f release];
	[fetchRequest release];
	[filteredMutableArray release];

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

-(NSDictionary *)initialDefaults {
	
	return [[[NSDictionary alloc] initWithObjectsAndKeys:@"USD",@"currency",nil] autorelease];
			
}

- (void)viewDidLoad {
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults registerDefaults:[self initialDefaults]];

	NSString *default_currency = [userDefaults stringForKey:@"currency"];
	
	selectedCurrency = default_currency;
	
	[self arrangeFieldsAndLabels:nil];
	[self convert:nil];

	
	if (![self isConnected:nil] && ![selectedCurrency isEqualToString: @"USD"]) {
		UIAlertView *alertDialog;
		alertDialog = [[UIAlertView alloc] initWithTitle:@"Tasa de Cambio" message:@"No se pudo establecer una tasa de cambio, probablemente debido a un problema con la conexión, deberá establecer la tasa manualmente" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertDialog show];
		[alertDialog release];
	}
	
	NSDate* date = [NSDate date];
	NSString *str;
	NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"dd"];	
	str = [formatter stringFromDate:date];
	dayTextField.text = str;
	[formatter setDateFormat:@"MM"];	
	str = [formatter stringFromDate:date];
	monthTextField.text = str;
	[formatter setDateFormat:@"yyyy"];	
	str = [formatter stringFromDate:date];
	yearTextField.text = str;
	
	exchangeRateTextField.delegate = self;
	ammountTextField.delegate = self;
	
	theScroller.contentSize = CGSizeMake(320, 600);
	
	[super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
	
	[self arrangeFieldsAndLabels:nil];
	
	
    [super viewWillDisappear:animated];
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
	
	[ammountTextField release];
	[lugarTextField release];
	[dayTextField release];
	[monthTextField release];
	[yearTextField release];
	[ATMTextField release];
	[exchangeRateTextField release]; 
	[expenseTypeControl release];
	[mcView release];
	[ATMLabel release];
	[currencyLabel release];
	[exchangeLabel release];
	[montoEnUSDLabel release];
	[tazaLabel release];
	[lugarLabel release];
	[diaLabel release];
	[mesLabel release];
	[anoLabel release];
	[theScroller release];
	[doneButton release];
	
    [super dealloc];
}


@end
