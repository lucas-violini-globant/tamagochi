//
//  TamagochiWelcomeViewController.m
//  Tamagochi
//
//  Created by Lucas on 11/18/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiWelcomeViewController.h"
#import "TamagochiSelectNameViewController.h"


@interface TamagochiWelcomeViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textFieldName;
@property (strong, nonatomic) NSString *oldName;
@end

@implementation TamagochiWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textFieldName.delegate = self;
    self.oldName = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)switchToSelectImageScreen:(id)sender
{
    if ([self.textFieldName.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"You must enter a name for your pet" delegate:self cancelButtonTitle:@"Okay man" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if ([self.textFieldName.text length] > 16)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name too long" message:@"Sorry, the maximum length allowed is 16." delegate:self cancelButtonTitle:@"Okay, whatever" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([self.textFieldName.text length] < 6)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name too short" message:@"The name must have at least 6 letters." delegate:self cancelButtonTitle:@"Okay, whatever" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        TamagochiSelectNameViewController* home = [[TamagochiSelectNameViewController alloc] initWithNibName:@"TamagochiSelectNameViewController" bundle:nil petName:[self.textFieldName text]];

        [self.navigationController pushViewController:home animated:YES];
        [self.navigationController setTitle:@"Choose an Image"];
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}


- (IBAction)nameChanged:(id)sender {
    
    //BOOL isValid = [self.textFieldName.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].length == self.textFieldName.text.length;
    BOOL isValid = [self.textFieldName.text rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789-,><:;.!@#$%^&*()_+=-/"]].location == NSNotFound;
    
   if (!isValid)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name too weird" message:@"Only letters and spaces, please" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        self.textFieldName.text = self.oldName;
    }
    else
    {
        self.oldName = self.textFieldName.text;
    }
    

    

    

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
