//
//  email.m
//  iCadivi
//
//  Created by Boris Polania on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define componentCount 1
#define firstComponent 0

#import "email.h"
#import "iCadiviAppDelegate.h"
#import "cupo.h"
#import "gasto.h"

@implementation email

@synthesize emailTextField, reportTypeControl, enviarButton, myPicker;

-(void)doAlert:(NSInteger)AlertType {
	
	NSString *mensaje;
	
	switch (AlertType) {
		case 0:
			mensaje = @"El Cupo seleccionado no tiene ningun gasto relacionado";
			break;
		case 1:
			mensaje = @"No se pudo enviar el reporte, es probable que no tenga ninguna cuenta de correo electrónico configurado en este dispositivo.";
			break;
		default:
			break;
	}
		

	
	UIAlertView *alertDialog;
	alertDialog = [[UIAlertView alloc] initWithTitle:@"iCadivi" message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertDialog show];
	[alertDialog release];	
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return componentCount;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [cuposArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [cuposArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
		
	selectedCupo = row;
	
}	

-(IBAction)makeFile:(id)sender {
	
	
	NSError *error;
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	NSEntityDescription *entity;
	NSArray *fetchedObjects;
	NSMutableArray *filteredMutableArray;
	NSPredicate *predicate;
	
	entity = [NSEntityDescription entityForName:@"cupo" 
						 inManagedObjectContext:moc];	
	
	[fetchRequest setEntity:entity];
	fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	
	filteredMutableArray = [[NSMutableArray alloc] initWithArray:fetchedObjects];
	
	
	predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"ID == %i",selectedCupo]];
	[filteredMutableArray filterUsingPredicate:predicate];	
	
	
	NSString *cupoName = [[filteredMutableArray objectAtIndex:0] nombre];
	double cupoAmmount = [[[filteredMutableArray objectAtIndex:0] total_ammount] doubleValue];
	double cupoDisponible = [[[filteredMutableArray objectAtIndex:0] current_ammount] doubleValue];
		
	entity = [NSEntityDescription entityForName:@"gasto" 
											  inManagedObjectContext:moc];	
		
	[fetchRequest setEntity:entity];
	fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	
	[filteredMutableArray release];
	
	filteredMutableArray = [[NSMutableArray alloc] initWithArray:fetchedObjects];
	
	predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"cupo == %i",selectedCupo]];
	[filteredMutableArray filterUsingPredicate:predicate];	
	
	//get the documents directory:
	NSArray *paths = NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	//make a file name to write the data to using the documents directory:
	NSString *fileName;
		
	
	NSMutableString *row = [[NSMutableString alloc] init];
	NSString *tipoString;
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
	NSInteger fetchedCount = [filteredMutableArray count] + 7;
	NSString *finalText;
	NSString *_fileName;
	
	if ([filteredMutableArray count] > 0) {
		
	switch (reportTypeControl.selectedSegmentIndex) {
		case 0:{
			
			
			
			//make a file name to write the data to using the documents directory:
			fileName = [NSString stringWithFormat:@"%@/textfile.xml", 
								  documentsDirectory];
			_fileName = @"textfile.xml";
			
			NSInteger numberOfRowsInt = [filteredMutableArray count];
			NSString *subTotalRange = [[NSString alloc] init];

			
			if ([filteredMutableArray count] > 1) {
				subTotalRange = [NSString stringWithFormat:@"SUM(R[-%i]C:R[-1]C)",numberOfRowsInt];
			} else {
				subTotalRange = @"R[-1]C";
			}
			
			NSInteger numberOfRowsIntPlusSix = [filteredMutableArray count] + 6;
			NSString *header = [NSString stringWithFormat:@"<?xml version=\"1.0\"?>\n<?mso-application progid=\"Excel.Sheet\"?>\n<Workbook xmlns=\"urn:schemas-microsoft-com:office:spreadsheet\"\n xmlns:o=\"urn:schemas-microsoft-com:office:office\"\n xmlns:x=\"urn:schemas-microsoft-com:office:excel\"\n xmlns:ss=\"urn:schemas-microsoft-com:office:spreadsheet\"\n xmlns:html=\"http://www.w3.org/TR/REC-html40\">\n <DocumentProperties xmlns=\"urn:schemas-microsoft-com:office:office\">\n  <Author>Lake Lewis Tech</Author>\n  <LastAuthor>iCadivi User</LastAuthor>\n  <Created>2010-11-04T23:38:55Z</Created>\n  <Company>Lake Lewis Tech</Company>\n  <Version>14.00</Version>\n </DocumentProperties>\n <OfficeDocumentSettings xmlns=\"urn:schemas-microsoft-com:office:office\">\n  <AllowPNG/>\n </OfficeDocumentSettings>\n <ExcelWorkbook xmlns=\"urn:schemas-microsoft-com:office:excel\">\n  <WindowHeight>8475</WindowHeight>\n  <WindowWidth>18915</WindowWidth>\n  <WindowTopX>120</WindowTopX>\n  <WindowTopY>150</WindowTopY>\n  <ProtectStructure>False</ProtectStructure>\n  <ProtectWindows>False</ProtectWindows>\n </ExcelWorkbook>\n <Styles>\n  <Style ss:ID=\"Default\" ss:Name=\"Normal\">\n   <Alignment ss:Vertical=\"Bottom\"/>\n   <Borders/>\n   <Font ss:FontName=\"Calibri\" x:Family=\"Swiss\" ss:Size=\"11\" ss:Color=\"#000000\"/>\n   <Interior/>\n   <NumberFormat/>\n   <Protection/>\n  </Style>\n  <Style ss:ID=\"s62\">\n   <Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Bottom\"/>\n   <NumberFormat ss:Format=\"[$$-409]#,##0.00\"/>\n  </Style>\n  <Style ss:ID=\"s63\">\n   <Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Bottom\"/>\n  </Style>\n  <Style ss:ID=\"s64\">\n   <Alignment ss:Horizontal=\"Right\" ss:Vertical=\"Bottom\"/>\n   <Font ss:FontName=\"Calibri\" x:Family=\"Swiss\" ss:Size=\"11\" ss:Color=\"#000000\"\n    ss:Bold=\"1\"/>\n  </Style>\n  <Style ss:ID=\"s66\">\n   <Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Bottom\"/>\n   <Borders>\n    <Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>\n   </Borders>\n   <Font ss:FontName=\"Calibri\" x:Family=\"Swiss\" ss:Size=\"11\" ss:Color=\"#000000\"\n    ss:Bold=\"1\"/>\n   <NumberFormat ss:Format=\"[$$-409]#,##0.00\"/>\n  </Style>\n  <Style ss:ID=\"s67\">\n   <Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Bottom\"/>\n   <Borders>\n    <Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>\n    <Border ss:Position=\"Left\" ss:LineStyle=\"Continuous\" ss:Weight=\"2\"/>\n    <Border ss:Position=\"Right\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>\n    <Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"2\"/>\n   </Borders>\n   <Font ss:FontName=\"Calibri\" x:Family=\"Swiss\" ss:Size=\"11\" ss:Color=\"#000000\"\n    ss:Bold=\"1\"/>\n  </Style>\n  <Style ss:ID=\"s68\">\n   <Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Bottom\"/>\n   <Borders>\n    <Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>\n    <Border ss:Position=\"Left\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>\n    <Border ss:Position=\"Right\" ss:LineStyle=\"Continuous\" ss:Weight=\"2\"/>\n    <Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"2\"/>\n   </Borders>\n   <Font ss:FontName=\"Calibri\" x:Family=\"Swiss\" ss:Size=\"11\" ss:Color=\"#000000\"\n    ss:Bold=\"1\"/>\n   <NumberFormat ss:Format=\"[$$-409]#,##0.00\"/>\n  </Style>\n  <Style ss:ID=\"s69\">\n   <Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Bottom\"/>\n   <Borders>\n    <Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"2\"/>\n    <Border ss:Position=\"Left\" ss:LineStyle=\"Continuous\" ss:Weight=\"2\"/>\n    <Border ss:Position=\"Right\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>\n    <Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>\n   </Borders>\n  </Style>\n  <Style ss:ID=\"s70\">\n   <Borders>\n    <Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"2\"/>\n    <Border ss:Position=\"Left\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>\n    <Border ss:Position=\"Right\" ss:LineStyle=\"Continuous\" ss:Weight=\"2\"/>\n    <Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>\n   </Borders>\n   <NumberFormat ss:Format=\"[$$-409]#,##0.00\"/>\n  </Style>\n  <Style ss:ID=\"s71\">\n   <Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Bottom\"/>\n   <Borders>\n    <Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>\n   </Borders>\n   <NumberFormat ss:Format=\"&quot;$&quot;#,##0.00\"/>\n  </Style>\n </Styles>\n <Worksheet ss:Name=\"Hoja1\">\n  <Table ss:ExpandedColumnCount=\"8\" ss:ExpandedRowCount=\"%i\" x:FullColumns=\"1\"\n   x:FullRows=\"1\" ss:DefaultColumnWidth=\"60\" ss:DefaultRowHeight=\"15\">\n   <Column ss:AutoFitWidth=\"0\" ss:Width=\"66\"/>\n   <Column ss:Width=\"87.75\"/>\n   <Column ss:Width=\"110.25\"/>\n   <Column ss:Width=\"96.75\"/>\n   <Column ss:Width=\"72\" ss:Span=\"1\"/>\n   <Column ss:Index=\"7\" ss:Width=\"120.75\"/>\n   <Row ss:AutoFitHeight=\"0\">\n    <Cell><Data ss:Type=\"String\">%@</Data></Cell>\n    <Cell><Data ss:Type=\"String\">Monto Aprobado:</Data></Cell>\n    <Cell ss:StyleID=\"s62\"><Data ss:Type=\"Number\">%1.2f</Data></Cell>\n   </Row>\n   <Row ss:Index=\"3\" ss:AutoFitHeight=\"0\" ss:StyleID=\"s63\">\n    <Cell><Data ss:Type=\"String\">Descripcion</Data></Cell>\n    <Cell><Data ss:Type=\"String\">Moneda</Data></Cell>\n    <Cell><Data ss:Type=\"String\">Monto (Moneda Local)</Data></Cell>\n   <Cell><Data ss:Type=\"String\">Taza</Data></Cell>\n     <Cell><Data ss:Type=\"String\">Comision ATM</Data></Cell>\n    <Cell><Data ss:Type=\"String\">Monto US$</Data></Cell>\n    <Cell><Data ss:Type=\"String\">Tipo de Transaccion</Data></Cell>\n    <Cell><Data ss:Type=\"String\">Fecha</Data></Cell>\n   </Row>\n",fetchedCount,cupoName,cupoAmmount];
			NSString *footer = [NSString stringWithFormat:@"<Row ss:AutoFitHeight=\"0\">\n    <Cell ss:Index=\"2\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">Sub-Totales</Data></Cell>\n    <Cell ss:StyleID=\"s71\" ss:Formula=\"= %@ \"><Data ss:Type=\"Number\"></Data></Cell>\n    <Cell ss:StyleID=\"s63\"/>\n    <Cell ss:StyleID=\"s66\" ss:Formula=\"=%@\"><Data ss:Type=\"Number\"></Data></Cell>\n    <Cell ss:StyleID=\"s66\" ss:Formula=\"=%@\"><Data ss:Type=\"Number\"></Data></Cell>\n   </Row>\n   <Row ss:AutoFitHeight=\"0\"/>\n   <Row ss:AutoFitHeight=\"0\">\n    <Cell ss:Index=\"5\" ss:StyleID=\"s67\"><Data ss:Type=\"String\">Total</Data></Cell>\n    <Cell ss:StyleID=\"s68\" ss:Formula=\"=R[-2]C[-1]+R[-2]C\"><Data ss:Type=\"Number\"></Data></Cell>\n   </Row>\n   <Row ss:AutoFitHeight=\"0\">\n    <Cell ss:Index=\"5\" ss:StyleID=\"s69\"><Data ss:Type=\"String\">Disponible</Data></Cell>\n    <Cell ss:StyleID=\"s70\" ss:Formula=\"=R[-%i]C[-3]-R[-1]C\"><Data ss:Type=\"Number\"></Data></Cell>\n   </Row>\n  </Table>\n  <WorksheetOptions xmlns=\"urn:schemas-microsoft-com:office:excel\">\n   <PageSetup>\n    <Header x:Margin=\"0.3\"/>\n    <Footer x:Margin=\"0.3\"/>\n    <PageMargins x:Bottom=\"0.75\" x:Left=\"0.7\" x:Right=\"0.7\" x:Top=\"0.75\"/>\n   </PageSetup>\n   <Unsynced/>\n   <Print>\n    <ValidPrinterInfo/>\n    <VerticalResolution>0</VerticalResolution>\n   </Print>\n   <Selected/>\n   <Panes>\n    <Pane>\n     <Number>3</Number>\n     <ActiveRow>16</ActiveRow>\n     <ActiveCol>4</ActiveCol>\n    </Pane>\n   </Panes>\n   <ProtectObjects>False</ProtectObjects>\n   <ProtectScenarios>False</ProtectScenarios>\n  </WorksheetOptions>\n </Worksheet>\n</Workbook>\n",subTotalRange,subTotalRange,subTotalRange,numberOfRowsIntPlusSix];
			
			for (gasto *info in filteredMutableArray) {
				
				switch ([info.tipo intValue]) {
					case 0:
						tipoString = @"Pago";
						break;
					case 1:
						tipoString = @"Retiro";
						break;
					default:
						break;
				}
				
				double conversion = [info.ammount doubleValue] * [info.rate doubleValue];
				
				[row appendString:@"<Row ss:AutoFitHeight=\"0\">\n"];
				[row appendString:[NSString stringWithFormat:@"<Cell><Data ss:Type=\"String\">%@</Data></Cell>\n",info.lugar]];
				[row appendString:[NSString stringWithFormat:@"<Cell><Data ss:Type=\"String\">%@</Data></Cell>\n",info.currency]];
				[row appendString:[NSString stringWithFormat:@"<Cell><Data ss:Type=\"Number\">%1.2f</Data></Cell>\n",conversion]];
				[row appendString:[NSString stringWithFormat:@"<Cell><Data ss:Type=\"Number\">%1.2f</Data></Cell>\n",[info.rate doubleValue]]];
				[row appendString:[NSString stringWithFormat:@"<Cell><Data ss:Type=\"Number\">%1.2f</Data></Cell>\n",[info.ATMcommision doubleValue]]];
				[row appendString:[NSString stringWithFormat:@"<Cell><Data ss:Type=\"Number\">%1.2f</Data></Cell>\n",[info.ammount doubleValue]]];
				[row appendString:[NSString stringWithFormat:@"<Cell><Data ss:Type=\"String\">%@</Data></Cell>\n",tipoString]];
				[row appendString:[NSString stringWithFormat:@"<Cell><Data ss:Type=\"String\">%@</Data></Cell>\n",[dateFormat stringFromDate:info.fecha]]];
				[row appendString:@"</Row>\n"];
				
				
				finalText = [NSString stringWithFormat:@"%@%@%@",header,row,footer];
			}
		}
			break;
			 
			 
		case 1: {
			
			//make a file name to write the data to using the documents directory:
			fileName = [NSString stringWithFormat:@"%@/textfile.txt", 
								  documentsDirectory];
			_fileName = @"textfile.txt";
			
			
			NSString *header = [NSString stringWithFormat:@"%@\011%Monto Aprobado:%\011%1.2f\n",cupoName,cupoAmmount];
			NSString *footer = [NSString stringWithFormat:@"\011\011%Monto Disponible:%\011%1.2f\n",cupoDisponible];

		
			for (gasto *info in filteredMutableArray) {
				
				switch ([info.tipo intValue]) {
					case 0:
						tipoString = @"Pago";
						break;
					case 1:
						tipoString = @"Retiro";
						break;
					default:
						break;
				}
				
				double conversion = [info.ammount doubleValue] * [info.rate doubleValue];
				
				[row appendString:[NSString stringWithFormat:@"%@\011%@\011%1.2f\011%1.2f\011%@\011%1.2f\011%1.2f\011%@\n",info.lugar,info.currency,conversion,[info.rate doubleValue],tipoString,[info.ammount doubleValue],[info.ATMcommision doubleValue],[dateFormat stringFromDate:info.fecha]]];
				
			}	
				finalText = [NSString stringWithFormat:@"%@%@%@",header,row,footer];
			}
			break;
		default:
			break;
	}

	
	//save content to the documents directory
	[finalText writeToFile:fileName 
			  atomically:NO 
				encoding:NSStringEncodingConversionAllowLossy 
				   error:nil];
		
		[self actionEmailComposer:_fileName];
		[delegate changeTabIndex:0];
		
	} else {
		[self doAlert:0];
	}
		
	[filteredMutableArray release];
	[fetchRequest release];
	[dateFormat release];
	[row release];
	
	
}


