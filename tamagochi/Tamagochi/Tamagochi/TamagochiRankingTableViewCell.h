//
//  TamagochiRankingTableViewCell.h
//  Tamagochi
//
//  Created by Lucas on 12/1/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TamagochiPet.h"
#import "PetRanking.h"

@interface TamagochiRankingTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *petUImageView;

@property (strong, nonatomic) IBOutlet UILabel *petNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *petLevelLabel;
@property (strong, nonatomic) IBOutlet UIImageView *petMapIconUImageView;
@property (strong, nonatomic) TamagochiPet *pet;

-(id)configurarParaMascota:(int)numeroFila enPetRanking:(PetRanking *) unRanking;

@end
