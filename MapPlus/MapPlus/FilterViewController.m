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
@end

@implementation FilterViewController

- (IBAction)setTimeFilter:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    if (tag == 0) {
        self.mvc.timeFilter = @"day";
    } else if (tag == 1) {
        self.mvc.timeFilter = @"month";
    } else if (tag == 2) {
        self.mvc.timeFilter = @"year";
    }
}

- (IBAction)clearTimeFilters:(id)sender {
    self.mvc.timeFilter = nil;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.navigationItem.title = @"Filter Pins";
        
        UIBarButtonItem *cancelItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                      target:self
                                                      action:@selector(cancel:)];
        
        self.navigationItem.leftBarButtonItem = cancelItem;
        
        UIBarButtonItem *doneItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Apply"
                                         style:UIBarButtonItemStyleDone
                                        target:self
                                        action:@selector(save:)];
        
        self.navigationItem.rightBarButtonItem = doneItem;
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

- (void)save:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{

}


@end
