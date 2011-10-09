//
//  mainCuposView.h
//  iCadivi
//
//  Created by Boris Polania on 9/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class cupoView, iCadiviAppDelegate;

#import <UIKit/UIKit.h>


@interface mainCuposView : UITableViewController {

	NSMutableArray *cuposArray;
	NSInteger selectedCupo;
	NSArray *fetchedObjects;
	
	IBOutlet UITableView *myTable;
	IBOutlet UIImageView *myImage;
	
	IBOutlet cupoView *cView;
	
	IBOutlet UIButton *expensesDetailButton;

}

@property (nonatomic, assign) NSInteger selectedCupo;
@property (nonatomic, retain) IBOutlet cupoView *cView;
@property (nonatomic, retain) IBOutlet UIImageView *myImage; 
@property (nonatomic, assign) IBOutlet UIButton *expensesDetailButton;

-(IBAction)back:(id)sender;
-(void)loadData:(id) sender;


@end
