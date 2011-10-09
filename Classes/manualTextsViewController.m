//
//  manualTextsViewController.m
//  iCadivi
//
//  Created by Boris Polania on 11/12/10.
//  Copyright 2010 Lake Lewis Tehcnologies. All rights reserved.
//

#import "manualTextsViewController.h"
#import "iCadiviAppDelegate.h"


@implementation manualTextsViewController

@synthesize helpText1, helpText2, helpText3, helpText4, helpText5, helpText6, helpText7, helpText8, helpText9, helpText10, helpText11, helpText12, helpText13, helpText14;
@synthesize helpText15, helpText16, helpText17, helpText18, helpText19, helpText20; 

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
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
		
	switch (delegate.selectedHelpSection) {
		case 0:
			switch (delegate.selectedItem) {
				case 0:
					self.title = @"Crear Cupo";
					helpText1.hidden = NO;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 1:
					self.title = @"Eliminar Cupo";
					helpText1.hidden = YES;
					helpText2.hidden = NO;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 2:
					self.title = @"Registrar Gasto";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = NO;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 3:
					self.title = @"Consulta de Gastos";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = NO;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 4:
					self.title = @"Eliminar Gasto";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = NO;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 5:
					self.title = @"Enviar Reporte";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = NO;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 6:
					self.title = @"Reporte Excel";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = NO;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 7:
					self.title = @"Reporte .TXT";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = NO;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				default:
					break;
			}
			break;
			case 1:
			switch (delegate.selectedItem) {
				case 0:
					self.title = @"Configuración";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = NO;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 1:
					self.title = @"Multi-Divisas";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = NO;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 2:
					self.title = @"Registro de Datos";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = NO;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 3:
					self.title = @"Comisión del ATM";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = NO;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 4:
					self.title = @"Reporte Excel";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = NO;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 5:
					self.title = @"Reporte TXT";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = NO;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 6:
					self.title = @"Extension Excel";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = NO;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				default:
					break;
			}					
			break;
			case 2:
			switch (delegate.selectedItem) {
				case 0:
					self.title = @"Tasas de Cambio";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = NO;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 1:
					self.title = @"Envio de Reportes";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = NO;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 2:
					self.title = @"Botón \"iCadivi\"";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = NO;
					helpText19.hidden = YES;
					helpText20.hidden = YES;
					break;
				case 3:
					self.title = @"Botón \"Enviar\"";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = NO;
					helpText20.hidden = YES;
					break;
				case 4:
					self.title = @"Agregar Gasto";
					helpText1.hidden = YES;
					helpText2.hidden = YES;
					helpText3.hidden = YES;
					helpText4.hidden = YES;
					helpText5.hidden = YES;
					helpText6.hidden = YES;
					helpText7.hidden = YES;
					helpText8.hidden = YES;
					helpText9.hidden = YES;
					helpText10.hidden = YES;
					helpText11.hidden = YES;
					helpText12.hidden = YES;
					helpText13.hidden = YES;
					helpText14.hidden = YES;
					helpText15.hidden = YES;
					helpText16.hidden = YES;
					helpText17.hidden = YES;
					helpText18.hidden = YES;
					helpText19.hidden = YES;
					helpText20.hidden = NO;
					break;
				default:
					break;
			}					
			break;
			
		default:
			break;
	}
	
	
	
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
	
	[helpText1 release];
	[helpText2 release];
	[helpText3 release];
	[helpText4 release];
	[helpText5 release];
	[helpText6 release];
	[helpText7 release];
	[helpText8 release];
	[helpText9 release];
	[helpText10 release];
	[helpText11 release];
	[helpText12 release];
	[helpText13 release];
	[helpText14 release];
	[helpText15 release];
	[helpText16 release];
	[helpText17 release];
	[helpText18 release];
	[helpText19 release];
	[helpText20 release];
	
    [super dealloc];
}


@end
