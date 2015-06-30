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

@property (nonatomic) CLLocationCoordinate2D location;

@end

@implementation CreatePinViewController

- (instancetype)initWithLocation:(CLLocationCoordinate2D)location {
    self = [super init];
    if (self) {
        _location = location;
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                    target:self
                                                                                    action:@selector(cancelButtonPressed:)];
        self.navigationItem.leftBarButtonItem = cancelItem;
        
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(doneButtonPressed:)];
        
        self.navigationItem.rightBarButtonItem = doneItem;
        
        self.navigationItem.title = @"Drop a New Pin";
        
        self.text.text = @"How are you feeling?";
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

- (IBAction)addPin:(id)sender {
    NSDate *date = [[NSDate alloc] init];
    UIButton *button = (UIButton *)sender;
    UIColor *color;
    if (button.tag == 0) {
        color = [UIColor redColor];
    } else if (button.tag == 1) {
        color = [UIColor orangeColor];
    } else if (button.tag == 2) {
        color = [UIColor yellowColor];
    } else if (button.tag == 3) {
        color = [UIColor greenColor];
    } else if (button.tag == 4) {
        color = [UIColor blueColor];
    } else if (button.tag == 5) {
        color = [UIColor purpleColor];
    }
    self.pin = [[Pin alloc] initWithUser:0000000 date:date location:self.location color:color];
    
}


- (void)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneButtonPressed:(id)sender {
    if (self.saveBlock) {
        self.pin.text = self.text.text;
        self.saveBlock(self.pin);
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
