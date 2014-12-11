//
//  TamagochiPet.m
//  Tamagochi
//
//  Created by Lucas on 11/24/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiPet.h"


@interface TamagochiPet ()




@end

@implementation TamagochiPet : NSManagedObject



#pragma mark - Propiedades synthesize

@synthesize name = name;
@synthesize typeName = typeName;
@synthesize tagId = _tagId;
@synthesize feedingImages = _feedingImages;
@synthesize exercisingImages = _exercisingImages;
@synthesize exhaustedImages = _exhaustedImages;
@synthesize exhaustedToNormalImages = _exhaustedToNormalImages;
@synthesize energy = _energy;
@synthesize exerciseEnergyCost = _exerciseEnergyCost;
@synthesize level = _level;
@synthesize experience = _experience;
@synthesize imageNameNormal = _imageNameNormal;
@synthesize imageNameExhausted = _imageNameExhausted;
@synthesize imageNameCurrent = _imageNameCurrent;
@synthesize uniqueCode = _uniqueCode;
@synthesize position_lat = _position_lat;
@synthesize position_lon = _position_lon;



#pragma mark - Configuracion e inicializacion
-(void) configureWithTag:(int)someTag

{

    self.feedingImages = [TamagochiPet getFeedingImagesArrayByTag:someTag];
    self.exercisingImages = [TamagochiPet getExercisingImagesArrayByTag:someTag];
    self.exhaustedImages = [TamagochiPet getExhaustedImagesArrayByTag:someTag];
    self.exhaustedToNormalImages = [TamagochiPet getExhaustedToNormalImagesArrayByTag:someTag];
    self.imageNameNormal = [TamagochiPet getNormalImageNameByTag:someTag];
    self.imageNameExhausted = [TamagochiPet getExhaustedImageNameByTag:someTag];
    self.imageNameCurrent = self.imageNameNormal;
    self.typeName = [TamagochiPet getPetTypeByTag:someTag];
}

