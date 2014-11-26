//
//  TamagochiUITableViewCell.h
//  Tamagochi
//
//  Created by Lucas on 11/20/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TamagochiFoodCollection.h"
#import "TamagochiFood.h"

@interface TamagochiUITableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelName;

@property (strong, nonatomic) IBOutlet UIImageView *foodImage;

@property (strong, nonatomic) IBOutlet UILabel *labelEnergy;
@property (strong, nonatomic) TamagochiFood *foodObject;

-(id)configurarParaComida:(int)foodId enColeccionDeComida:(TamagochiFoodCollection *) foodCollection;

@end
