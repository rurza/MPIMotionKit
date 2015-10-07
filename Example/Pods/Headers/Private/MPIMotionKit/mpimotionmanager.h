//
//  MPIMotionManager.h
//  Pods
//
//  Created by Adam Różyński on 04/10/15.
//
//

#import <Foundation/Foundation.h>
@import CoreMotion;

typedef struct {
    double x;
    double y;
    double z;
    double vector;
} MPIMotionData;

typedef struct {
    double x;
    double y;
    double z;
    NSInteger accuracy;
} MPIMagneticFieldData;

@interface MPIMotionManager : NSObject

/**---------------------------------------------------------------------------------------
 * @name Initalization
 *  ---------------------------------------------------------------------------------------
 */
/**
 MPIMotionManager is singleton class. Use this method to initialize it.
 @return new instance of class
 */
+(MPIMotionManager *)sharedManager;

-(void)getAccelerometerValuesWithTimeInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData accelData))handler;
-(void)getGyroValuesWithTimeInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData gyroscopeData))handler;
-(void)getMagnetometerValuesWithTimeInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData magnetoData))handler;

-(void)getDeviceMotionObjectWithInterval:(NSTimeInterval)interval andHandler:(void (^)(CMDeviceMotion *deviceMotion))handler;
-(void)getAccelerationFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData motionAccelData))handler;
-(void)getGravityAccelerationFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData motionGravityAccelData))handler;
-(void)getAttitudeFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(CMAttitude * motionAttitude))handler;
-(void)getRotationRateFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData rotationRateData))handler;
-(void)getMagneticFieldFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMagneticFieldData magnetoData))handler;

-(void)stopAccelerometerUpdates;
-(void)stopGyroUpdates;
-(void)stopMagnetometerUpdates;
-(void)stopDeviceMotionUpdates;
@end
