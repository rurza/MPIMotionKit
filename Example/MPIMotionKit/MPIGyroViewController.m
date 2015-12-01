//
//  MPIGyroViewController.m
//  MPIMotionKit
//
//  Created by rurza on 11/10/15.
//  Copyright © 2015 Adam Różyński. All rights reserved.
//

#import "MPIGyroViewController.h"
#import <MPIMotionKit/MPIMotionManager.h>

#define UPDATE_INTERVAL 0.2 //in seconds

@interface MPIGyroViewController ()

@property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) IBOutlet UILabel *yLabel;
@property (strong, nonatomic) IBOutlet UILabel *zLabel;
@end

@implementation MPIGyroViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[MPIMotionManager sharedManager] getGyroValuesWithTimeInterval:UPDATE_INTERVAL andHandler:^(MPIMotionData gyroscopeData) {
        self.xLabel.text = [NSString stringWithFormat:@"x = %f", gyroscopeData.x];
        self.yLabel.text = [NSString stringWithFormat:@"y = %f", gyroscopeData.y];
        self.zLabel.text = [NSString stringWithFormat:@"z = %f", gyroscopeData.z];
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
