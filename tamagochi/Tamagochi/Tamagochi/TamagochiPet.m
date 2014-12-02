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
#import <CoreLocation/CoreLocation.h>

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
@property (nonatomic, strong) NSString *uniqueCode;

@property  float position_lat;

@property  float position_lon;

@end

@implementation TamagochiPet : NSObject



-(void) configureWithTag:(int)someTag

{

    _feedingImages = [TamagochiPet getFeedingImagesArrayByTag:someTag];
    _exercisingImages = [TamagochiPet getExercisingImagesArrayByTag:someTag];
    _exhaustedImages = [TamagochiPet getExhaustedImagesArrayByTag:someTag];
    _exhaustedToNormalImages = [TamagochiPet getExhaustedToNormalImagesArrayByTag:someTag];
    _imageNameNormal = [TamagochiPet getNormalImageNameByTag:someTag];
    _imageNameExhausted = [TamagochiPet getExhaustedImageNameByTag:someTag];
    _imageNameCurrent = _imageNameNormal;
    _typeName = [TamagochiPet getPetTypeByTag:someTag];
}

-(void)initPetWithDefaults
{
    _level = 1;
    _energy = 50.0;
    _experience = 0.0;
    _exerciseEnergyCost = 10.0;
    _uniqueCode = @"lv3503";
    if (_name == nil)
    {
        _name = @"";
    }
}

-(int)getTag
{
    return _tagId;
}

-(void) setName:(NSString *)someName
{
    _name = someName;
}

-(NSString *)getUniqueCode
{
    return _uniqueCode;
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


-(int)getLevel
{
    return _level;
}

-(float)getExperience
{
    return _experience;
}



-(float)experienceRequiredForNextLevel
{
    return (_level * _level * 100);
    //NSLog([NSString stringWithFormat:@"Experience required to pass level: %f",(_level * _level * 100)]);
}

-(BOOL)addExperience:(float) aFloat
{
    _experience = _experience + aFloat;
    //NSLog([NSString stringWithFormat:@"Experience: %f",_experience]);
    if (_experience >= [self experienceRequiredForNextLevel])
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LEVEL_PASSED" object:nil];
    //NSLog(@"*****LEVEL PASSED*****");
    _experience = 0;
    _level = _level + 1;

}

+(NSString *)getNormalImageNameByTag:(long)tag
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



+(NSString *)getExhaustedImageNameByTag:(long)tag
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


+(NSArray *)getFeedingImagesArrayByTag:(long)tag
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


+(NSArray *)getExercisingImagesArrayByTag:(long)tag
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




+(NSArray *)getExhaustedImagesArrayByTag:(long)tag
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


+(NSArray *)getExhaustedToNormalImagesArrayByTag:(long)tag
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



+(NSString *)getPetTypeByTag:(long)tag
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

-(id)initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        NSString *storedPetName = [coder decodeObjectForKey:@"pet.name"];
        int storedPetTag = [coder decodeIntForKey:@"pet.tag"];
        float storedPetEnergy = [coder decodeFloatForKey:@"pet.energy"];
        int storedPetLevel = [coder decodeIntForKey:@"pet.level"];
        float storedPetExperience = [coder decodeFloatForKey:@"pet.experience"];
        float storedPetLatitude = [coder decodeFloatForKey:@"pet.latitude"];
        float storedPetLongitude = [coder decodeFloatForKey:@"pet.longitude"];
        NSString *storedPetCode = [coder decodeObjectForKey:@"pet.code"];
        
        //[self setTag:storedPetTag];
        [self initPetWithDefaults];
        [self setName:storedPetName];
        [self setLevel:storedPetLevel];
        [self setEnergy:storedPetEnergy];
        [self setExperience:storedPetExperience];
        [self setLatitude:storedPetLatitude];
        [self setLongitude:storedPetLongitude];
        [self setUniqueCode:storedPetCode];
    }
    return self;
}

