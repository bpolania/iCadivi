//
//  expense.h
//  iCadivi
//
//  Created by Boris Polania on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface expense : UIViewController {
	
	NSMutableArray *filteredMutableArray;
	
	IBOutlet UILabel *dateLabel;
	IBOutlet UILabel *tipoLabel;
	IBOutlet UILabel *montoLabel;
	IBOutlet UILabel *comisionLabel;
	IBOutlet UILabel *lugarLabel;
	IBOutlet UILabel *currencyNameAndCountryLabel;
	IBOutlet UILabel *rateLabel;

}

@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *tipoLabel;
@property (nonatomic, retain) IBOutlet UILabel *montoLabel;
@property (nonatomic, retain) IBOutlet UILabel *comisionLabel;
@property (nonatomic, retain) IBOutlet UILabel *lugarLabel;
@property (nonatomic, retain) IBOutlet UILabel *currencyNameAndCountryLabel;
@property (nonatomic, retain) IBOutlet UILabel *rateLabel;


-(IBAction)eliminar:(id)sender;

-(IBAction)doAlert:(id)sender;



@end

