# MPIMotionKit

[![CI Status](http://img.shields.io/travis/Adam Różyński/MPIMotionKit.svg?style=flat)](https://travis-ci.org/Adam Różyński/MPIMotionKit)
[![Version](https://img.shields.io/cocoapods/v/MPIMotionKit.svg?style=flat)](http://cocoapods.org/pods/MPIMotionKit)
[![License](https://img.shields.io/cocoapods/l/MPIMotionKit.svg?style=flat)](http://cocoapods.org/pods/MPIMotionKit)
[![Platform](https://img.shields.io/cocoapods/p/MPIMotionKit.svg?style=flat)](http://cocoapods.org/pods/MPIMotionKit)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MPIMotionKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MPIMotionKit"
```

##Using

###Initialize

MPIMotionManager is a singleton class.

```objective-c
[MPIMotionManager sharedManager];
```

So using it is super simple.
Take code from example:
```objective-c

[[MPIMotionManager sharedManager] getAccelerometerValuesWithTimeInterval:UPDATE_INTERVAL 
                                                              andHandler:^(MPIMotionData motionAccelData) 
{
    //do something with motionAccelData like:
    NSLog(@"%f %f %f", motionAccelData.x, motionAccelData.y, motionAccelData.z);
}];


```

## Author

Adam Różyński, adam@micropixels.pl

## License

MPIMotionKit is available under the MIT license. See the LICENSE file for more info.
