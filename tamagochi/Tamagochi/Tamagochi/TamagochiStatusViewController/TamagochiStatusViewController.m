//
//  TamagochiStatusViewController.m
//  Tamagochi
//
//  Created by Lucas on 11/18/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//


#import "TamagochiStatusViewController.h"

@interface TamagochiStatusViewController ()

//@property (nonatomic,strong) NSString *petName;
@property int imageTag;

@property (strong, nonatomic) IBOutlet UIImageView *petImage;

@property (strong, nonatomic) IBOutlet UILabel *petNameLabel;

@property (strong, nonatomic) IBOutlet UIImageView *foodImage;

@property (strong, strong) NSTimer *exerciseTimer;

@property (strong, nonatomic) IBOutlet UIProgressView *energyBar;

@property (strong , nonatomic) TamagochiFood* foodSelected;

@property (strong, strong) NSTimer *fetchRankingTimer;

@end



@implementation TamagochiStatusViewController

CLLocationManager *locationManager = nil;


- (IBAction)sendEmail:(id)sender {
    
    NSString *subject = @"Titulo del email";
    NSString *message = @"Mensaje del email";
    NSArray *recipients = [[NSArray alloc] initWithObjects:@"lucas.violini@globant.com", nil];
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    composer.mailComposeDelegate = self;
    [composer setSubject:subject];
    [composer setMessageBody:message isHTML:NO];
    [composer setToRecipients:recipients] ;
    [self presentViewController:composer animated:NO completion:nil];
}

- (IBAction)btnTestUpdate:(id)sender {
    [self uploadStatusToServer];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    NSString *mensaje;
    switch (result) {
        case MFMailComposeResultCancelled:
            mensaje = @"Envio cancelado";
            break;
        case MFMailComposeResultFailed:
            mensaje = @"Envio fallido";
            break;
        case MFMailComposeResultSaved:
            mensaje = @"Email guardado en borradores";
            break;
            
        case MFMailComposeResultSent:
            mensaje = @"Email enviado exitosamente!";
            break;
        default:
            mensaje = @"Estado indefinido";
            break;
    }
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Alert" message:mensaje delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alerta show];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSString *imageName = [[TamagochiPet sharedInstance] getImage];
    self.petImage.image = [UIImage imageNamed:imageName];
    self.petNameLabel.text = [[TamagochiPet sharedInstance] getName];
    [self startUpdates];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *emailButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(sendEmail:)];
    self.navigationItem.rightBarButtonItem = emailButton;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(petStatusChanged)
                                                 name:@"PET_STATUS_CHANGED" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(petStatusChangedToNormal)
                                                 name:@"PET_STATUS_CHANGED_NORMAL" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(levelPassed)
                                                 name:@"LEVEL_PASSED" object:nil];
    

}




-(void)levelChanged
{
    [self popUpAlertWithMessage:@"Level passed!"];
}



-(void)uploadStatusToServer
{
    TamagochiNetworking *tn = [[TamagochiNetworking alloc] init];
    [tn uploadServerWithPetInformation];
}

-(void)petStatusChanged
{
    //NSLog(@"Method inoked: TamagochiStatusViewController -> petStatusChanged");
    TamagochiPet *pet = [TamagochiPet sharedInstance];
    if([pet isExhausted])
    {
         [self animateExhaustedPet];
    }
    self.petImage.image = [UIImage imageNamed:[pet getImage ] ];
}


-(void)petStatusChangedToNormal
{
    //NSLog(@"Method inoked: TamagochiStatusViewController -> petStatusChanged TO NORMAL");
    TamagochiPet *pet = [TamagochiPet sharedInstance];
    if([pet isExhausted])
    {
        [self animateExhaustedPet];
    }
    self.petImage.image = [UIImage imageNamed:[pet getImage ] ];
}

- (IBAction)clickExercising:(id)sender
{
    TamagochiPet *pet =[TamagochiPet sharedInstance];

    
    if ([pet canBeExercised])
        {
            //NSLog(@"Can Be Exercised");
            //Se puede ejercitar, entonces que empiece
            self.exerciseTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector: @selector(tick:) userInfo: nil repeats: YES];
            [self.btnExercise setTitle:@"Stop Exercise" forState:UIControlStateNormal];
        }
    
        else
        {
            //NSLog(@"Can NOT Be Exercised");
            //Ya estaba ejercitando, asi que lo que corresponde hacer es dejar de ejercitar, y detener el timer.
            [[TamagochiPet sharedInstance] doneExercising];
            if(self.exerciseTimer && [self.exerciseTimer isValid])
            {
                [self.exerciseTimer invalidate];
                self.exerciseTimer = nil;
            }
            [self.btnExercise setTitle:@"Start Exercise" forState:UIControlStateNormal];
         }

}


