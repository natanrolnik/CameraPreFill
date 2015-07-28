//
//  CameraViewController.h
//  PrefillScanPOC
//
//  Created by Natan Rolnik on 7/28/15.
//  Copyright © 2015 klarna. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraViewController;

@protocol CameraDelegate <NSObject>

- (void)cameraViewController:(CameraViewController *)cameraViewController didFindImage:(UIImage *)image confidence:(CGFloat)confidence;

@end

@interface CameraViewController : UIViewController

@property (nonatomic, weak) id<CameraDelegate> cameraDelegate;

@end
