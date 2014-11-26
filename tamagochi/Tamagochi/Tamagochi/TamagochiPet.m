//
//  TamagochiPet.m
//  Tamagochi
//
//  Created by Lucas on 11/24/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TamagochiFood.h"


@interface TamagochiPet : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *typeName;
@property int tagId;
@property (nonatomic, strong) NSArray *feedingImages;
@property (nonatomic, strong) NSArray *exercisingImages;
@property (nonatomic, strong) NSArray *exhaustedImages;
@property (nonatomic, strong) NSArray *exhaustedToNormalImages;
@property float energy;
@property float exerciseEnergyCost;
@property int level;
@property float experience;
//@property BOOL stateIsExercising;
//@property BOOL stateIsEating;
@property (nonatomic, strong) NSString *imageNameNormal;
@property (nonatomic, strong) NSString *imageNameExhausted;
@property (nonatomic, strong) NSString *imageNameCurrent;


@end

@implementation TamagochiPet : NSObject

-(TamagochiPet *) setTag:(int)someTag

{
    TamagochiPet *instancia = [TamagochiPet sharedInstance];
    _feedingImages = [instancia getFeedingImagesArrayByTag:someTag];
    _exercisingImages = [instancia getExercisingImagesArrayByTag:someTag];
    _exhaustedImages = [instancia getExhaustedImagesArrayByTag:someTag];
    _exhaustedToNormalImages = [instancia getExhaustedToNormalImagesArrayByTag:someTag];
    _imageNameNormal = [instancia getNormalImageNameByTag:someTag];
    _imageNameExhausted = [instancia getExhaustedImageNameByTag:someTag];
    _imageNameCurrent = _imageNameNormal;
    _typeName = [instancia getPetTypeByTag:someTag];
    //_stateIsEating = NO;
    //_stateIsExercising = NO;
    _level = 0;
    _energy = 50.0;
    _experience = 0.0;
    _exerciseEnergyCost = 10.0;
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


-(NSArray *)getFeedingImagesArray
{
    return _feedingImages;
}


-(NSArray *)getExercisingImagesArray
{
    return _exercisingImages;
}

-(NSArray *)getExhaustedImagesArray
{
    return _exhaustedImages;
}


-(NSArray *)getExhaustedToNormalImagesArray
{
    return _exhaustedToNormalImages;
}


-(NSString *)getImage
{
    return _imageNameCurrent;
}


-(float)experienceRequiredForNextLevel
{
    return (_level * _level * 100);
}

-(BOOL)addExperience:(float) aFloat
{
    _experience = _experience + aFloat;
    if (_experience <= [self experienceRequiredForNextLevel])
    {
        [self didPassLevel];
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)didPassLevel
{
    //sin implementar
    _level = _level + 1;

}

-(NSString *)getNormalImageNameByTag:(long)tag
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



-(NSString *)getExhaustedImageNameByTag:(long)tag
{
    NSString *imageName = @"";
    
    switch (tag) {
        case 0:
            imageName = @"ciervo_exhausto_4";
            break;
        case 1:
            imageName = @"gato_exhausto_4";
            break;
        case 2:
            imageName = @"jirafa_exhausto_4";
            break;
        case 3:
            imageName = @"leon_exhausto_4";
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




-(NSArray *)getExhaustedImagesArrayByTag:(long)tag
{
    NSArray * arreglo;
    
    switch (tag) {
        case 0:
            //Ciervo
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ciervo_exhausto_1"],
                       [UIImage imageNamed:@"ciervo_exhausto_2"],
                       [UIImage imageNamed:@"ciervo_exhausto_3"],
                       [UIImage imageNamed:@"ciervo_exhausto_4"],
                       nil];
            break;
        case 1:
            //Gato
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"gato_ejercicio_1"],
                       [UIImage imageNamed:@"gato_exhausto_2"],
                       [UIImage imageNamed:@"gato_exhausto_3"],
                       [UIImage imageNamed:@"gato_exhausto_4"],
                       nil];
            break;
        case 2:
            //Jirafa
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"jirafa_ejercicio_1"],
                       [UIImage imageNamed:@"jirafa_exhausto_2"],
                       [UIImage imageNamed:@"jirafa_exhausto_3"],
                       [UIImage imageNamed:@"jirafa_exhausto_4"],
                       nil];
            break;
        case 3:
            //Leon
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"leon_ejercicio_1"],
                       [UIImage imageNamed:@"leon_exhausto_2"],
                       [UIImage imageNamed:@"leon_exhausto_3"],
                       [UIImage imageNamed:@"leon_exhausto_4"],
                       nil];
            break;
        default:
            arreglo = [[NSArray alloc] initWithObjects:nil];
            break;
    }
    return arreglo;
    
}


