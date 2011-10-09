//
//  iCadiviAppDelegate.h
//  iCadivi
//
//  Created by Boris Polania on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class mainCuposView;

@interface iCadiviAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    
	IBOutlet NSInteger selectedCupo;
	IBOutlet NSInteger selectedGasto;
	IBOutlet NSInteger numeroDeCupos;
	IBOutlet NSInteger selectedItem;
	IBOutlet NSInteger selectedHelpSection;
	
	IBOutlet UINavigationController *navigationController;
	IBOutlet UITabBarController *tabBarController;
	
	UIImageView *imageView;
	
	UIWindow *window;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, assign) IBOutlet NSInteger selectedCupo;
@property (nonatomic, assign) IBOutlet NSInteger selectedGasto;
@property (nonatomic, assign) IBOutlet NSInteger numeroDeCupos;
@property (nonatomic, assign) IBOutlet NSInteger selectedHelpSection;
@property (nonatomic, assign) IBOutlet NSInteger selectedItem;

-(void)changeTabIndex:(NSInteger)index;

- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;

@end

