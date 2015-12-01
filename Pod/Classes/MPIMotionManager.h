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

@property (nonatomic, readonly) CMDeviceMotion* deviceMotion;

/**---------------------------------------------------------------------------------------
 * @name Initalization
 *  ---------------------------------------------------------------------------------------
 */

/**
 MPIMotionManager is singleton class. Use this method to initialize it.
 @return new instance of class
 */
+(MPIMotionManager *)sharedManager;


/**
 * Get info from accelerometer
 * @param interval interval between next responses, in seconds
 * @param accelData block with MPIMotionData struct as an argument with x, y, z double datatypes from accelerometer
*/
-(void)getAccelerometerValuesWithTimeInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData accelData))handler;
/**
 * Get info from gyro
 * @param interval interval between next responses, in seconds
 * @param accelData block with MPIMotionData struct as an argument with x, y, z double datatypes from gyroscope
 */
-(void)getGyroValuesWithTimeInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData gyroscopeData))handler;
/**
 * Get info from Magnetometer (compass)
 * @param interval interval between next responses, in seconds
 * @param accelData block with MPIMotionData struct as an argument with x, y, z double datatypes from compass
 */
-(void)getMagnetometerValuesWithTimeInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData magnetoData))handler;

/**---------------------------------------------------------------------------------------
 * @name Device Motion
 *  ---------------------------------------------------------------------------------------
 */
///Device Motion encapsulates several different measurements, including altitude and more useful measurements of rotation rate and acceleration.
/**
 *@param interval interval between next responses, in seconds
 @discussion Block passes CMDeviceMotion object, which has attitude, rotationRate, gravity and user acceleration properties with processed values
 */
-(void)getDeviceMotionObjectWithInterval:(NSTimeInterval)interval andHandler:(void (^)(CMDeviceMotion *deviceMotion))handler;

-(void)getAccelerationFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData motionAccelData))handler;
-(void)getGravityAccelerationFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData motionGravityAccelData))handler;
-(void)getAttitudeFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(CMAttitude * motionAttitude))handler;
-(void)getRotationRateFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMotionData rotationRateData))handler;
-(void)getMagneticFieldFromDeviceMotionWithInterval:(NSTimeInterval)interval andHandler:(void (^)(MPIMagneticFieldData magnetoData))handler;


/**---------------------------------------------------------------------------------------
 * @name Single measurements
 *  ---------------------------------------------------------------------------------------
 */
-(void)getSingleAccelerationValues:(void (^)(MPIMotionData singleAccelData))values;
-(void)getSingleGyroValues:(void (^)(MPIMotionData singleGyroData))values;

/**---------------------------------------------------------------------------------------
 * @name Continuous measurements
 *  ---------------------------------------------------------------------------------------
 */

-(void)startDeviceMotionUpdates;

/**---------------------------------------------------------------------------------------
 * @name Stopping updates
 *  ---------------------------------------------------------------------------------------
 */

-(void)stopAccelerometerUpdates;
-(void)stopGyroUpdates;
-(void)stopMagnetometerUpdates;
-(void)stopDeviceMotionUpdates;
@end
