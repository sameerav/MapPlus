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
    NSDictionary *dict = @{
                           @"Angry": [UIColor redColor],
                           @"Energetic": [UIColor orangeColor],
                           @"Sad": [UIColor blueColor],
                           @"Happy": [UIColor yellowColor],
                           @"Jealous": [UIColor greenColor],
                           @"Optimistic": [UIColor purpleColor]
                           };
    NSDictionary *otherdict = @{
                           @"Angry": self.angryButton,
                           @"Energetic": self.energeticButton,
                           @"Sad": self.sadButton,
                           @"Happy": self.happyButton,
                           @"Jealous": self.jealousButton,
                           @"Optimistic": self.optimisticButton
                           };
    for (NSString *emotion in self.emotionFilter) {
        UIButton *button = otherdict[emotion];
        [button setBackgroundColor:dict[emotion]];
    }
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)filterByDate:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *currentText = button.currentTitle;
    if ([currentText isEqualToString:@"No filter"]) {
        [button setTitle:@"Last year" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor greenColor];
        self.dateFilter = @"year";
    } else if ([currentText isEqualToString:@"Last year"]) {
        [button setTitle:@"Last month" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor blueColor];
        self.dateFilter = @"month";
    } else if ([currentText isEqualToString:@"Last month"]) {
        [button setTitle:@"Last day" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor purpleColor];
        self.dateFilter = @"day";
    } else if ([currentText isEqualToString:@"Last day"]) {
        [button setTitle:@"No filter" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor lightGrayColor];
        self.dateFilter = @"";
    }
}

- (IBAction)emotionFilterButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if ([self.emotionFilter containsObject:button.currentTitle]) {
        [self.emotionFilter removeObject:button.currentTitle];
        
        [button setBackgroundColor:[UIColor lightGrayColor]];
        
    } else {
        [self.emotionFilter addObject:button.currentTitle];
        NSDictionary *dict = @{
                               @"Angry": [UIColor redColor],
                               @"Energetic": [UIColor orangeColor],
                               @"Sad": [UIColor blueColor],
                               @"Happy": [UIColor yellowColor],
                               @"Jealous": [UIColor greenColor],
                               @"Optimistic": [UIColor purpleColor]
                               };
        UIColor *color = dict[button.currentTitle];
        [button setBackgroundColor:color];
    }
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
