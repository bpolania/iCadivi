//
//  gasto.h
//  iCadivi
//
//  Created by Boris Polania on 10/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface gasto :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * cupo;
@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSNumber * tipo;
@property (nonatomic, retain) NSNumber * ammount;
@property (nonatomic, retain) NSNumber * ATMcommision;
@property (nonatomic, retain) NSString * lugar;
@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) NSNumber * ID;

@end



