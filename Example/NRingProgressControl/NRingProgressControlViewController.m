//
//  NRingProgressControlViewController.m
//  NRingProgressControl
//
//  Created by nunadly on 03/06/2017.
//  Copyright (c) 2017 nunadly. All rights reserved.
//

#import "NRingProgressControlViewController.h"
#import "NRingProgressControl.h"

@interface NRingProgressControlViewController ()
@property (weak, nonatomic) IBOutlet NRingProgressControl *NRPCtrl;

@end

@implementation NRingProgressControlViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _NRPCtrl.progress = .65f;
}

- (IBAction)runProgress:(id)sender {
    [_NRPCtrl animateProgress:_NRPCtrl.progress];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
