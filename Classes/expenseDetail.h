//
//  expenseDetail.h
//  iCadivi
//
//  Created by Boris Polania on 9/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface expenseDetail : UITableViewController {
	
	NSMutableArray *filteredMutableArray;
	
	IBOutlet UITableView *myTable;

}

-(void)loadData:(id)sender;

@end