- (IBAction)actionEmailComposer:(NSString *)_fileName {
	
	NSArray *recipients = [NSArray arrayWithObjects:emailTextField.text,nil];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *bodyString;
	
	if ([_fileName isEqualToString:@"textfile.xml"]) {
		bodyString = @"Reporte iCadivi - Instrucciones\n\n1) El archivo adjunto contiene información relacionada con sus cupos de divisas de CADIVI tal cual como han sido registrados en la aplicación iCadivi. Este reporte se encuentra en formato XML para Microsoft Excel® y SOLAMENTE podrá ser visto en versiones de dicho software igual o posteriores al año 2003.\n\n2) Para visualizar el reporte solo debe salvar el archivo en su computador, acceder a la aplicación Microsoft Excel® y abrir el archivo del reporte en la localización donde fue salvado.\n\n3) Para su conveniencia luego de abierto el archivo en Microsoft Excel® puede seleccionar la opción de \"Guardar Como\" y salvar el archivo con el formato de Microsoft Excel® 2003-2007 o de Microsoft Excel® 2010, de ese modo este archivo podrá ser visualizado en otras aplicaciones que estén en capacidad de leer archivos Microsoft Excel®";
	} else {
		bodyString = @"Reporte iCadivi - Instrucciones\n\n1) El archivo adjunto contiene información relacionada con sus cupos de divisas de CADIVI tal cual como han sido registrados en la aplicación iCadivi. Este reporte se encuentra en formato TXT y puede ser copiado en cualquier hoja de Cálculo.\n\n2) Para visualizar el reporte solo debe salvar el archivo en su computador y hacer doble-click en el ícono del archivo en la localización donde se haya salvado.\n\n3) Para visualizar los datos en una hoja de cálculo solo es necesario copiar la información en el archivo de texto y pegarlo en cualquier celda de la hoja de cálculo.";
	}


	//make a file name to write the data to using the documents directory:
	
	NSString *fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory,_fileName]; 
	NSData *myData = [NSData dataWithContentsOfFile:fileName];
	
	
	
	if ([MFMailComposeViewController canSendMail]) {
		
		MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
		mailViewController.mailComposeDelegate = self;
		[mailViewController setToRecipients:recipients];
		[mailViewController setSubject:@"Reporte iCadivi"];
		[mailViewController addAttachmentData:myData mimeType:@"text/xml" fileName:_fileName];
		[mailViewController setMessageBody:bodyString isHTML:NO];
		
		[self presentModalViewController:mailViewController animated:YES];
		[mailViewController release];
		
	}
	
	else {
		
		[self doAlert:1];
		//NSLog(@"Device is unable to send email in its current state.");
		
	}
	
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
	[self dismissModalViewControllerAnimated:YES];
	
}

-(IBAction)hideKeyboard:(id)sender {
	
	[emailTextField resignFirstResponder];

	
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

- (void)viewWillAppear:(BOOL)animated {
		
	NSError *error;
	NSArray *fetchedObjects;
	NSFetchRequest *fetchRequest;
	NSEntityDescription *entity;
	
	cuposArray = [[NSMutableArray alloc] init];
	
	iCadiviAppDelegate *delegate = (iCadiviAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = delegate.managedObjectContext;
		
	fetchRequest = [[NSFetchRequest alloc] init];
	entity = [NSEntityDescription entityForName:@"cupo" 
											  inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	for (cupo *info in fetchedObjects) {
		[cuposArray addObject:info.nombre];
	}		 

	[fetchRequest release];
	myPicker.reloadAllComponents;
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	NSString *default_email = [userDefaults stringForKey:@"email"];
	emailTextField.text = default_email;
		
	cuposArray = [[NSMutableArray alloc] init];
	
	[cuposArray release];
		
	
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
	
	[emailTextField release];
	[reportTypeControl release];
	[enviarButton release];
	[myPicker release];	
	[cuposArray release];
	
    [super dealloc];
}


@end
