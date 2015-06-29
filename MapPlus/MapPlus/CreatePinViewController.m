//
//  CreatePinViewController.m
//  MapPlus
//
//  Created by Kathleen Feng on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import "CreatePinViewController.h"
#import "Pin.h"
#import "ParseAPI.h"

@interface CreatePinViewController ()

@property CLLocationCoordinate2D location;

- (Pin *)createPin;

@end

@implementation CreatePinViewController

- (instancetype)initWithLocation:(CLLocationCoordinate2D)location {
    self = [super init];
    if (self) {
        _location = location;
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                    target:self
                                                                                    action:@selector(cancel:)];
        self.navigationItem.leftBarButtonItem = cancelItem;
        self.navigationItem.title = @"Drop a New Pin";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addRedPin:(id)sender {
    Pin *pin = self.createPin;
    pin.color = [UIColor redColor];
    //[ParseAPI savePin:pin];
    self.color = pin.color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addOrangePin:(id)sender {
    Pin *pin = self.createPin;
    pin.color = [UIColor orangeColor];
    //[ParseAPI savePin:pin];
    self.color = pin.color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addYellowPin:(id)sender {
    Pin *pin = self.createPin;
    pin.color = [UIColor yellowColor];
    //[ParseAPI savePin:pin];
    self.color = pin.color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addGreenPin:(id)sender {
    Pin *pin = self.createPin;
    pin.color = [UIColor greenColor];
    //[ParseAPI savePin:pin];
    self.color = pin.color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addBluePin:(id)sender {
    Pin *pin = self.createPin;
    pin.color = [UIColor blueColor];
    //[ParseAPI savePin:pin];
    self.color = pin.color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addPurplePin:(id)sender {
    Pin *pin = self.createPin;
    pin.color = [UIColor purpleColor];
    //[ParseAPI savePin:pin];
    self.color = pin.color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (Pin *)createPin {
    NSDate *date = [[NSDate alloc] init];
    Pin *pin = [[Pin alloc] initWithUser:000000 date:date location:self.location];
    return pin;
}

@end
