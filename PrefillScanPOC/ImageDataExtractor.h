//
//  ImageDataExtractor.h
//  PrefillScanPOC
//
//  Created by Natan Rolnik on 7/28/15.
//  Copyright © 2015 klarna. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const ImageDataExtractorID = @"ImageDataExtractorID";

@protocol ImageDataExtractorDelegate <NSObject>

- (void)dataExtractorDidFinishWithInfo:(NSDictionary *)dictionary;

@end

@interface ImageDataExtractor : NSObject

- (void)extractImage:(UIImage *)image confidence:(CGFloat)confidence;

@property (nonatomic, weak) id<ImageDataExtractorDelegate> delegate;

@end
