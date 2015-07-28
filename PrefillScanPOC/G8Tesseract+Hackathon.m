//
//  G8Tesseract+Hackathon.m
//  PrefillScanPOC
//
//  Created by Natan Rolnik on 7/28/15.
//  Copyright © 2015 klarna. All rights reserved.
//

#import "G8Tesseract+Hackathon.h"
#import <objc/runtime.h>

static char const * const ImageConfidenceKey = "ImageConfidenceKey";

@implementation G8Tesseract (Hackathon)
@dynamic confidence;

- (void)setImageConfidence:(CGFloat)confidence
{
    objc_setAssociatedObject(self, ImageConfidenceKey, @(confidence), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)imageConfidence
{
    return [objc_getAssociatedObject(self, ImageConfidenceKey) floatValue];
}

@end
