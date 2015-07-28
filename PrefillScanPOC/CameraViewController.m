//
//  CameraViewController.m
//  PrefillScanPOC
//
//  Created by Natan Rolnik on 7/28/15.
//  Copyright © 2015 klarna. All rights reserved.
//

#import "CameraViewController.h"
#import "IPDFCameraViewController.h"

@interface CameraViewController ()

@property (weak, nonatomic) IBOutlet IPDFCameraViewController *cameraView;
@property (weak, nonatomic) IBOutlet UIImageView *focusIndicator;
@property (nonatomic, strong) NSTimer *takeAPictoTimer;

- (IBAction)focusGesture:(id)sender;

- (IBAction)captureButton:(id)sender;

@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cameraView.cameraViewType = IPDFCameraViewTypeNormal;
    [self.cameraView setupCameraView];
    [self.cameraView setEnableBorderDetection:YES];
    
    self.takeAPictoTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(captureButton:) userInfo:nil repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.cameraView start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)focusGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint location = [sender locationInView:self.cameraView];
        
        [self focusIndicatorAnimateToPoint:location];
        
        [self.cameraView focusAtPoint:location completionHandler:^ {
             [self focusIndicatorAnimateToPoint:location];
        }];
    }
}

- (void)focusIndicatorAnimateToPoint:(CGPoint)targetPoint
{
    [self.focusIndicator setCenter:targetPoint];
    self.focusIndicator.alpha = 0.0;
    self.focusIndicator.hidden = NO;
    
    [UIView animateWithDuration:0.4 animations:^ {
         self.focusIndicator.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^ {
              self.focusIndicator.alpha = 0.0;
          }];
    }];
}

- (IBAction)captureButton:(id)sender
{
    [self.cameraView captureImageWithCompletionHander:^(id data, CGFloat confidence) {
         UIImage *image = ([data isKindOfClass:[NSData class]]) ? [UIImage imageWithData:data] : data;
         
         if ([self.cameraDelegate respondsToSelector:@selector(cameraViewController:didFindImage:confidence:)]) {
             [self.cameraDelegate cameraViewController:self didFindImage:image confidence:confidence];
         }
     }];
}

@end
