//
//  email.h
//  iCadivi
//
//  Created by Boris Polania on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>




@interface email : UIViewController <UIPickerViewDataSource, MFMailComposeViewControllerDelegate>{
	
	IBOutlet UITextField *emailTextField;
	IBOutlet UISegmentedControl *reportTypeControl;
	IBOutlet UIButton *enviarButton;
	IBOutlet UIPickerView *myPicker;
	
	NSInteger selectedCupo;
	
	NSMutableArray *cuposArray;

}

@property (nonatomic, retain) IBOutlet UITextField *emailTextField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *reportTypeControl;
@property (nonatomic, retain) IBOutlet UIButton *enviarButton;
@property (nonatomic, retain) IBOutlet UIPickerView *myPicker;


-(IBAction)actionEmailComposer:(NSString *)_fileName;

-(IBAction)hideKeyboard:(id)sender;

-(IBAction)makeFile:(id)sender;

	
@end
