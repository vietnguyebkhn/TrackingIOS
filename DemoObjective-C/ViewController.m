//
//  ViewController.m
//  DemoObjective-C
//
//  Created by Nguyễn Việt on 11/3/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

#import "ViewController.h"
#import "VTAM.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _mBarButtonBouched.target = self.revealViewController;
    _mBarButtonBouched.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    [[VTracking shared] trackingEventWithEventType:VEventType.kTrackLocation params:nil];
}

@end
