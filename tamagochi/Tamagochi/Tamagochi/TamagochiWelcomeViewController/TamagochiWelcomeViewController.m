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
@end

@implementation TamagochiWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textFieldName.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchToSelectImageScreen:(id)sender
{
    
    TamagochiSelectNameViewController* home = [[TamagochiSelectNameViewController alloc] initWithNibName:@"TamagochiSelectNameViewController" bundle:nil petName:[self.textFieldName text]];

    [self.navigationController pushViewController:home animated:YES];
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