-(void)initPetWithDefaults
{
    self.level = 1;
    self.energy = 50.0;
    self.experience = 0.0;
    self.exerciseEnergyCost = 10.0;
    self.uniqueCode = @"lv3503";
    if (self.name == nil)
    {
        self.name = @"";
    }
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




+(void)loadFromDataBaseByUniqueCode:(NSString *)unique_code
{
    NSLog(@"Entering on TamagochiPet --> +(void)loadFromDataBaseByUniqueCode:");
    NSManagedObjectContext *context = [[TamagochiPersistenceHelper sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TamagochiPet" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchLimit:1];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"level" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSPredicate *predicateID = [NSPredicate predicateWithFormat:@"unique_code == %@",unique_code];
    [fetchRequest setPredicate:predicateID];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects != nil) {
        NSUInteger count = [fetchedObjects count]; // May be 0 if the object has been deleted.
        if (count)
        {
            TamagochiPet *pet = [fetchedObjects objectAtIndex:0];
            [pet configureWithTag:[pet getTag]];
        }
        NSLog(@"Completed TamagochiPet --> +(void)loadFromDataBaseByUniqueCode:");
    }
    else {
        // Deal with error.
        NSLog(@"Error on TamagochiPet --> +(void)loadFromDataBaseByUniqueCode:");
    }
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
        
        
        [self initPetWithDefaults];
        [self configureWithTag:storedPetTag];
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

-(instancetype) initCoreData
{
    self = [NSEntityDescription
            insertNewObjectForEntityForName:@"TamagochiPet"
            inManagedObjectContext:[[TamagochiPersistenceHelper sharedInstance]managedObjectContext]];
    return self;
}

+ (instancetype) newInstance
{
    return [[TamagochiPet alloc] initCoreData];
}

+(instancetype) newInstanceClean
{
    TamagochiPet *pet = [[TamagochiPet newInstance] initCoreData];
    [pet initPetWithDefaults];
    return pet;
}


+(id)newInstanceAndInitWithDictionary:(NSDictionary *) aDictionary
{
    TamagochiPet *petObject = [TamagochiPet newInstance];
    [petObject setFromDictionary:aDictionary];
    return petObject;
}


-(BOOL)setFromDictionary:(NSDictionary *) aDictionary
{
    NSString *petName = [aDictionary valueForKey:@"name"];
    NSString *code = [aDictionary valueForKey:@"code"];
    NSNumber *experience = [aDictionary valueForKey:@"experience"];
    NSNumber *level = [aDictionary valueForKey:@"level"];
    NSNumber *energy = [aDictionary valueForKey:@"energy"];
    NSNumber *petType = [aDictionary valueForKey:@"pet_type"];
    
    NSLog(@"Updated values - Name: %@ , Experience: %@ , Level: %@ , Energy: %@, Pet_Type: %@",petName,experience,level,energy,petType,nil);
    
    [self configureWithTag:[petType integerValue]];
    self.name = petName;
    self.energy = [energy floatValue];
    self.experience = [experience floatValue];
    self.level = [level integerValue];
    
    self.uniqueCode = code;
    
    
    return YES;
}



#pragma mark - Setters y getters
-(int)getTag
{
    return self.tagId;
}

-(void) setPetName:(NSString *)someName
{
    if (someName == nil)
    {
        self.name = @"";
    }
    else
    {
        self.name = someName;
    }
}

-(NSString *)getName
{
    return self.name;
}

-(NSString *)getType
{
    return self.typeName;
}

-(float)getEnergy
{
    return self.energy;
}


-(NSString *) getPetName
{
    return [self name];
}

-(NSString *)getUniqueCode
{
    return self.uniqueCode;
}

-(NSArray *)getFeedingImagesArray
{
    return self.feedingImages;
}


-(NSArray *)getExercisingImagesArray
{
    return self.exercisingImages;
}

-(NSArray *)getExhaustedImagesArray
{
    return self.exhaustedImages;
}


-(NSArray *)getExhaustedToNormalImagesArray
{
    return self.exhaustedToNormalImages;
}


-(NSString *)getImage
{
    return self.imageNameCurrent;
}


-(int)getLevel
{
    return self.level;
}

-(float)getExperience
{
    return self.experience;
}

-(NSString *)getPetType
{
    return self.typeName;
}



-(float)getLatitude
{
    return self.position_lat;
}

-(float)getLongitude
{
    return self.position_lon;
}

-(void)setLatitude:(float)latitude
{
    self.position_lat = latitude;
}

-(void)setLongitude:(float)longitude
{
    self.position_lon = longitude;
}


#pragma mark - Metodos auxiliares y eventos




- (NSComparisonResult)compareLevel:(TamagochiPet *)otherObject
{
    
    if ([otherObject getLevel] == [self getLevel])
        return NSOrderedSame;
    if ([otherObject getLevel] < [self getLevel])
        return NSOrderedAscending;
    return NSOrderedDescending;
    
}


-(float)experienceRequiredForNextLevel
{
    return (self.level * self.level * 100);
}

-(BOOL)addExperience:(float) aFloat
{
    //If it has passed to the next level, return YES
    self.experience = self.experience + aFloat;
    if (self.experience >= [self experienceRequiredForNextLevel])
    {
        [self didPassLevel];
        return YES;
    }
    else
    {
        return NO;
    }
}



-(BOOL) eatFood:(TamagochiFood *) someFood
//Returns YES if it was able to eat the food, otherwise return NO
{
    if ([self canBeFed])
    {
        self.energy = self.energy + [someFood getEnergy];
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
        self.energy = self.energy - self.exerciseEnergyCost; //Reduce the amount of energy
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
    return ((self.energy - self.exerciseEnergyCost > 0) && (![self isEating]));
}



-(BOOL) canBeFed
{
    return ((self.energy < 100) && (![self isExercising]));
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
    return (self.energy < 25);
}


-(void)didPassLevel
{
    //sin implementar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LEVEL_PASSED" object:nil];
    //NSLog(@"*****LEVEL PASSED*****");
    self.experience = self.experience - 100.0f;
    self.level = self.level + 1;

}

-(BOOL)switchStateToExhausted
{
    self.imageNameCurrent = self.imageNameExhausted;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PET_STATUS_CHANGED" object:nil];
    
    return YES;
}


-(BOOL)switchStateToNormal
{
    self.imageNameCurrent = self.imageNameNormal;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PET_STATUS_CHANGED_NORMAL" object:nil];
    
    return YES;
}




#pragma mark - Creacion de arrays e imagenes segun Tag
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






@end
