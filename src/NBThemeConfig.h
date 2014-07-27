//
//  NBThemeConfig.h
//
//  Created by Josh Justice on 1/5/13.
//  (c) 2013 NeedBee, LLC. All right reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface NBThemeConfig : NSObject

+(UIColor *)colorForComponent:(NSString *)componentName;
+(CGColorRef)cgColorForComponent:(NSString *)componentName;

+(void)setGradient:(CAGradientLayer *)gradient byComponentName:(NSString *)componentName;

+(UIFont *)fontForComponent:(NSString *)componentName;

@end
