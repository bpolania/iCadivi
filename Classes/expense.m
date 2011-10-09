//
//  expense.m
//  iCadivi
//
//  Created by Boris Polania on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "expense.h"
#import "iCadiviAppDelegate.h"
#import "gasto.h"
#import "cupo.h"


@implementation expense

@synthesize dateLabel, tipoLabel, montoLabel, comisionLabel, lugarLabel, currencyNameAndCountryLabel, rateLabel;

-(IBAction)doAlert:(id)sender {
	
	UIAlertView *alertDialog;
	alertDialog = [[UIAlertView alloc] initWithTitle:@"¿Está seguro que desea eliminar este gasto?" message:@"" delegate:self cancelButtonTitle:@"Si" otherButtonTitles:@"No",nil];
	[alertDialog show];
	[alertDialog release];
}    

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	NSString *buttonTitle=[alertView buttonTitleAtIndex:buttonIndex];
	
	if ([buttonTitle isEqualToString:@"Si"]) {
		[self eliminar:nil];
		[self.navigationController popToRootViewControllerAnimated:NO];
		
	}
	
	
}

-(IBAction)eliminar:(id)sender {
	
	NSError *error;
	NSFetchRequest *fetchRequest;
	NSEntityDescription *entity;
	NSArray *fetchedObjects;
	double addAmmount;
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
	
	fetchRequest = [[NSFetchRequest alloc] init];
	entity = [NSEntityDescription entityForName:@"gasto" 
											  inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	for (gasto *info in fetchedObjects) {
		if ([info.ID integerValue] == delegate.selectedGasto) {
			addAmmount = [info.ammount doubleValue] + [info.ATMcommision doubleValue];
			[moc deleteObject:info];
		}			
		
	}

	fetchRequest = [[NSFetchRequest alloc] init];
	entity = [NSEntityDescription entityForName:@"cupo" 
						 inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	for (cupo *info in fetchedObjects) {
		if ([info.ID integerValue] == delegate.selectedCupo) {
			addAmmount = addAmmount + [info.current_ammount doubleValue];
			info.current_ammount = [NSNumber numberWithDouble:addAmmount];
			
		}	
	}
	
	[fetchRequest release];
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
	
	NSError *error;
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"gasto" 
											  inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	
	filteredMutableArray = [[NSMutableArray alloc] initWithArray:fetchedObjects];
		
	NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"cupo == %i && ID == %i",delegate.selectedCupo,delegate.selectedGasto]];
	[filteredMutableArray filterUsingPredicate:predicate];

	int tipoInt = [[[filteredMutableArray objectAtIndex:0] tipo] integerValue];
	double montoDouble = [[[filteredMutableArray objectAtIndex:0] ammount] doubleValue];
	double comisionDouble = [[[filteredMutableArray objectAtIndex:0] ATMcommision] doubleValue];
	double rateDouble = [[[filteredMutableArray objectAtIndex:0] rate] doubleValue];
	double transaccionAmmountDouble = montoDouble - comisionDouble;
	double currencyDouble = transaccionAmmountDouble * rateDouble;
	
	NSString *currency = [[filteredMutableArray objectAtIndex:0] currency];
	NSString *_currency = [NSString stringWithFormat:@"= %1.2f %@",currencyDouble,currency]; 
	
	NSArray *currencyCodeArray = [NSArray arrayWithObjects:@"USD",@"ANG",@"BHD",@"NPR",@"XOF",@"JMD",@"ILS",@"OMR",@"NAD",@"DZD",@"ISK",@"AUD",@"HNL",@"SKK",@"RON",@"TND",@"EUR",@"JOD",@"IDR",@"KES",@"SEK",@"MDL",@"QAR",@"PKR",@"BDT",@"CAD",@"BOB",@"BND",@"TRY",@"SLL",@"MKD",@"BWP",@"MXN",@"PEN",@"DOP",@"NZD",@"TZS",@"LTL",@"NOK",@"KRW",@"RUB",@"CHF",@"DKK",@"ARS",@"NIO",@"CZK",@"KYD",@"FJD",@"MVR",@"SAR",@"PHP",@"ZMK",@"CNY",@"LBP",@"LKR",@"GBP",@"UYU",@"TTD",@"LVL",@"VND",@"NGN",@"RSD",@"HKD",@"EGP",@"CRC",@"COP",@"PYG",@"UZS",@"INR",@"YER",@"JPY",@"KWD",@"KZT",@"HUF",@"SCR",@"MUR",@"BGN",@"MYR",@"AED",@"UGX",@"EEK",@"UAH",@"THB",@"ZAR",@"PGK",@"TWD",@"CLP",@"MAD",@"SVC",@"PLN",@"SGD",@"BRL",@"HRK",nil];
	NSArray *currencyCountryArray = [NSArray arrayWithObjects: @"EEUU - Dólar",@"Antillas Holandesas - Florín",@"Bahrein - Dinar",@"Nepal - Rupia",@"Francos CFA",@"Jamaica - Dólar",@"Israel - Nuevo Shequel",@"Oman - Rial",@"Namibia - Dólar",@"Argelia - Dinar",@"Islandia - Corona",@"Australia - Dólar",@"Honduras - Lempira",@"Eslovaquia - Corona",@"Rumania - Leu",@"Túnez - Dinar",@"Euro",@"Jordania - Dinar",@"Indonesia - Rupia",@"Kenia - Chelín",@"Suecia - Corona",@"Moldavia - Leu",@"Qatar - Rial",@"Pakistan - Rupia",@"Bangladesh - Taka",@"Canada - Dólar",@"Bolivia - Boliviano",@"Brunei - Dólar",@"Turquía - Lira",@"Sierra Leona - Leone",@"Macedonia - Dinar",@"Botswana - Pula",@"México - Peso",@"Perú - Nuevo Sol",@"Rep. Dominicana -Peso",@"Nueva Zelanda - Dólar",@"Tanzania - Chelín",@"Ltuania - Litas",@"Noruega - Corona",@"Corea del Sur - Won",@"Rusia - Rublo",@"Suiza - Franco",@"Dinamarca - Korona",@"Argentina - Peso",@"Nicaragua - Córdoba Oro",@"Rep. Checa - Corona",@"Islas Cayman - Dólar",@"Fiji - Dólar",@"Maldivas - Rupia",@"Arabia Saudita - Riyal",@"Filipinas - Peso",@"Zambia - Kwacha",@"China - Yuan",@"Líbano - Libra",@"Sri Lanka - Rupia",@"Gran Bretaña - Libra Esterlina",@"Uruguay - Peso",@"Trinidad y Tobago - Dólar",@"Latvia - Lats",@"Vietnam - Dong",@"Nigeria - Naira",@"Serbia - Dinar",@"Hong - Kong - Dólar",@"Egipto - Libra",@"Costa Rica - Colòn",@"Colombia - Peso",@"Paraguay - Guaraní",@"Uzbekistan - Som",@"India - Rupia",@"Yemen - Rial",@"Japón - Yen",@"Kuwait - Dinar",@"Kazajistan - Tenge",@"Hungría - Florín",@"Seychelles - Rupia",@"Mauritania - Rupia",@"Bulgaria - Leva",@"Malasia - Ringgit",@"EAU - Dirham",@"Uganda - Chelín",@"Estonia - Corona",@"Ukrania - Grivnya",@"Tailandia - Baht",@"Suráfrica - Rand",@"Papúa Nva. Guinea - Kina",@"Taiwan - Dólar",@"Chile - Peso",@"Marruecos - Dirham",@"Salvador - Colón",@"Polonia - Zloty",@"Singapur - Dólar",@"Brasil - Real",@"Croacia - Corona",nil];
	
	NSDictionary *currencyDictionary = [NSDictionary dictionaryWithObjects:currencyCountryArray forKeys:currencyCodeArray];
	
	NSString *tipoString;
	
	if (tipoInt == 0 ) {
		comisionLabel.hidden = YES;
		tipoString = @"Pago con Tarjeta";
	} else if (tipoInt == 1) {
		tipoString = @"Retiro en Cajero";
	}

	
	if ([currency isEqualToString:@"USD"]) {
		_currency = @"";
		rateLabel.hidden = YES;
		comisionLabel.frame = CGRectMake(20, 220, 280, 21);
		
	}
	

			
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"dd-MM-yyyy"];
			
			//Optionally for time zone converstions
			[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
			
			NSString *stringFromDate = [formatter stringFromDate:[[filteredMutableArray objectAtIndex:0] fecha]];
			
			dateLabel.text = [NSString stringWithFormat:@"Fecha de Registro: %@", stringFromDate];
			tipoLabel.text = [NSString stringWithFormat:@"Tipo: %@",tipoString];
			montoLabel.text = [NSString stringWithFormat:@"Monto: %1.2f USD %@",transaccionAmmountDouble,_currency];
			comisionLabel.text = [NSString stringWithFormat:@"Comisión ATM: %1.2f %@",comisionDouble, currency];
			lugarLabel.text = [NSString stringWithFormat:@"Lugar: %@",[[filteredMutableArray objectAtIndex:0] lugar]];
			currencyNameAndCountryLabel.text = [NSString stringWithFormat:@"Moneda: %@",[currencyDictionary objectForKey:currency]];
			rateLabel.text = [NSString stringWithFormat:@"Tasa: %1.2f %@ X Dolar",rateDouble,currency];
	
			
	[formatter release];
	[filteredMutableArray release];
	[fetchRequest release];
	
    [super viewDidLoad];
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
	
	[dateLabel release];
	[tipoLabel release];
	[montoLabel release];
	[comisionLabel release];
	[lugarLabel release];
	[currencyNameAndCountryLabel release];
	[rateLabel release];
	
    [super dealloc];
}


@end
