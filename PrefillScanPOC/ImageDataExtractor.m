//
//  ImageDataExtractor.m
//  PrefillScanPOC
//
//  Created by Natan Rolnik on 7/28/15.
//  Copyright © 2015 klarna. All rights reserved.
//

#import "ImageDataExtractor.h"
#import <TesseractOCR/TesseractOCR.h>
#import "G8Tesseract+Hackathon.h"

@interface ImageDataExtractor () <G8TesseractDelegate>

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, assign) CGFloat highestConfidence;
@property (nonatomic, assign) BOOL foundEnoughInfo;

@end

@implementation ImageDataExtractor

- (instancetype)init
{
    self = [super init];
    
    self.foundEnoughInfo = NO;
    self.highestConfidence = 0;
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 4;
    
    return self;
}

- (void)extractImage:(UIImage *)image confidence:(CGFloat)confidence
{
    if (self.highestConfidence < confidence + 10 && confidence < 10) {
        NSLog(@"Received image with lower confidence, won't perform OCR.");
        
        return;
    }
    
    if (confidence > self.highestConfidence) {
        self.highestConfidence = confidence;
    }
    
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"eng"];

    [operation.tesseract setImageConfidence:confidence];
    
    operation.tesseract.image = [image g8_blackAndWhite];
    operation.tesseract.maximumRecognitionTime = 10.0;
    operation.tesseract.delegate = self;
    
    operation.recognitionCompleteBlock = ^(G8Tesseract *recognizedTesseract) {
        // Retrieve the recognized text upon completion
        [self searchForInfoInCard:[recognizedTesseract recognizedText]];
    };
    
    [self.operationQueue addOperation:operation];
}

- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract
{
    if (tesseract.progress == 0) {
        NSLog(@"Starting OCR for Confidence %@", @([tesseract imageConfidence]));
    }
    else if (tesseract.progress % 20 == 0) {
        NSLog(@"Progress %@", @(tesseract.progress));
    }
    else if (tesseract.progress == 99) {
        NSLog(@"Finishing");
    }
}

- (void)searchForInfoInCard:(NSString *)recognizedText
{
//    self.foundEnoughInfo = YES;
    
    NSLog(@"%@", recognizedText);
    
    //1
    //2
    //3
    //5
    //8
}

- (void)foundEnoughInformation:(NSDictionary *)info
{
    [self.operationQueue cancelAllOperations];

    if ([self.delegate respondsToSelector:@selector(dataExtractorDidFinishWithInfo:)]) {
        [self.delegate dataExtractorDidFinishWithInfo:info];
    }
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract
{
    if (self.foundEnoughInfo) {
        NSLog(@"Already found enough info, canceling tesseract");
        
        return YES;
    }
    
    if (self.highestConfidence > [tesseract imageConfidence] + 10) {
        NSLog(@"Found an image with higher confidence, canceling tesseract");
        
        return YES;
    }
    
    return NO;
}

@end
