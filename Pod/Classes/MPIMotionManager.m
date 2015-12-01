//
//  MPIMotionManager.m
//  Pods
//
//  Created by Adam Różyński on 04/10/15.
//
//

#import "MPIMotionManager.h"

@interface MPIMotionManager ()
@property (nonatomic, strong) CMMotionManager *p_motionManager;


@end

@implementation MPIMotionManager

+(MPIMotionManager *)sharedManager
{
    static MPIMotionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init NS_UNAVAILABLE
{
    self = [super init];
    if (self) {
        self.p_motionManager = [[CMMotionManager alloc] init];
    }
    return self;
}

-(void)getAccelerometerValuesWithTimeInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData accelData))handler
{
    __block MPIMotionData data;
    if (self.p_motionManager.accelerometerAvailable) {
        self.p_motionManager.accelerometerUpdateInterval = interval;
        [self.p_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            if (error) {
                NSLog(@"CoreMotion motionManager accelerometer error. %@", [error localizedDescription]);
            }
            else {
                data.x = accelerometerData.acceleration.x;
                data.y = accelerometerData.acceleration.y;
                data.z = accelerometerData.acceleration.z;
                data.vector = [self vectorForData:data];
                if (handler) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        handler(data);
                    }];
                }
            }
        }];
    }
    else {
        NSLog(@"Accelerometer isn't available");
    }
}

-(void)getGyroValuesWithTimeInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData gyroscopeData))handler
{
    __block MPIMotionData data;
    if (self.p_motionManager.gyroAvailable) {
        self.p_motionManager.gyroUpdateInterval = interval;
        [self.p_motionManager startGyroUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            if (error) {
                NSLog(@"CoreMotion motionManager gyro error. %@", [error localizedDescription]);
            }
            else {
                data.x = gyroData.rotationRate.x;
                data.y = gyroData.rotationRate.y;
                data.z = gyroData.rotationRate.z;
                data.vector = [self vectorForData:data];
                if (handler) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        handler(data);
                    }];
                }
            }
        }];
    }
    else {
        NSLog(@"Gyroscope isn't available");
    }
}
-(void)getMagnetometerValuesWithTimeInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData magnetoData))handler
{
    __block MPIMotionData data;
    if (self.p_motionManager.magnetometerAvailable) {
        [self.p_motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
            if (error) {
                NSLog(@"CoreMotion motionManager magneto error. %@", [error localizedDescription]);
            }
            else {
                data.x = magnetometerData.magneticField.x;
                data.y = magnetometerData.magneticField.y;
                data.z = magnetometerData.magneticField.z;
                data.vector = [self vectorForData:data];
                if (handler) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        handler(data);
                    }];
                }

            }
        }];
    }
    else {
        NSLog(@"Magnetometer isn't available");
    }
}

-(void)getDeviceMotionObjectWithInterval:(NSTimeInterval)interval andHandler:(void (^)(CMDeviceMotion *deviceMotion))handler
{
    if (self.p_motionManager.deviceMotionAvailable) {
        [self.p_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (error) {
                NSLog(@"CoreMotion motionManager deviceMotion error. %@", [error localizedDescription]);
            }
            else {
                if (handler) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        handler(motion);
                    }];
                }
            }
        }];
    }
    else {
        NSLog(@"DeviceMotion isn't available");
    }
}

#pragma mark - Device Motion

