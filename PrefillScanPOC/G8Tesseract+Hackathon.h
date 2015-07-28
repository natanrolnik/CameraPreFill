//
//  G8Tesseract+Hackathon.h
//  PrefillScanPOC
//
//  Created by Natan Rolnik on 7/28/15.
//  Copyright © 2015 klarna. All rights reserved.
//

#import "G8Tesseract.h"

@interface G8Tesseract (Hackathon)

@property (nonatomic, retain) id confidence;

- (void)setImageConfidence:(CGFloat)confidence;

- (CGFloat)imageConfidence;

@end
