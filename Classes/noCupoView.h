//
//  noCupoView.h
//  iCadivi
//
//  Created by Boris Polania on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class newCupo;

#import <UIKit/UIKit.h>


@interface noCupoView : UIViewController {
	
	IBOutlet UILabel *testLabel;
	IBOutlet newCupo *nCupo;

}

@property (nonatomic, retain) IBOutlet UILabel *testLabel;
@property (nonatomic, retain) IBOutlet newCupo *nCupo;

-(IBAction)addNewCupo:(id)sender;
-(IBAction)updateLabel:(id)sender;

@end
