//
//  PetRanking.h
//  Tamagochi
//
//  Created by Lucas on 11/29/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#ifndef Tamagochi_PetRanking_h
#define Tamagochi_PetRanking_h


#endif

#import "TamagochiPet.h"

@interface PetRanking : NSObject

-(void)addPet:(TamagochiPet *)aPet;

-(int)count;

+ (instancetype) sharedInstance;

-(BOOL)addPetsInArray:(NSArray *) aNSArray;

-(TamagochiPet *)getPetByPosition:(int)position;

-(NSMutableArray *)getNSMutableArray;

-(id)getPetWithUniqueCode:(NSString *)uniqueCode;


@end
