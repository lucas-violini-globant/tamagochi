//
//  TamagochiUITableViewCell.m
//  Tamagochi
//
//  Created by Lucas on 11/20/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiUITableViewCell.h"
#import "TamagochiFoodCollection.h"
#import "TamagochiFood.h"


@implementation TamagochiUITableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)configurarParaComida:(int)foodId enColeccionDeComida:(TamagochiFoodCollection *) foodCollection
{
    
    TamagochiFood *comida = [foodCollection getFoodById:foodId];
    
    self.foodImage.image = [UIImage imageNamed:[comida getImageName]];
    
    self.labelName.text = [comida getName];
    

    self.labelEnergy.text = [NSString stringWithFormat:@"%0.0f",[comida getEnergy]];
    
    self.foodObject = comida;
    
    return self;
}

@end
