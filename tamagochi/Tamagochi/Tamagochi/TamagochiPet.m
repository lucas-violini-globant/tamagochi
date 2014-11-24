//
//  TamagochiPet.m
//  Tamagochi
//
//  Created by Lucas on 11/24/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TamagochiPet : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *typeName;
@property int tagId;
@property (nonatomic, strong) NSArray *feedingImages;
@property (nonatomic, strong) NSArray *exercisingImages;
@property int energy;
@property int energyStep;
@property int level;
@property BOOL stateIsExercising;
@property BOOL stateIsEating;
@property (nonatomic, weak) NSString *imageName;


@end

@implementation TamagochiPet : NSObject

-(TamagochiPet *) setTag:(int)someTag

{
    TamagochiPet *instancia = [TamagochiPet sharedInstance];
    _feedingImages = [instancia getFeedingImagesArrayByTag:someTag];
    _exercisingImages = [instancia getExercisingImagesArrayByTag:someTag];
    _imageName = [instancia getImageNameByTag:someTag];
    _typeName = [instancia getPetTypeByTag:someTag];
    _stateIsEating = NO;
    _stateIsExercising = NO;
    _level = 0;
    _energy = 50;
    _energyStep = 10;
    if (_name == nil)
    {
        _name = @"";
    }
    return instancia;
}


-(void) setName:(NSString *)someName
{
    _name = someName;
}


-(BOOL)increaseEnergyLevel
{
//Intenta aumentar su nivel energia, si sale todo bien devuelve YES
    BOOL result = YES;
    _energy = _energy + _energyStep;
    if (_energy > 100)
    {
        _energy = 100;
        result = NO;
    }
    
    return result;
    
}

-(BOOL)decreaseEnergyLevel
//Intenta reducir su nivel energia, si sale todo bien devuelve YES
{
    BOOL result = YES;
    _energy = _energy - _energyStep;
    if (_energy < 0)
    {
        _energy = 0;
        result = NO;
    }
    
    return result;
}


-(NSArray *)getFeedingImagesArray
{
    return _feedingImages;
}


-(NSArray *)getExercisingImagesArray
{
    return _exercisingImages;
}



-(NSString *)getImageNameByTag:(long)tag
{
    NSString *imageName = @"";
    
    switch (tag) {
        case 0:
            imageName = @"ciervo_comiendo_1";
            break;
        case 1:
            imageName = @"gato_comiendo_1";
            break;
        case 2:
            imageName = @"jirafa_comiendo_1";
            break;
        case 3:
            imageName = @"leon_comiendo_1";
            break;
        default:
            imageName = @"";
            break;
    }
    return imageName;
    
}


-(NSArray *)getFeedingImagesArrayByTag:(long)tag
{
    NSArray * arreglo;
    
    switch (tag) {
        case 0:
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ciervo_comiendo_1"],
                       [UIImage imageNamed:@"ciervo_comiendo_2"],
                       [UIImage imageNamed:@"ciervo_comiendo_3"],
                       [UIImage imageNamed:@"ciervo_comiendo_4"],
                       nil];
            break;
        case 1:
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"gato_comiendo_1"],
                       [UIImage imageNamed:@"gato_comiendo_2"],
                       [UIImage imageNamed:@"gato_comiendo_3"],
                       [UIImage imageNamed:@"gato_comiendo_4"],
                       nil];
            break;
        case 2:
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"jirafa_comiendo_1"],
                       [UIImage imageNamed:@"jirafa_comiendo_2"],
                       [UIImage imageNamed:@"jirafa_comiendo_3"],
                       [UIImage imageNamed:@"jirafa_comiendo_4"],
                       nil];
            break;
        case 3:
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"leon_comiendo_1"],
                       [UIImage imageNamed:@"leon_comiendo_2"],
                       [UIImage imageNamed:@"leon_comiendo_3"],
                       [UIImage imageNamed:@"leon_comiendo_4"],
                       nil];
            break;
        default:
            arreglo = [[NSArray alloc] initWithObjects:nil];
            break;
    }
    return arreglo;
    
}


-(NSArray *)getExercisingImagesArrayByTag:(long)tag
{
    NSArray * arreglo;
    
    switch (tag) {
        case 0:
            //Ciervo
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ciervo_ejercicio_1"],
                       [UIImage imageNamed:@"ciervo_ejercicio_2"],
                       [UIImage imageNamed:@"ciervo_ejercicio_3"],
                       [UIImage imageNamed:@"ciervo_ejercicio_4"],
                       nil];
            break;
        case 1:
            //Gato
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"gato_ejercicio_1"],
                       [UIImage imageNamed:@"gato_ejercicio_2"],
                       [UIImage imageNamed:@"gato_ejercicio_3"],
                       [UIImage imageNamed:@"gato_ejercicio_4"],
                       nil];
            break;
        case 2:
            //Jirafa
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"jirafa_ejercicio_1"],
                       [UIImage imageNamed:@"jirafa_ejercicio_2"],
                       [UIImage imageNamed:@"jirafa_ejercicio_3"],
                       [UIImage imageNamed:@"jirafa_ejercicio_4"],
                       nil];
            break;
        case 3:
            //Leon
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"leon_ejercicio_1"],
                       [UIImage imageNamed:@"leon_ejercicio_2"],
                       [UIImage imageNamed:@"leon_ejercicio_3"],
                       [UIImage imageNamed:@"leon_ejercicio_4"],
                       nil];
            break;
        default:
            arreglo = [[NSArray alloc] initWithObjects:nil];
            break;
    }
    return arreglo;
    
}



-(NSString *)getPetTypeByTag:(long)tag
{
    NSString *resultado;
    
    switch (tag) {
        case 0:
            //Ciervo
            resultado = @"Deer";

            break;
        case 1:
            //Gato
            resultado = @"Cat";

            break;
        case 2:
            //Jirafa
            resultado = @"Jiraph";

            break;
        case 3:
            //Leon
            resultado = @"Lion";
            break;
        default:
            resultado = @"Undefined";
            break;
    }
    return resultado;
    
}


-(NSString *)getName
{
    return _name;
}

-(NSString *)getType
{
    return _typeName;
}


-(int)getEnergy
{
    return _energy;
}


-(BOOL) startEating
{
    if ([self increaseEnergyLevel])
    {
        _stateIsEating = YES;
        return YES;
    }
    else
    {
        return NO;
    }
    
    //Por ahora empieza y termina de comer en el mismo metodo
    _stateIsEating = NO;
}

-(void) stopEating
{
    _stateIsEating = NO;
}


-(BOOL) isEating
{
    return _stateIsEating;
}



-(BOOL) startExercising
{
    if ([self decreaseEnergyLevel])
    {
        _stateIsExercising = YES;
        return YES;
    }
    else
    {
        return NO;
    }
}



-(BOOL) stopExercising
{
    _stateIsExercising = NO;
    return YES;
}


-(BOOL) isExercising
{
    return _stateIsExercising;
}



+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    //Garantiza que lo que se encuentre dentro solo se ejecutará una vez.
    dispatch_once(&pred, ^{
                            _sharedObject = [[self alloc] init];
                           }
                  );
    return _sharedObject;
}


@end
