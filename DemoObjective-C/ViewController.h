//
//  ViewController.h
//  DemoObjective-C
//
//  Created by Nguyễn Việt on 11/3/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *mBarButtonBouched;
@property (weak, nonatomic) IBOutlet UIButton *mCheckLocation;
@property(nonatomic, nonnull) CLLocation *locationManager;

@end

