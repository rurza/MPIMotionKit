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
@property (strong, nonatomic) IBOutlet UILabel *maxXLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxYLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxZLabel;

@property (strong, nonatomic) IBOutlet UILabel *minXLabel;
@property (strong, nonatomic) IBOutlet UILabel *minYLabel;
@property (strong, nonatomic) IBOutlet UILabel *minZLabel;


@property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) IBOutlet UILabel *yLabel;
@property (strong, nonatomic) IBOutlet UILabel *zLabel;
@end

@implementation MPIViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __block double minX, minY, minZ;
    __block double maxX = 0, maxY = 0, maxZ = 0;

    [[MPIMotionManager sharedManager] getAccelerometerValuesWithTimeInterval:UPDATE_INTERVAL andHandler:^(MPIMotionData motionAccelData) {
        self.xLabel.text = [NSString stringWithFormat:@"x = %f", motionAccelData.x];
        self.yLabel.text = [NSString stringWithFormat:@"y = %f", motionAccelData.y];
        self.zLabel.text = [NSString stringWithFormat:@"z = %f", motionAccelData.z];
        //MIN value
        if (minX>motionAccelData.x) {
            self.minXLabel.text = [NSString stringWithFormat:@"%f", motionAccelData.x];
            minX = motionAccelData.x;
        }
        if (minY>motionAccelData.y) {
            self.minYLabel.text = [NSString stringWithFormat:@"%f", motionAccelData.y];
            minY = motionAccelData.y;
        }
        if (minZ>motionAccelData.z) {
            self.minZLabel.text = [NSString stringWithFormat:@"%f", motionAccelData.z];
            minZ = motionAccelData.z;
        }
        //MAX value
        if (maxX<motionAccelData.x) {
            self.maxXLabel.text = [NSString stringWithFormat:@"%f", motionAccelData.x];
            maxX = motionAccelData.x;
        }
        if (maxY<motionAccelData.y) {
            self.maxYLabel.text = [NSString stringWithFormat:@"%f", motionAccelData.y];
            maxY = motionAccelData.y;
        }
        if (maxZ<motionAccelData.z) {
            self.maxZLabel.text = [NSString stringWithFormat:@"%f", motionAccelData.z];
            maxZ = motionAccelData.z;
        }
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