-(void)tick:(NSTimer *)timer
{
    TamagochiPet *pet =[TamagochiPet sharedInstance];
    if ([ pet canBeExercised])
    {
        [pet exercise];
        [self animateExercisingPet];
        self.energyBar.progress = [pet getEnergy] / 100 ;
    }
    else
    {
        //No se puede ejercitar mas, detengo el timer
        [self.btnExercise setTitle:@"Start Exercise" forState:UIControlStateNormal];
        if(self.exerciseTimer && [self.exerciseTimer isValid])
        {
            [self.exerciseTimer invalidate];
            self.exerciseTimer = nil;
        }
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)animateFeedingPet
{
    TamagochiPet *pet = [TamagochiPet sharedInstance];
    [self.petImage setAnimationImages:[pet getFeedingImagesArray]];
    //[self.petImage setAnimationImages:[self getFeedingImageArrayForCurrentPet]];

    [self.petImage setAnimationRepeatCount:3];
    [self.petImage setAnimationDuration:0.3];
    [self.petImage startAnimating];
    
}


-(void)animateExhaustedPet
{
    TamagochiPet *pet = [TamagochiPet sharedInstance];
    [self.petImage setAnimationImages:[pet getExhaustedImagesArray]];
    //[self.petImage setAnimationImages:[self getFeedingImageArrayForCurrentPet]];
    
    [self.petImage setAnimationRepeatCount:3];
    [self.petImage setAnimationDuration:0.3];
    [self.petImage startAnimating];
    
}

-(void)switchToExhausted
{
    self.petImage.image = [UIImage imageNamed:[[TamagochiPet sharedInstance] getImage ]  ];
}

-(void)levelPassed
{
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Level passed!!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alerta show];
    
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"PeleaDeMascotas"];
    TamagochiPet *pet= [TamagochiPet sharedInstance];
    NSString *level = [NSString stringWithFormat:@"%d",[pet getLevel] ];
    NSString *energy = [NSString stringWithFormat:@"%0.0f",[pet getEnergy] ];
    NSString *experience = [NSString stringWithFormat:@"%0.0f",[pet getExperience] ];
    NSString *name = [pet getName];
    NSString *code = [pet getUniqueCode];
    NSNumber *petType = [NSNumber numberWithInt:[pet getTag]];
    NSDictionary *notif = [[NSDictionary alloc] initWithObjects:@[code,name,level,experience,energy,petType]
                                  forKeys:@[@"code",@"name",@"level",@"experience",@"energy",@"pet_type"]];
    
    [push setData: notif];
    [push sendPushInBackground];
    [self uploadStatusToServer];
}
- (IBAction)uploadManually:(id)sender {
    [self uploadStatusToServer];
}


-(void)animateExercisingPet
{
    TamagochiPet *tama = [TamagochiPet sharedInstance];
    [self.petImage setAnimationImages:[tama getExercisingImagesArray]];
    [self.petImage setAnimationRepeatCount:3];
    [self.petImage setAnimationDuration:0.3];
    [self.petImage startAnimating];
}

-(void)changeEnergyBarTo:(float)energyAmount
{
    [self.energyBar setProgress:energyAmount animated:YES];
}


-(void)popUpAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}


- (IBAction)moverComida:(UITapGestureRecognizer *)recognizer
{
    
    if (self.foodImage.alpha == 1.0)
    {
    CGPoint puntoNuevo = [recognizer locationInView:self.view];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^(void){
                     self.foodImage.center = puntoNuevo;
                     }
                     completion:^(BOOL finished)
                                    {
                         
                                        if(puntoNuevo.x > 110.0f && puntoNuevo.x < 255.0f && puntoNuevo.y > 200.0f && puntoNuevo.y < 350.0f)
                                        {
                                            TamagochiPet *pet = [TamagochiPet sharedInstance];
                                            if ([pet canBeFed])
                                            {
                                                NSLog([NSString stringWithFormat:@"Energia antes de comida con energia %f: %f",[self.foodSelected getEnergy],[pet getEnergy]], nil);

                                                [pet eatFood:self.foodSelected];
                                                NSLog([NSString stringWithFormat:@"Energia despues de comida con energia %f: %f",[self.foodSelected getEnergy],[pet getEnergy]],nil);
                                                    [UIView animateWithDuration:0.5
                                                                          delay:0.0
                                                                        options:UIViewAnimationOptionBeginFromCurrentState
                                                                     animations:^(void)
                                                     {
                                                         self.foodImage.alpha = 0.0;
                                                         [self animateFeedingPet];
                                                         [self changeEnergyBarTo:([pet getEnergy] / 100)];
                                                     }
                                                              completion:^(BOOL finished)
                                                                        {
                                                     
                                                                        }
                                                 ];
                                            }

                                        }
                                        else
                                        {
                                            self.foodImage.alpha = 1.0;
                                        }
                                        
                                    }];
     
     }
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petName:(NSString *)aString tagSelected:(int)anInt
//Obsolete implementation (init with parameters containing pet's data)
{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        TamagochiPet *pet = [TamagochiPet sharedInstance];
        [pet configureWithTag:anInt];
        [pet setName:aString];
        self.imageTag = anInt;
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moverComida:)];
    }
    
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.imageTag = [[TamagochiPet sharedInstance] getTag];
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moverComida:)];
        
        
    }
    
    return self;
    
}


