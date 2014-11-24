//
//  TamagochiPet.h
//  Tamagochi
//
//  Created by Lucas on 11/24/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#ifndef Tamagochi_TamagochiPet_h
#define Tamagochi_TamagochiPet_h


#endif

@interface TamagochiPet

-(TamagochiPet *) setTag:(int)someTag;

-(void) setName:(NSString *)someName;

-(NSString *)getPetName;

-(NSString *)getPetType;

-(NSArray *)getFeedingImagesArray;

-(NSArray *)getExercisingImagesArray;

+ (instancetype) sharedInstance;

-(BOOL) startEating;

-(BOOL) stopEating;

-(BOOL) isEating;

-(BOOL) startExercising;

-(BOOL) stopExercising;

-(BOOL) isExercising;

-(int)getEnergy;

@end
