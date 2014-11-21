//
//  TamagochiFood.m
//  Tamagochi
//
//  Created by Lucas on 11/20/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TamagochiFood : NSObject

@property (nonatomic, strong) NSString *foodImageName;
@property (nonatomic, strong) NSString *foodName;
@property int foodId;

@end


@implementation TamagochiFood : NSObject


-(id) initWithFoodId:(int)foodId
{
    self = [super init];
    if (self)
    {
        self.foodId = foodId;
        self.foodName = [self setFoodNameById:foodId];
        self.foodImageName = [self setFoodImageNameById:foodId];
    }
    return self;
}


-(NSString *)setFoodImageNameById:(int)aFoodId
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


-(NSString *)setFoodNameById:(int)aFoodId
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


-(NSString *)getName
{
    return _foodName;
}

-(NSString *)getImageName
{
    return _foodImageName;
}


@end




