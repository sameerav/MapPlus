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

@property (assign, nonatomic) CLLocationCoordinate2D location;
@property (assign, nonatomic) BOOL tag;
@property (strong, nonatomic) Pin *pin;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation CreatePinViewController

- (instancetype)initWithLocation:(CLLocationCoordinate2D)location {
    self = [super init];
    
    if (self) {
        
        NSDate *date = [[NSDate alloc] init];
        _pin = [[Pin alloc] initWithUser:0 date:date location:location];
        _location = location;
        
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                    target:self
                                                                                    action:@selector(cancelButtonPressed:)];
        self.navigationItem.leftBarButtonItem = cancelButton;
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(doneButtonPressed:)];
        
        self.navigationItem.rightBarButtonItem = doneButton;
        
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

- (IBAction)addPinButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSDictionary *buttonMapping = @{@"Red - Angry"         : @"Angry",
                                    @"Orange - Energetic"  : @"Energetic",
                                    @"Yellow - Happy"      : @"Happy",
                                    @"Green - Jealous"     : @"Jealous",
                                    @"Blue - Sad"          : @"Sad",
                                    @"Purple - Optimistic" : @"Optimistic"};
    
    self.pin.color = button.backgroundColor;
    self.pin.colorString = buttonMapping[button.currentTitle];
    self.pin.text = self.textField.text;
    
    [self dismissViewAndSave];
}

- (void)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneButtonPressed:(id)sender {
    [self dismissViewAndSave];
}

- (void)dismissViewAndSave
{
    if (self.saveBlock) {
        self.pin.text = self.textField.text;
        self.saveBlock(self.pin);
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
