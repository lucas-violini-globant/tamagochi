//
//  TamagochiMapViewController.m
//  Tamagochi
//
//  Created by Lucas on 12/2/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiMapViewController.h"
#import "TamagochiPet.h"
#import <MapKit/MapKit.h>
#import "TamagochiMKMapAnnotation.h"


@interface TamagochiMapViewController ()

@property CLLocationDegrees centerLat;
@property CLLocationDegrees centerLon;


@property (strong, nonatomic) IBOutlet MKMapView *map;
@end

@implementation TamagochiMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.map setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.centerLat =(CLLocationDegrees)34.1868949f;
        self.centerLon = (CLLocationDegrees)-118.601775f;
    }
    
    return self;
    
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
MKCoordinateRegion region;
//region.center = [mapView userLocation].location.coordinate;
    

    
region.center.latitude = self.centerLat;
region.center.longitude = self.centerLon;
region.span.latitudeDelta = 0.02;
region.span.longitudeDelta = 0.02;
[mapView setRegion:region animated:YES];
    
}

-(void)displayOnePet:(TamagochiPet *)aPet
{
    self.centerLat = (CLLocationDegrees)[aPet getLatitude];
    self.centerLon = (CLLocationDegrees)[aPet getLongitude];
    
    TamagochiMKMapAnnotation *ann = [[TamagochiMKMapAnnotation alloc] initWithPet:aPet];
    //La siguiente linea no hace falta, porque initWithPet setea las coordenadas a partir del pet....
    [ann setCoordinate: CLLocationCoordinate2DMake(self.centerLat, self.centerLon)];
     
    [self.map addAnnotation:ann];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (![annotation isKindOfClass:[TamagochiMKMapAnnotation class]]) return nil;
    static NSString *dqref = @"TamagochiMKMapAnnotation";
    MKAnnotationView *av = [self.map dequeueReusableAnnotationViewWithIdentifier:dqref ];
    if (nil == av)
    {
        av = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:dqref];
    }
    
    TamagochiPet *myPet = [TamagochiPet sharedInstance];
    UIImage *img = [UIImage imageNamed:[myPet getImage]];
    [av setImage: img];
    //[av setPinColor:MKPinAnnotationColorPurple ];
    //[av setAnimatesDrop:YES];
    [av setCanShowCallout:YES];

    return av;
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
