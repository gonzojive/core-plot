
#import "CPTheme.h"
#import "CPExceptions.h"
#import "CPDarkGradientTheme.h"
#import "CPPlainBlackTheme.h"
#import "CPPlainWhiteTheme.h"
#import "CPStocksTheme.h"
#import "CPGraph.h"

// theme names
NSString * const kCPDarkGradientTheme = @"Dark Gradients";	///< Dark gradient theme.
NSString * const kCPPlainWhiteTheme = @"Plain White";		///< Plain white theme.
NSString * const kCPPlainBlackTheme = @"Plain Black";		///< Plain black theme.
NSString * const kCPStocksTheme = @"Stocks";				///< Stocks theme.

// Registered themes
static NSMutableDictionary *themes = nil;

/** @brief Creates a CPGraph instance formatted with predefined themes.
 *
 *	@todo More documentation needed 
 **/

@implementation CPTheme

@synthesize name;

-(void)dealloc
{
    [name release];
    [super dealloc];
}

/// @defgroup CPTheme CPTheme
/// @{

/**	@brief List of the available themes.
 *	@return An NSArray with all available themes.
 **/
+(NSArray *)themeClasses {
	static NSArray *themeClasses = nil;
	if ( themeClasses == nil ) {
		themeClasses = [[NSArray alloc] initWithObjects:[CPDarkGradientTheme class], [CPPlainBlackTheme class], [CPPlainWhiteTheme class],  [CPStocksTheme class], nil];
	}
	return themeClasses;
}

/**	@brief Gets a named theme.
 *	@param themeName The name of the desired theme.
 *	@return A CPTheme instance with name matching themeName or nil if no themes with a matching name were found.
 **/
+(CPTheme *)themeNamed:(NSString *)themeName
{
	static NSMutableDictionary *themes = nil;
	if ( themes == nil ) themes = [[NSMutableDictionary alloc] init];
	
	CPTheme *theme = [themes objectForKey:themeName];
	if ( theme ) return theme;
	
	for ( Class themeClass in [CPTheme themeClasses] ) {
		if ( [themeName isEqualToString:[themeClass defaultName]] ) {
			theme = [[themeClass alloc] init];
			[themes setObject:theme forKey:themeName];
			break;
		}
	}
	
	return [theme autorelease];
}

/**	@brief Register a theme for a given name.
 *	@param newTheme Theme to register.
 **/
+(void)addTheme:(CPTheme *)newTheme
{
    CPTheme *existingTheme = [self themeNamed:newTheme.name];
    if ( existingTheme ) {
        [NSException raise:CPException format:@"Theme already exists with name %@", newTheme.name];
    }
    
    [themes setObject:newTheme forKey:newTheme.name];
}

/**	@brief The name used by default for this theme class.
 *	@return The name.
 **/
+(NSString *)defaultName 
{
	return NSStringFromClass(self);
}

/**	@brief The name of the theme.
 *	@return The name.
 **/
-(NSString *)name 
{
	return (name ? name : [[self class] defaultName]);
}

/**	@brief Applies the theme to the provided graph.
 *	@param graph The graph to style.
 **/
-(void)applyThemeToGraph:(CPGraph *)graph
{
	[self applyThemeToBackground:graph];
	[self applyThemeToPlotArea:graph.plotArea];
	[self applyThemeToAxisSet:graph.axisSet];    
}

/**	@brief Applies the background theme to the provided graph.
 *	@param graph The graph to style.
 **/
-(void)applyThemeToBackground:(CPGraph *)graph 
{
}

/**	@brief Applies the theme to the provided plot area.
 *	@param plotArea The plot area to style.
 **/
-(void)applyThemeToPlotArea:(CPPlotArea *)plotArea
{
}

/**	@brief Applies the theme to the provided axis set.
 *	@param axisSet The axis set to style.
 **/
-(void)applyThemeToAxisSet:(CPAxisSet *)axisSet
{
}

///	@}

@end