-(NSArray *)getExhaustedToNormalImagesArrayByTag:(long)tag
{
    NSArray * arreglo;
    
    switch (tag) {
        case 0:
            //Ciervo
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ciervo_exhausto_4"],
                       [UIImage imageNamed:@"ciervo_exhausto_3"],
                       [UIImage imageNamed:@"ciervo_exhausto_2"],
                       [UIImage imageNamed:@"ciervo_exhausto_1"],
                       nil];
            break;
        case 1:
            //Gato
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"gato_ejercicio_4"],
                       [UIImage imageNamed:@"gato_exhausto_3"],
                       [UIImage imageNamed:@"gato_exhausto_2"],
                       [UIImage imageNamed:@"gato_exhausto_1"],
                       nil];
            break;
        case 2:
            //Jirafa
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"jirafa_ejercicio_4"],
                       [UIImage imageNamed:@"jirafa_exhausto_3"],
                       [UIImage imageNamed:@"jirafa_exhausto_2"],
                       [UIImage imageNamed:@"jirafa_exhausto_1"],
                       nil];
            break;
        case 3:
            //Leon
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"leon_ejercicio_4"],
                       [UIImage imageNamed:@"leon_exhausto_3"],
                       [UIImage imageNamed:@"leon_exhausto_2"],
                       [UIImage imageNamed:@"leon_exhausto_1"],
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


-(float)getEnergy
{
    return _energy;
}

-(BOOL)switchStateToExhausted
{
    _imageNameCurrent = _imageNameExhausted;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"PET_STATUS_CHANGED" object:nil];

    return YES;
}


-(BOOL)switchStateToNormal
{
    _imageNameCurrent = _imageNameNormal;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PET_STATUS_CHANGED_NORMAL" object:nil];
    
    return YES;
}



-(BOOL) eatFood:(TamagochiFood *) someFood
//Returns YES if it was able to eat the food, otherwise return NO
{
    if ([self canBeFed])
    {
        _energy = _energy + [someFood getEnergy];
        if ([self canBeExercised])
        {
            [self switchStateToNormal];
        }

        return YES;
    }
    else
    {
        return NO;
    }
    
    //Por ahora empieza y termina de comer en el mismo momento

}

-(BOOL)doneEating
{
    //_stateIsEating = NO;
    //Sin uso, ya que el estado no esta implementado
    return YES;
}

-(BOOL) isEating
{
    //return _stateIsEating;
    //Sin uso, ya que el estado no esta implementado
    return NO;
}



-(BOOL) exercise
//Returns YES if it was able to exercise, otherwise return NO
{
    
    if ([self canBeExercised])
    {
        _energy = _energy - _exerciseEnergyCost; //Reduce the amount of energy
        //_stateIsExercising = YES;
        [self addExperience:15.0f];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LEVEL_PASSED" object:nil];
        if (![self canBeExercised])
        {
            [self switchStateToExhausted];
        }
        return YES;
    }
    else
    {
        return NO;
    }
    //_stateIsExercising = NO; //Asumimos que internamente termina de comer en el momento
}

-(BOOL) canBeExercised
{
    return ((_energy - _exerciseEnergyCost > 0) && (![self isEating]));
}



-(BOOL) canBeFed
{
    return ((_energy < 100) && (![self isExercising]));
}



-(BOOL) doneExercising
{
    //_stateIsExercising = NO;
    return YES;
}


-(BOOL) isExercising
{
    //return _stateIsExercising;
    //Sin uso, ya que el estado no esta implementado
    return NO;
}


-(BOOL) isExhausted
{
    return (_energy < 25);
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
