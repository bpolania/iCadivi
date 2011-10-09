//
//  newCupo.h
//  iCadivi
//
//  Created by Boris Polania on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class cupo, iCadiviAppDelegate;

#import <UIKit/UIKit.h>


@interface newCupo : UIViewController <UIAlertViewDelegate> {
	
	int	lastID;
	
	IBOutlet UITextField *nameTextField;
	IBOutlet UITextField *ammountTextField;
	IBOutlet UISegmentedControl *accountTypeControl;
	
}

@property (nonatomic,retain) IBOutlet UITextField *nameTextField;
@property (nonatomic,retain) IBOutlet UITextField *ammountTextField;
@property (nonatomic,retain) IBOutlet UISegmentedControl *accountTypeControl;


-(IBAction)hideKeyboard:(id)sender;

-(IBAction)commitInfo:(id)sender;

-(IBAction)cancel:(id)sender;

-(IBAction)doAlert:(id)sender;


@end
