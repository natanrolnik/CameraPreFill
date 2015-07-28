//
//  ViewController.m
//  PrefillScanPOC
//
//  Created by Natan Rolnik on 7/28/15.
//  Copyright © 2015 klarna. All rights reserved.
//

#import "ViewController.h"
#import "CameraViewController.h"
#import "ImageDataExtractor.h"

@interface ViewController () <CameraDelegate, ImageDataExtractorDelegate>

@property (nonatomic, strong) ImageDataExtractor *imageDataExtractor;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageDataExtractor = [[ImageDataExtractor alloc] init];
    self.imageDataExtractor.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self extractDataFromImage:[UIImage imageNamed:@"GoorDrivingLicense"]];
}

- (IBAction)scanCard:(id)sender
{
    CameraViewController *cameraViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CameraViewController class])];
    cameraViewController.cameraDelegate = self;
    [self presentViewController:cameraViewController animated:YES completion:nil];
}

- (void)cameraViewController:(CameraViewController *)cameraViewController didFindImage:(UIImage *)image confidence:(CGFloat)confidence
{
    [self.imageDataExtractor extractImage:image confidence:confidence];
}

- (void)dataExtractorDidFinishWithInfo:(NSDictionary *)dictionary
{
    NSLog(@"Info: %@", dictionary);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
