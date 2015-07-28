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
#import <QuartzCore/QuartzCore.h>

@interface ViewController () <CameraDelegate, ImageDataExtractorDelegate>

@property (nonatomic, strong) ImageDataExtractor *imageDataExtractor;
@property (weak, nonatomic) IBOutlet UITextField *txt_email;
@property (weak, nonatomic) IBOutlet UITextField *txt_title;
@property (weak, nonatomic) IBOutlet UITextField *txt_first_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_last_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_address_1;
@property (weak, nonatomic) IBOutlet UITextField *txt_address_2;
@property (weak, nonatomic) IBOutlet UITextField *txt_city;
@property (weak, nonatomic) IBOutlet UITextField *txt_zip;
@property (weak, nonatomic) IBOutlet UITextField *txt_date_of_birth;
@property (weak, nonatomic) IBOutlet UITextField *txt_phone;

@property (weak, nonatomic) IBOutlet UIView *form_view;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageDataExtractor = [[ImageDataExtractor alloc] init];
    self.imageDataExtractor.delegate = self;
    
    self.form_view.layer.borderColor = self.form_view.backgroundColor.CGColor;
    self.form_view.layer.borderWidth = 1.0;
    self.form_view.layer.cornerRadius = 8.0;
    
    [self addPaddingToTextField:self.txt_email];
    [self addPaddingToTextField:self.txt_title];
    [self addPaddingToTextField:self.txt_first_name];
    [self addPaddingToTextField:self.txt_last_name];
    [self addPaddingToTextField:self.txt_address_1];
    [self addPaddingToTextField:self.txt_address_2];
    [self addPaddingToTextField:self.txt_city];
    [self addPaddingToTextField:self.txt_zip];
    [self addPaddingToTextField:self.txt_date_of_birth];
    [self addPaddingToTextField:self.txt_phone];
}

- (void)addPaddingToTextField:(UITextField *)textField
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    textField.leftView = v;
    textField.leftViewMode = UITextFieldViewModeAlways;
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
