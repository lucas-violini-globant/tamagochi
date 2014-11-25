//
//  TamagochiStatusViewController.m
//  Tamagochi
//
//  Created by Lucas on 11/18/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiStatusViewController.h"
#import "TamagochiFoodSelectionViewController.h"
#import "TamagochiPet.h"



@interface TamagochiStatusViewController ()

@property (nonatomic,strong) NSString *petName;
@property int imageTag;

@property (strong, nonatomic) IBOutlet UIImageView *petImage;

@property (strong, nonatomic) IBOutlet UILabel *petNameLabel;

@property (strong, nonatomic) IBOutlet UIImageView *foodImage;

@property (strong, strong) NSTimer *exerciseTimer;

-(void)animateFeedingPet;

@property (strong, nonatomic) IBOutlet UIProgressView *energyBar;



@end

@implementation TamagochiStatusViewController

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

    NSString *imageName = [self getImageNameByTag:self.imageTag];
    self.petImage.image = [UIImage imageNamed:imageName];
    self.petNameLabel.text = self.petName;
    
    


    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *emailButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(sendEmail:)];
    self.navigationItem.rightBarButtonItem = emailButton;
    
}


- (IBAction)clickExercising:(id)sender
{
    if ([[TamagochiPet sharedInstance] canBeExercised])
    {
        
    }
    if ([[TamagochiPet sharedInstance] isExercising] && ![[TamagochiPet sharedInstance] canBeExercised])
    {
        //Ya estaba ejercitando, asi que lo que corresponde hacer es dejar de ejercitar, y detener el timer.
        [[TamagochiPet sharedInstance] stopExercising];
        if(self.exerciseTimer && [self.exerciseTimer isValid])
        {
            [self.exerciseTimer invalidate];
            self.exerciseTimer = nil;
        }
        [self.btnExercise setTitle:@"Stop Exercise" forState:UIControlStateNormal];
        
    }
    else
    {
        //No se esta ejercitando, entonces que empiece a ejercitar
        self.exerciseTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector: @selector(tick:) userInfo: nil repeats: YES];
        [self.btnExercise setTitle:@"Start Exercise" forState:UIControlStateNormal];
    }



}

-(void)tick:(NSTimer *)timer
{
    TamagochiPet *pet =[TamagochiPet sharedInstance];
    if ([ pet startExercising])
    {
        [self animateExercisingPet];
        self.energyBar.progress = [pet getEnergy] / 100 ;
        NSString *msg = [NSString stringWithFormat:@"Energia: %d",pet.getEnergy];
        
        NSLog(msg);
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your pet is exhausted!" delegate:self cancelButtonTitle:@"Okay"otherButtonTitles:nil];
        [alert show];
        
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
    [self.petImage setAnimationImages:[self getFeedingImageArrayForCurrentPet]];

    [self.petImage setAnimationRepeatCount:3];
    [self.petImage setAnimationDuration:0.3];
    [self.petImage startAnimating];
    
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
                                            if ([[TamagochiPet sharedInstance] startEating])
                                            {
                                                    [UIView animateWithDuration:0.5
                                                                          delay:0.0
                                                                        options:UIViewAnimationOptionBeginFromCurrentState
                                                                     animations:^(void)
                                                     {
                                                         self.foodImage.alpha = 0.0;
                                                         [self animateFeedingPet];
                                                         [self changeEnergyBarTo:1.0];
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
{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        TamagochiPet *pet = [TamagochiPet sharedInstance];
        [pet setName:aString];
        [pet setTag:anInt];
        [self setPetName:aString];
        self.imageTag = anInt;
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
    return self;
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