-(void)encodeWithCoder: (NSCoder *)coder
{
    NSString *storedPetName = [self getName];
    int storedPetTag = [self getTag];
    float storedPetEnergy = [self getEnergy];
    int storedPetLevel = [self getLevel];
    float storedPetExperience = [self getExperience];
    float storedPetLatitude = [self getLatitude];
    float storedPetLongitude = [self getLongitude];
    NSString *storedPetCode = [self uniqueCode];
    

    [coder encodeObject:storedPetName forKey:@"pet.name"];
    [coder encodeInt:storedPetTag forKey:@"pet.tag"];
    [coder encodeFloat:storedPetEnergy forKey:@"pet.energy"];
    [coder encodeInt:storedPetLevel forKey:@"pet.level"];
    [coder encodeFloat:storedPetExperience forKey:@"pet.experience"];
    [coder encodeFloat:storedPetLatitude forKey:@"pet.latitude"];
    [coder encodeFloat:storedPetLongitude forKey:@"pet.longitude"];
    [coder encodeObject:storedPetCode forKey:@"pet.code"];
    

}






+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static TamagochiPet* _sharedObject = nil;
    //Garantiza que lo que se encuentre dentro solo se ejecutará una vez.
    dispatch_once(&pred, ^{
                            _sharedObject = [TamagochiPet loadData];
        
                            if (_sharedObject == nil)
                            {
                                _sharedObject = [[self alloc] init];
                                [_sharedObject initPetWithDefaults];
                            } else {
                                [_sharedObject configureWithTag:[_sharedObject getTag]];
                            }
                        }
                  );
    return _sharedObject;
}



+ (NSString *) pathForDataFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSError* error;
    
    directory = [directory stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: directory] == NO)
    {
        
        [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    NSString *fileName = [directory stringByAppendingString:@"/Tamagochi.ios"];
    
    return fileName;
}


- (void) saveData
{
    NSString *path = [TamagochiPet pathForDataFile];
    
    NSMutableDictionary *rootObject = [NSMutableDictionary dictionary];
    
    [rootObject setValue: self forKey:@"TamagochiPet"];
    
    [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}



+ (instancetype) loadData
{
    NSString *path = [self pathForDataFile];
    NSDictionary *rootObject;
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return [rootObject valueForKey:@"TamagochiPet"];
    
}


+ (instancetype) newInstance
{
    return [[TamagochiPet alloc] init];

}

+(id)newInstanceAndInitWithDictionary:(NSDictionary *) aDictionary
{
    TamagochiPet *petObject = [self newInstance];
    [petObject setFromDictionary:aDictionary];
    return petObject;
}


-(BOOL)setFromDictionary:(NSDictionary *) aDictionary
{
    //{"code":"lv3503","name":"okokokoko","_id":"547641321c7fc4020094cef8","__v":0,"experience":0,"last_update":"2014-11-26T21:35:08.386Z","level":1,"energy":50}
    NSString *name = [aDictionary valueForKey:@"name"];
    NSString *code = [aDictionary valueForKey:@"code"];
    NSNumber *experience = [aDictionary valueForKey:@"experience"];
    NSNumber *level = [aDictionary valueForKey:@"level"];
    NSNumber *energy = [aDictionary valueForKey:@"energy"];
    NSNumber *petType = [aDictionary valueForKey:@"pet_type"];
    
    NSLog(@"Updated values - Name: %@ , Experience: %@ , Level: %@ , Energy: %@, Pet_Type: %@",name,experience,level,energy,petType);
    
    [self configureWithTag:[petType integerValue]];
    _name = name;
    _energy = [energy floatValue];
    _experience = [experience floatValue];
    _level = [level integerValue];

    _uniqueCode = code;
    
    
    return YES;
}


-(float)getLatitude
{
    return _position_lat;
}

-(float)getLongitude
{
    return _position_lon;
}

-(void)setLatitude:(float)latitude
{
    _position_lat = latitude;
}

-(void)setLongitude:(float)longitude
{
    _position_lon = longitude;
}






- (NSComparisonResult)compareLevel:(TamagochiPet *)otherObject
{

    if ([otherObject getLevel] == [self getLevel])
            return NSOrderedSame;
    if ([otherObject getLevel] < [self getLevel])
            return NSOrderedAscending;
    return NSOrderedDescending;
            
}


@end
