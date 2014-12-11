//
//  TamagochiRankingTableViewCell.m
//  Tamagochi
//
//  Created by Lucas on 12/1/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiRankingTableViewCell.h"




@implementation TamagochiRankingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickImage:(id)sender {
}

-(id)configurarParaMascota:(int)numeroFila enPetRanking:(PetRanking *) unRanking
{
    
    self.pet = [unRanking getPetByPosition:numeroFila];
    
    self.petUImageView.image = [UIImage imageNamed:[self.pet getImage]];
    
    self.petNameLabel.text = [self.pet getName];
    
    self.petLevelLabel.text = [self.pet getName];
    
    self.petLevelLabel.text = [NSString stringWithFormat:@"%d",[self.pet getLevel]];
    
    
    if ([[[TamagochiPet sharedInstance] getUniqueCode ] isEqualToString:[self.pet getUniqueCode]])
    {
        [self.contentView setBackgroundColor: [UIColor darkGrayColor]];

        self.petNameLabel.text = [NSString stringWithFormat:@"%@ (YOU)",self.petNameLabel.text];
    }
    else
    {
        [self.contentView setBackgroundColor: [UIColor yellowColor]];
    }

    
    
    return self;
    
}


@end
