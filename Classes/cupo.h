//
//  cupo.h
//  iCadivi
//
//  Created by Boris Polania on 10/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface cupo :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * ID;
@property (nonatomic, retain) NSNumber * total_ammount;
@property (nonatomic, retain) NSNumber * tipo;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * current_ammount;

@end



