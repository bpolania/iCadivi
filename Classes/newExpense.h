//
//  newExpense.h
//  iCadivi
//
//  Created by Boris Polania on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class mainCuposView;


#import <UIKit/UIKit.h>


@interface newExpense : UIViewController <UITextFieldDelegate> {
	
	IBOutlet UITextField *ammountTextField;
	IBOutlet UITextField *lugarTextField;
	IBOutlet UITextField *dayTextField;
	IBOutlet UITextField *monthTextField;
	IBOutlet UITextField *yearTextField;
	IBOutlet UITextField *ATMTextField;
	IBOutlet UITextField *exchangeRateTextField;

	IBOutlet UISegmentedControl *expenseTypeControl;
	
	IBOutlet mainCuposView *mcView;
	
	IBOutlet UILabel *ATMLabel;
	IBOutlet UILabel *currencyLabel;
	IBOutlet UILabel *exchangeLabel;
	IBOutlet UILabel *montoEnUSDLabel;
	IBOutlet UILabel *tazaLabel;
	IBOutlet UILabel *lugarLabel;
	IBOutlet UILabel *diaLabel;
	IBOutlet UILabel *mesLabel;
	IBOutlet UILabel *anoLabel;
	
	IBOutlet UIScrollView *theScroller;
	
	IBOutlet UIButton *doneButton;
	
	NSArray *currencyCountryArray;
	NSArray *currencyCodeArray;
	
	NSString *selectedCurrency;
	
	 

}

@property (nonatomic,retain) IBOutlet UITextField *ammountTextField;
@property (nonatomic,retain) IBOutlet UITextField *lugarTextField;
@property (nonatomic,retain) IBOutlet UITextField *dayTextField;
@property (nonatomic,retain) IBOutlet UITextField *monthTextField;
@property (nonatomic,retain) IBOutlet UITextField *yearTextField;
@property (nonatomic,retain) IBOutlet UITextField *ATMTextField;
@property (nonatomic,retain) IBOutlet UITextField *exchangeRateTextField; 
@property (nonatomic,retain) IBOutlet UISegmentedControl *expenseTypeControl;
@property (nonatomic,retain) IBOutlet mainCuposView *mcView;
@property (nonatomic,retain) IBOutlet UILabel *ATMLabel;
@property (nonatomic,retain) IBOutlet UILabel *currencyLabel;
@property (nonatomic,retain) IBOutlet UILabel *exchangeLabel;
@property (nonatomic,retain) IBOutlet UILabel *montoEnUSDLabel;
@property (nonatomic,retain) IBOutlet UILabel *tazaLabel;
@property (nonatomic,retain) IBOutlet UILabel *lugarLabel;
@property (nonatomic,retain) IBOutlet UILabel *diaLabel;
@property (nonatomic,retain) IBOutlet UILabel *mesLabel;
@property (nonatomic,retain) IBOutlet UILabel *anoLabel;
@property (nonatomic,retain) IBOutlet UIScrollView *theScroller;
@property (nonatomic,retain) IBOutlet UIButton *doneButton;

 

-(IBAction)commitInfo:(id)sender;

-(IBAction)hideKeyboard:(id)sender;

-(IBAction)enableATMData:(id)sender;

- (double)getExchangeRateToCurrency:(NSString *)currency;

-(void)convert:(id)sender;

-(void)formatOneDigitDate:(id)sender;

-(IBAction)doAlert:(id)sender;

-(void)arrangeFieldsAndLabels:(id)sender;

@end
