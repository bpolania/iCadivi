//
//  ayudaViewController.h
//  iCadivi
//
//  Created by Boris Polania on 10/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class ayuda;

#import <UIKit/UIKit.h>


@interface ayudaViewController : UIViewController {

	
	IBOutlet UINavigationController *navigationController;
	IBOutlet ayuda *ayudaViewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet ayuda *ayudaViewController;

@end
