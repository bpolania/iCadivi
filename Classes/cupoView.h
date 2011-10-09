//
//  cupoView.h
//  iCadivi
//
//  Created by Boris Polania on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class mainCuposView, newCupo, newExpense, expenseDetail;

#import <UIKit/UIKit.h>


@interface cupoView : UIViewController {
	
	IBOutlet newExpense *nExpense;
	IBOutlet expenseDetail *eDetail;
	IBOutlet mainCuposView *mcView;
	
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *totalLabel;
	IBOutlet UILabel *currentLabel;
	IBOutlet UILabel *typeLabel;
	
	IBOutlet UIButton *expensesDetailButton;
	
	NSInteger selectedCupo;

}

@property (nonatomic, retain) IBOutlet newExpense *nExpense;
@property (nonatomic, retain) IBOutlet expenseDetail *eDetail;
@property (nonatomic, retain) IBOutlet mainCuposView *mcView;

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalLabel;
@property (nonatomic, retain) IBOutlet UILabel *currentLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;

@property (nonatomic, assign) NSInteger selectedCupo;

@property (nonatomic, assign) IBOutlet UIButton *expensesDetailButton;

-(IBAction)addNewExpense:(id)sender;

-(IBAction)showExpenseDetail:(id)sender;

-(IBAction)eliminar:(id)sender;

-(void)displayData:(id)sender;

-(IBAction)doAlert:(id)sender;

@end
