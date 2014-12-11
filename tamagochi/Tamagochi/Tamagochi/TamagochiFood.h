//
//  TamagochiFood.h
//  Tamagochi
//
//  Created by Lucas on 11/20/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TamagochiFood : NSObject

-(id)initWithFoodId:(int)foodId;

-(NSString *)getName;

-(NSString *)getImageName;

-(float) getEnergy;

@end