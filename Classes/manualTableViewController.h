//
//  manualTableViewController.h
//  iCadivi
//
//  Created by Boris Polania on 11/12/10.
//  Copyright 2010 Lake Lewis Tehcnologies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface manualTableViewController : UITableViewController {
	
	IBOutlet UITableView *myTable;
	
}

@property (nonatomic, retain) IBOutlet UITableView *myTable;

@end
