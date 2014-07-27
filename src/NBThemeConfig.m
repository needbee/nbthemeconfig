//
//  NBThemeConfig.m
//
//  Created by Josh Justice on 1/5/13.
//  (c) 2013 NeedBee, LLC. All right reserved.
//

#import "NBThemeConfig.h"

#define COMPONENTS_KEY @"components"
#define COMPONENT_FONTS_KEY @"componentFonts"
#define NAMED_COLORS_KEY @"namedColors"
#define NAMED_GRADIENTS_KEY @"namedGradients"
#define NAMED_PATTERNS_KEY @"namedPatterns"
#define NAMED_FONTS_KEY @"namedFonts"
#define GRADIENT_COLORS_KEY @"colors"
#define GRADIENT_LOCATIONS_KEY @"locations"
#define RED_KEY 0
#define GREEN_KEY 1
#define BLUE_KEY 2
#define ALPHA_KEY 3
#define FONT_NAME_KEY @"name"
#define FONT_SIZE_KEY @"size"

@interface NBThemeConfig ()

+(void)setUpStatics;
+(UIColor *)colorNamed:(NSString *)colorName;
+(UIColor *)patternNamed:(NSString *)patternName;
+(UIFont *)fontNamed:(NSString *)fontName;

@end

@implementation NBThemeConfig

static NSDictionary *config = nil;
static NSMutableDictionary *cachedColors = nil;
static NSMutableDictionary *cachedGradientColors = nil;
static NSMutableDictionary *cachedPatternColors = nil;
static NSMutableDictionary *cachedFonts = nil;

+(void)setUpStatics {
    if( nil == config ) {
        config = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"]];
    }
    if( nil == cachedColors ) {
        cachedColors = [[NSMutableDictionary alloc] init];
    }
    if( nil == cachedGradientColors ) {
        cachedGradientColors = [[NSMutableDictionary alloc] init];
    }
    if( nil == cachedPatternColors ) {
        cachedPatternColors = [[NSMutableDictionary alloc] init];
    }
    if( nil == cachedFonts ) {
        cachedFonts = [[NSMutableDictionary alloc] init];
    }
}

+(UIColor *)colorNamed:(NSString *)colorName {
    UIColor *color = nil;
    if( !( color = [cachedColors objectForKey:colorName] ) ) {
        NSArray *colorArray = [[config objectForKey:NAMED_COLORS_KEY] objectForKey:colorName];
        if( nil != colorArray ) {
            color = [UIColor colorWithRed:[[colorArray objectAtIndex:RED_KEY] floatValue]
                                    green:[[colorArray objectAtIndex:GREEN_KEY] floatValue]
                                     blue:[[colorArray objectAtIndex:BLUE_KEY] floatValue]
                                    alpha:[[colorArray objectAtIndex:ALPHA_KEY] floatValue]];
            [cachedColors setObject:color forKey:colorName];
        }
    }
    return color;
}

+(UIColor *)patternNamed:(NSString *)patternName {
    UIColor *color;
    if( !( color = [cachedPatternColors objectForKey:patternName] ) ) {
        NSString *fileName = [[config objectForKey:NAMED_PATTERNS_KEY] objectForKey:patternName];
        color = [UIColor colorWithPatternImage:[UIImage imageNamed:fileName]];
        [cachedPatternColors setObject:color forKey:patternName];
    }
    return color;
}

+(UIFont *)fontNamed:(NSString *)fontName {
    UIFont *font;
    if( !(font = [cachedFonts objectForKey:fontName] ) ) {
        NSDictionary *fontDict = [[config objectForKey:NAMED_FONTS_KEY] objectForKey:fontName];
        font = [UIFont fontWithName:[fontDict objectForKey:FONT_NAME_KEY]
                               size:[[fontDict objectForKey:FONT_SIZE_KEY] intValue]];
        [cachedFonts setObject:font forKey:fontName];
    }
    return font;
}

+(UIColor *)colorForComponent:(NSString *)componentName {
    
    [NBThemeConfig setUpStatics];
    
    UIColor *color;
    
    NSString *colorName = [[config objectForKey:COMPONENTS_KEY] objectForKey:componentName];
    color =  [NBThemeConfig colorNamed:colorName];
    
    if( nil == color ) {
        color = [NBThemeConfig patternNamed:colorName];
    }
    
    return color;
}

+(CGColorRef)cgColorForComponent:(NSString *)componentName {
    return [[NBThemeConfig colorForComponent:componentName] CGColor];
}

+(void)setGradient:(CAGradientLayer *)gradient byComponentName:(NSString *)componentName {
    [NBThemeConfig setUpStatics];
    
    NSString *gradientName = [[config objectForKey:COMPONENTS_KEY] objectForKey:componentName];
    NSDictionary *gradientConfig = [[config objectForKey:NAMED_GRADIENTS_KEY] objectForKey:gradientName];
    NSArray *colorsConfig = [gradientConfig objectForKey:GRADIENT_COLORS_KEY];
    NSArray *locations = [gradientConfig objectForKey:GRADIENT_LOCATIONS_KEY];
    
    NSMutableArray *colors;
    if( !( colors = [cachedGradientColors objectForKey:gradientName] ) ) {
        int capacity = [colorsConfig count];
        colors = [[NSMutableArray alloc] initWithCapacity:capacity];
        NSEnumerator *colorsEnum = [colorsConfig objectEnumerator];
        NSString *colorName;
        while( colorName = [colorsEnum nextObject] ) {
            [colors addObject:(id)[NBThemeConfig colorNamed:colorName].CGColor];
        }
        [cachedGradientColors setObject:colors forKey:gradientName];
    }

    gradient.colors = colors;
    gradient.locations = locations;
}

+(UIFont *)fontForComponent:(NSString *)componentName {
    
    [NBThemeConfig setUpStatics];
    
    NSString *fontName = [[config objectForKey:COMPONENT_FONTS_KEY] objectForKey:componentName];
    UIFont *font =  [NBThemeConfig fontNamed:fontName];
    
    return font;
}

@end
