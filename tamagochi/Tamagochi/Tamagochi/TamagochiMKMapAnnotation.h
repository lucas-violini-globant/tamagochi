//
//  TamagochiMKMapAnnotation.h
//  Tamagochi
//
//  Created by Lucas on 12/2/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiPet.h"

#ifndef Tamagochi_TamagochiMKMapAnnotation_h
#define Tamagochi_TamagochiMKMapAnnotation_h


#endif
           
@interface TamagochiMKMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
-(id)initWithPet:(TamagochiPet *)aPet;

@end
