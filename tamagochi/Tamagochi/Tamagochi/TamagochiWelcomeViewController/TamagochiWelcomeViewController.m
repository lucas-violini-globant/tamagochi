//
//  TamagochiWelcomeViewController.m
//  Tamagochi
//
//  Created by Lucas on 11/18/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiWelcomeViewController.h"
#import "TamagochiSelectNameViewController.h"
#import "TamagochiPet.h"
#import "TamagochiNetworking.h"
#import "TamagochiStatusViewController.h"


@interface TamagochiWelcomeViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textFieldName;
@property (strong, nonatomic) NSString *oldName;

@property (strong, nonatomic) IBOutlet UIImageView *imgBackgroundLoading;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorLoading;
@property (strong, nonatomic) IBOutlet UIButton *DownloadPet;
@property (strong, nonatomic) IBOutlet UIButton *btnContinue;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;


@end

@implementation TamagochiWelcomeViewController


#pragma mark - Metodos comunes de View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textFieldName.delegate = self;
    self.oldName = @"";

}



-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(petDownloadSuccess) name:@"PET_DOWNLOAD_SUCCESS" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(petDownloadFailure) name:@"PET_DOWNLOAD_FAILURE" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Efecto de Loading (On/Off)
-(void)showLoading
{
    self.btnContinue.enabled = NO;
    self.textFieldName.enabled = NO;
    self.DownloadPet.enabled = NO;
    self.imgBackgroundLoading.hidden = NO;
    self.activityIndicatorLoading.hidden = NO;
    [self.activityIndicatorLoading startAnimating ];
}

-(void)hideLoading
{
    self.btnContinue.enabled = YES;
    self.textFieldName.enabled = YES;
    self.DownloadPet.enabled = YES;
    self.imgBackgroundLoading.hidden = YES;
    self.imgBackgroundLoading.bounds = self.view.bounds;
    self.activityIndicatorLoading.hidden = YES;
    [self.activityIndicatorLoading stopAnimating ];

}

#pragma mark - Prueba de Notificaciones Push
- (IBAction)testPushLocal:(id)sender {
    //Create a new local notification
    UILocalNotification *localNotification =[[UILocalNotification alloc]init];
    
    // Notification details
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:20];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatCalendar = [NSCalendar currentCalendar];
    localNotification.alertBody = @"Alerta";
    localNotification.alertAction = @"Accion";
    //localNotification.userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:CHECK_IN_STRATEGY_USER_INFO_VALUE, CHECK_IN_STRATEGY_USER_INFO_KEY, nil];
    localNotification.repeatInterval = 0;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    
    // Schedule the notification
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
    
}

#pragma mark - Actualizacion de mascota desde el servidor

- (IBAction)updatePetFromServer:(id)sender
{
    NSLog(@"- (IBAction)updatePetFromServer:(id)sender");
    [self showLoading];
    TamagochiNetworking *tn = [[TamagochiNetworking alloc] init];
    //BOOL result = [tn downloadPetFromServer];
    
    TamagochiWelcomeViewController * __weak weakerSelf = self;
    
    [tn downloadPetFromServerWithSuccess:^{[weakerSelf petDownloadSuccess];}
                                 failure:^{[weakerSelf petDownloadFailure];}];
        
}

-(void)petDownloadSuccess
{
    NSLog(@"SUCCESS Downloading Pet!! - ");
    [self hideLoading];
    TamagochiStatusViewController *home = [[TamagochiStatusViewController alloc] initWithNibName:@"TamagochiStatusViewController" bundle:nil];
    [self.navigationController pushViewController:home animated:YES];
}

-(void)petDownloadFailure
{
    NSLog(@"FAILURE Downloading Pet!! - ");
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error has ocurred while connecting to the server" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alerta show];
    [self hideLoading];
    
}

#pragma mark - Textfield
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


#pragma mark - Pasaje a pantalla de seleccion de mascota
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
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"screen1Passed"];
        [[TamagochiPet sharedInstance] setName:[self.textFieldName text]];
        TamagochiSelectNameViewController* home = [[TamagochiSelectNameViewController alloc] initWithNibName:@"TamagochiSelectNameViewController" bundle:nil];
        [self.navigationController pushViewController:home animated:YES];
    }
}

@end
