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

#import "TamagochiFood.h"

@interface TamagochiPet

-(TamagochiPet *) setTag:(int)someTag;

-(int) getTag;

-(void) setName:(NSString *)someName;

-(NSString *)getPetName;

-(NSString *)getName;

-(NSString *)getPetType;

-(int)getLevel;

-(float)getExperience;

-(NSArray *)getFeedingImagesArray;

-(NSArray *)getExercisingImagesArray;

-(NSArray *)getExhaustedImagesArray;

-(NSString *)getImage;

+ (instancetype) sharedInstance;

-(BOOL) eatFood:(TamagochiFood *) someFood;

-(BOOL) doneEating;

-(BOOL) isEating;

-(BOOL) exercise;

-(BOOL) doneExercising;

-(BOOL) isExercising;

-(float)getEnergy;

-(BOOL) canBeExercised;

-(BOOL) canBeFed;

-(BOOL) isExhausted;

-(BOOL)setFromDictionary:(NSDictionary *) aDictionary;

@end