-(NSString *)getImageNameByTag:(long)tag
{
    NSString *imageName = @"";
    
    switch (tag) {
        case 0:
            imageName = @"ciervo_comiendo_1";
            break;
        case 1:
            imageName = @"gato_comiendo_1";
            break;
        case 2:
            imageName = @"jirafa_comiendo_1";
            break;
        case 3:
            imageName = @"leon_comiendo_1";
            break;
        default:
            imageName = @"";
            break;
    }
    return imageName;
    
}


-(NSArray *)getFeedingImageArrayForCurrentPet
{
    return [self getFeedingImageArrayByTag:self.imageTag];
}

-(NSArray *)getFeedingImageArrayByTag:(long)tag
{
    NSArray * arreglo;
    
    switch (tag) {
        case 0:
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ciervo_comiendo_1"],
                                                       [UIImage imageNamed:@"ciervo_comiendo_2"],
                                                       [UIImage imageNamed:@"ciervo_comiendo_3"],
                                                       [UIImage imageNamed:@"ciervo_comiendo_4"],
                                                        nil];
            break;
        case 1:
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"gato_comiendo_1"],
                                                        [UIImage imageNamed:@"gato_comiendo_2"],
                                                        [UIImage imageNamed:@"gato_comiendo_3"],
                                                        [UIImage imageNamed:@"gato_comiendo_4"],
                                                        nil];
            break;
        case 2:
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"jirafa_comiendo_1"],
                                                        [UIImage imageNamed:@"jirafa_comiendo_2"],
                                                        [UIImage imageNamed:@"jirafa_comiendo_3"],
                                                        [UIImage imageNamed:@"jirafa_comiendo_4"],
                                                        nil];
            break;
        case 3:
            arreglo = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"leon_comiendo_1"],
                                                        [UIImage imageNamed:@"leon_comiendo_2"],
                                                        [UIImage imageNamed:@"leon_comiendo_3"],
                                                        [UIImage imageNamed:@"leon_comiendo_4"],
                                                        nil];
            break;
        default:
            arreglo = [[NSArray alloc] initWithObjects:nil];
            break;
    }
    return arreglo;
    
}


//Pasa a la pantalla de seleccion de comida
- (IBAction)switchToFoodSelection:(id)sender {
    TamagochiFoodSelectionViewController *home = [[TamagochiFoodSelectionViewController alloc] initWithNibName:@"TamagochiFoodSelectionViewController" bundle:nil];
    [home setDelegate:self];
    [self.navigationController pushViewController:home animated:YES];
    
}


//Delegate: Implemento el metodo del protocolo FoodProtocol
//Se invoca cuando se ha seleccionado una comida
-(id)foodSelected:(TamagochiFood *)foodObject
{
    self.foodImage.image = [UIImage imageNamed:[foodObject getImageName]];
    [self.foodImage setAlpha:1.0];
    self.foodSelected = foodObject;
    return self;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    //CLLocation *oldLocation;
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 10.0) // Updates de menos de 10 segundos
    {
        [manager stopUpdatingLocation]; // Detener el tracking y utilizar la location theLocation = newLocation;
        NSLog(@"Coordenadas: %f, %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
        [[TamagochiPet sharedInstance] setLatitude:(float)newLocation.coordinate.latitude];
        [[TamagochiPet sharedInstance] setLongitude:(float)newLocation.coordinate.longitude];
    }
}


- (void)startUpdates
{
    NSLog(@"Starting location update");
    if (nil == locationManager)
    {
        locationManager = [[CLLocationManager alloc] init]; locationManager.delegate = self;
    }
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; //kCLLocationAccuracyKilometer; // Presición
    locationManager.distanceFilter = 10; // Distancia mínima de updates
    [locationManager startUpdatingLocation];
    NSLog(@"Location update line passed");
    
}





- (IBAction)goToRanking:(id)sender
{
    TamagochiRankingViewController* mapScreen = [[TamagochiRankingViewController alloc] initWithNibName:@"TamagochiRankingViewController" bundle:nil];
    [self.navigationController pushViewController:mapScreen animated:YES];
    
}





- (IBAction)goToMap:(id)sender
{
    TamagochiMapViewController* mapScreen = [[TamagochiMapViewController alloc] initWithNibName:@"TamagochiMapViewController" bundle:nil];
    [mapScreen displayOnePet:[TamagochiPet sharedInstance]];
    [self.navigationController pushViewController:mapScreen animated:YES];
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