-(void)getAccelerationFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData motionAccelData))handler
{
    __block MPIMotionData data;
    if (self.p_motionManager.deviceMotionAvailable) {
        self.p_motionManager.deviceMotionUpdateInterval = interval;
        [self.p_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (error) {
                NSLog(@"CoreMotion motionManager deviceMotion acceleration error. %@", [error localizedDescription]);
            }
            else {
                data.x = motion.userAcceleration.x;
                data.y = motion.userAcceleration.y;
                data.z = motion.userAcceleration.z;
                data.vector = [self vectorForData:data];
                if (handler) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        handler(data);
                    }];
                }
            }
        }];
    }
    else {
        NSLog(@"DeviceMotion isn't available");
    }
}
-(void)getGravityAccelerationFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData motionGravityAccelData))handler
{
    __block MPIMotionData data;
    if (self.p_motionManager.deviceMotionAvailable) {
        self.p_motionManager.deviceMotionUpdateInterval = interval;
        [self.p_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (error) {
                NSLog(@"CoreMotion motionManager deviceMotion gravity acceleration error ;) %@", [error localizedDescription]);
            }
            else {
                data.x = motion.gravity.x;
                data.y = motion.gravity.y;
                data.z = motion.gravity.z;
                data.vector = [self vectorForData:data];
                if (handler) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        handler(data);
                    }];
                }
            }
        }];
    }
    else {
        NSLog(@"DeviceMotion isn't available");
    }
}
-(void)getAttitudeFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(CMAttitude * motionAttitude))handler
{
    if (self.p_motionManager.deviceMotionAvailable) {
        self.p_motionManager.deviceMotionUpdateInterval = interval;
        [self.p_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (error) {
                NSLog(@"CoreMotion motionManager deviceMotion error. %@", [error localizedDescription]);
            }
            else {
                if (handler) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        handler(motion.attitude);
                    }];
                }
            }
        }];
    }
    else {
        NSLog(@"DeviceMotion isn't available");
    }
}

-(void)getRotationRateFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData rotationRateData))handler
{
    __block MPIMotionData data;
    if (self.p_motionManager.deviceMotionAvailable) {
        self.p_motionManager.deviceMotionUpdateInterval = interval;
        [self.p_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (error) {
                NSLog(@"CoreMotion motionManager deviceMotion rotation rate error ;) %@", [error localizedDescription]);
            }
            else {
                data.x = motion.rotationRate.x;
                data.y = motion.rotationRate.y;
                data.z = motion.rotationRate.z;
                data.vector = [self vectorForData:data];
                if (handler) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        handler(data);
                    }];
                }
            }
        }];
    }
    else {
        NSLog(@"DeviceMotion isn't available");
    }
}

-(void)getMagneticFieldFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMagneticFieldData magnetoData))handler
{
    __block MPIMagneticFieldData data;
    if (self.p_motionManager.deviceMotionAvailable) {
        self.p_motionManager.deviceMotionUpdateInterval = interval;
        [self.p_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (error) {
                NSLog(@"CoreMotion motionManager deviceMotion magnetic field error ;) %@", [error localizedDescription]);
            }
            else {
                data.x = motion.magneticField.field.x;
                data.y = motion.magneticField.field.y;
                data.z = motion.magneticField.field.z;
                data.accuracy = motion.magneticField.accuracy;
                if (handler) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        handler(data);
                    }];
                }
            }
        }];
    }
    else {
        NSLog(@"DeviceMotion isn't available");
    }
}

-(void)startDeviceMotionUpdates
{
    [self.p_motionManager startDeviceMotionUpdates];
}

#pragma mark - Stop updates

-(void)stopAccelerometerUpdates
{
    [self.p_motionManager stopAccelerometerUpdates];
}
-(void)stopGyroUpdates
{
    [self.p_motionManager stopGyroUpdates];
}
-(void)stopMagnetometerUpdates
{
    [self.p_motionManager stopMagnetometerUpdates];
}
-(void)stopDeviceMotionUpdates
{
    [self.p_motionManager stopDeviceMotionUpdates];
}

-(void)getSingleAccelerationValues:(void (^)(MPIMotionData singleAccelData))values
{
    [self getAccelerometerValuesWithTimeInterval:0.2 andHandler:^(MPIMotionData accelData) {
        values(accelData);
    }];
    [self stopAccelerometerUpdates];
}
-(void)getSingleGyroValues:(void (^)(MPIMotionData singleGyroData))values
{
    [self getGyroValuesWithTimeInterval:0.2 andHandler:^(MPIMotionData gyroscopeData) {
        values(gyroscopeData);
    }];
    [self stopGyroUpdates];
}

#pragma mark - Helper methods
-(double)vectorForData:(MPIMotionData)data
{
    return sqrt(data.x * data.x + data.y * data.y + data.z * data.z);
}

-(CMDeviceMotion *)deviceMotion
{
    return self.p_motionManager.deviceMotion;
}

@end
