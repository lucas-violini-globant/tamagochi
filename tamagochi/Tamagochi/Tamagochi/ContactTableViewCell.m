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

@property (strong, nonatomic) IBOutlet UILabel *firstAndLastName;
@property (strong, nonatomic) IBOutlet UILabel *company;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *email;



@end

@implementation ContactTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Configuracion de celda

-(void)configureForContact:(NSMutableDictionary *) aDictionary
{
    self.contactDictionary = aDictionary;
   
    NSString *first = [aDictionary objectForKey:@"first"];
    NSString *last = [aDictionary objectForKey:@"last"];
    
    [self.firstAndLastName setText:[NSString stringWithFormat:@"%@ %@",first, last]];
    self.phone.text = [aDictionary objectForKey:@"phone"];
    self.email.text = [aDictionary objectForKey:@"email"];
    self.company.text = [aDictionary objectForKey:@"company"];
}

#pragma mark - IBActions Botones Contacto

- (IBAction)sendEmailToContact:(id)sender {

    NSString *emailAddress = self.email.text;
    if  ( ([emailAddress isEqualToString:@""]) || (emailAddress == NULL) )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This contact does not have an email address!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
    NSString *subject = @"Hey, I'm playing the Tamagotchi App";
    NSString *message = @"Take a look at this cool app";
    NSArray *recipients = [[NSArray alloc] initWithObjects:emailAddress, nil];
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
     composer.mailComposeDelegate = self;
     [composer setSubject:subject];
     [composer setMessageBody:message isHTML:NO];
     [composer setToRecipients:recipients];
     [self.tableViewController presentViewController:composer animated:NO completion:nil];
    }

}


- (IBAction)callToContact:(id)sender {
    
    if ([self.phone.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This contact does not have a phone number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.phone.text]]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.phone.text]]];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device does not support phone calling" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }

    }
    
    
}


#pragma mark - Metodo de protocolo para Mail Composer
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    NSString *mensaje;
    switch (result) {
        case MFMailComposeResultCancelled:
            mensaje = @"Email compose cancelled";
            break;
        case MFMailComposeResultFailed:
            mensaje = @"Email delivery failed";
            break;
        case MFMailComposeResultSaved:
            mensaje = @"Email saved as draft";
            break;
            
        case MFMailComposeResultSent:
            mensaje = @"Email sent successfuly!";
            break;
        default:
            mensaje = @"Undefined error";
            break;
    }
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Alert" message:mensaje delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alerta show];
    [self.tableViewController dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
