//
//  MPIViewController.m
//  MPIMotionKit
//
//  Created by Adam Różyński on 10/07/2015.
//  Copyright (c) 2015 Adam Różyński. All rights reserved.
//

#import "MPIViewController.h"
#import <MPIMotionKit/MPIMotionManager.h>

#define UPDATE_INTERVAL 0.05 //in seconds

@interface MPIViewController ()

@property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) IBOutlet UILabel *yLabel;
@property (strong, nonatomic) IBOutlet UILabel *zLabel;
@property (nonatomic) CMDeviceMotion* deviceMotion;
@end

@implementation MPIViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    __weak typeof(self) weakSelf = self;
    [[MPIMotionManager sharedManager] getDeviceMotionObjectWithInterval:0.015 andHandler:^(CMDeviceMotion *deviceMotion) {
        self.xLabel.text = [NSString stringWithFormat:@"%f", deviceMotion.userAcceleration.x];
        self.yLabel.text = [NSString stringWithFormat:@"%f", deviceMotion.userAcceleration.y];
        self.zLabel.text = [NSString stringWithFormat:@"%f", deviceMotion.userAcceleration.z];
        
        weakSelf.deviceMotion = deviceMotion;
    }];

}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
