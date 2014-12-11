//
//  TamagochiFood.m
//  Tamagochi
//
//  Created by Lucas on 11/20/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiFood.h"

@interface TamagochiFood ()

@property (nonatomic, strong) NSString *foodImageName;
@property (nonatomic, strong) NSString *foodName;
@property float foodEnergy;
@property int foodId;


@end


@implementation TamagochiFood : NSObject


-(id) initWithFoodId:(int)foodId
{
    self = [super init];
    if (self)
    {
        self.foodId = foodId;
        self.foodName = [self getFoodNameById:foodId];
        self.foodImageName = [self getFoodImageNameById:foodId];
        self.foodEnergy = [self getFoodEnergyById:foodId];
    }
    return self;
}


-(NSString *)getFoodImageNameById:(int)aFoodId
{
    NSString *name = @"";
    switch (aFoodId) {
        case 0:
            name = @"comida_0";
            break;
        case 1:
            name = @"comida_1";
            break;
        case 2:
            name = @"comida_2";
            break;
        case 3:
            name = @"comida_3";
            break;
        case 4:
            name = @"comida_4";
            break;
        case 5:
            name = @"comida_5";
            break;
        case 6:
            name = @"comida_6";
            break;
        case 7:
            name = @"comida_7";
            break;
        case 8:
            name = @"comida_8";
            break;
        default:
            name = @"";
            break;
    }
    return name;
}


-(NSString *)getFoodNameById:(int)aFoodId
{
    NSString *name = @"";
    switch (aFoodId) {
        case 0:
            name = @"Tarta";
            break;
        case 1:
            name = @"Torta";
            break;
        case 2:
            name = @"Helado";
            break;
        case 3:
            name = @"Pollo";
            break;
        case 4:
            name = @"Hamburguesa";
            break;
        case 5:
            name = @"Pescado";
            break;
        case 6:
            name = @"Manzana";
            break;
        case 7:
            name = @"Zochori";
            break;
        case 8:
            name = @"Pan";
            break;
        default:
            name = @"";
            break;
    }
    return name;
}


-(float)getFoodEnergyById:(int)aFoodId
{
    float energy = 0.0f;
    switch (aFoodId) {
        case 0:
            energy = 40.0f;
            break;
        case 1:
            energy = 50.0f;
            break;
        case 2:
            energy = 30.0f;
            break;
        case 3:
            energy = 40.0f;
            break;
        case 4:
            energy = 20.0f;
            break;
        case 5:
            energy = 20.0f;
            break;
        case 6:
            energy = 10.0f;
            break;
        case 7:
            energy = 45.0f;
            break;
        case 8:
            energy = 30.0f;
            break;
        default:
            energy = 0.0f;
            break;
    }
    return energy;
}



-(NSString *)getName
{
    return _foodName;
}

-(NSString *)getImageName
{
    return _foodImageName;
}

-(float) getEnergy
{
    return _foodEnergy;
}





@end




