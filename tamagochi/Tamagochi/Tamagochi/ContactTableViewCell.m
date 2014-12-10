//
//  ContactTableViewCell.m
//  Tamagochi
//
//  Created by Lucas on 12/6/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "ContactTableViewCell.h"

@interface ContactTableViewCell ()

@property (nonatomic, strong) NSMutableDictionary *contactDictionary;

@end

@implementation ContactTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureForContact:(NSMutableDictionary *) aDictionary
{
    self.contactDictionary = aDictionary;
   
    NSString *first = [aDictionary objectForKey:@"first"];
    NSString *last = [aDictionary objectForKey:@"last"];
    
    self.firstAndLastName.text = [NSString stringWithFormat:@"%@ %@",first, last];
    self.phone.text = [aDictionary objectForKey:@"phone"];
    self.email.text = [aDictionary objectForKey:@"email"];
    self.company.text = [aDictionary objectForKey:@"company"];
}

- (IBAction)sendEmail:(id)sender {
    
    TamagochiSelectNameViewController* home = [[TamagochiSelectNameViewController alloc] initWithNibName:@"TamagochiSelectNameViewController" bundle:nil];
    [self.navigationController pushViewController:home animated:YES];
    [self.navigationController setTitle:@"Choose an Image"];
    
    
    NSString *subject = @"Titulo del email";
    NSString *message = @"Mensaje del email";
    NSArray *recipients = [[NSArray alloc] initWithObjects:@"lucas.violini@globant.com", nil];
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    composer.mailComposeDelegate = self;
    [composer setSubject:subject];
    [composer setMessageBody:message isHTML:NO];
    [composer setToRecipients:recipients];
    //[self presentViewController:composer animated:NO completion:nil];
    
}

@end
