//
//  mainViewController.h
//  iCadivi
//
//  Created by Boris Polania on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class cupo, cupoView, noCupoView, mainCuposView;

#import <UIKit/UIKit.h>


@interface mainViewController : UIViewController <UINavigationControllerDelegate>{
	
	IBOutlet cupoView *cView;
	IBOutlet noCupoView *ncView;
	IBOutlet mainCuposView *mainView;

	
	BOOL tempBool;
	
}

@property (nonatomic, retain) IBOutlet cupoView *cView; 
@property (nonatomic, retain) IBOutlet noCupoView *ncView;
@property (nonatomic, retain) IBOutlet mainCuposView *mainView;

-(void)setInitialView:(id)sender;

@end
