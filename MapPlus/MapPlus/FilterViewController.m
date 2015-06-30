//
//  FilterViewController.m
//  MapPlus
//
//  Created by Fletcher Woodruff on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import "FilterViewController.h"
#import "MapViewController.h"

@interface FilterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *yearButton;
@property (weak, nonatomic) IBOutlet UIButton *monthButton;
@property (weak, nonatomic) IBOutlet UIButton *dayButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@property (weak, nonatomic) IBOutlet UIButton *angryButton;
@property (weak, nonatomic) IBOutlet UIButton *energeticButton;
@property (weak, nonatomic) IBOutlet UIButton *happyButton;
@property (weak, nonatomic) IBOutlet UIButton *jealousButton;
@property (weak, nonatomic) IBOutlet UIButton *sadButton;
@property (weak, nonatomic) IBOutlet UIButton *optimisticButton;

@property (weak, nonatomic) MapViewController *mvc;

@property (strong, nonatomic) NSString *dateFilter;
@property (strong, nonatomic) NSMutableSet *emotionFilter;

- (instancetype)initWithMVC:(MapViewController *)mvc;
@end

@implementation FilterViewController

- (instancetype)initWithMVC:(MapViewController *)mvc
{
    self = [super init];
    
    if (self) {
        _mvc = mvc;
        
        self.dateFilter = self.mvc.dateFilter;
        self.emotionFilter = [self.mvc.emotionFilter mutableCopy];
        
        
        self.navigationItem.title = @"Filter Pins";
        
        UIBarButtonItem *cancelItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                      target:self
                                                      action:@selector(cancelButtonPressed:)];
        
        self.navigationItem.leftBarButtonItem = cancelItem;
        
        UIBarButtonItem *doneItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Apply"
                                         style:UIBarButtonItemStyleDone
                                        target:self
                                        action:@selector(applyButtonPressed:)];
        
        self.navigationItem.rightBarButtonItem = doneItem;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self highlightSelectedButtons];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)highlightSelectedButtons
{
    UIColor *selectedColor = [UIColor blueColor];
    UIColor *deselectedColor = [UIColor grayColor];
    
    if ([self.dateFilter isEqualToString:@"year"]) {
        [self.yearButton setTitleColor:selectedColor
                              forState:UIControlStateNormal];
    } else {
        [self.yearButton setTitleColor:deselectedColor
                              forState:UIControlStateNormal];
    }
    
    if ([self.dateFilter isEqualToString:@"month"]) {
        [self.monthButton setTitleColor:selectedColor
                              forState:UIControlStateNormal];
    } else {
        [self.monthButton setTitleColor:deselectedColor
                              forState:UIControlStateNormal];
    }
    
    if ([self.dateFilter isEqualToString:@"day"]) {
        [self.dayButton setTitleColor:selectedColor
                              forState:UIControlStateNormal];
    } else {
        [self.dayButton setTitleColor:deselectedColor
                              forState:UIControlStateNormal];
    }
    
    
    NSArray *buttons = @[self.angryButton,
                         self.energeticButton,
                         self.happyButton,
                         self.jealousButton,
                         self.sadButton,
                         self.optimisticButton];
    
    for (UIButton *button in buttons) {
        if ([self.emotionFilter containsObject:button.currentTitle]) {
            [button setTitleColor:selectedColor
                         forState:UIControlStateNormal];
        } else {
            [button setTitleColor:deselectedColor
                         forState:UIControlStateNormal];
        }
    }
    
}

- (IBAction)dateFilterButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([button.currentTitle isEqualToString:@"Last Year"]) {
        self.dateFilter = @"year";
    }
    
    if ([button.currentTitle isEqualToString:@"Last Month"]) {
        self.dateFilter = @"month";
    }
    
    if ([button.currentTitle isEqualToString:@"Last Day"]) {
        self.dateFilter = @"day";
    }
    
    if ([button.currentTitle isEqualToString:@"Clear Filter"]) {
        self.dateFilter = @"";
    }
    
    [self highlightSelectedButtons];
}

- (IBAction)emotionFilterButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if ([self.emotionFilter containsObject:button.currentTitle]) {
        [self.emotionFilter removeObject:button.currentTitle];
    } else {
        [self.emotionFilter addObject:button.currentTitle];
    }
    
    [self highlightSelectedButtons];
}

- (void)applyButtonPressed:(id)sender
{
    self.mvc.dateFilter = self.dateFilter;
    self.mvc.emotionFilter = self.emotionFilter;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
