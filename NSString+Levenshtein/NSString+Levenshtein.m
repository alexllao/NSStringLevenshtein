//
// NSString+Levenshtein.h
//
// Modified by Àlex Llaó on 06/27/14.
//
// Created by Àlex Llaó on Fri Jul 27 2014.
// alexllao (at) me.com
// Based on the implementation of the algorithms 
// proposed in Wikipedia "http://en.wikipedia.org/wiki/Levenshtein_distance".

#import "NSString+Levenshtein.h"
#import "CRL2DArray.h"

@implementation NSString (Levenshtein)
- (int)LevenshteinDistance:(NSString*)s2 {
    // d is a table with m+1 rows and n+1 columns
    NSString * s1 = self;
    int cost = 0;
    int m = (int)[s1 length];
    int n = (int)[s2 length];
    CRL2DArray * d = [[CRL2DArray alloc] initWithRows:m+1 columns:n+1];

    // Check that there is something to compare
    if (n == 0) return m;
    if (m == 0) return n;

    // Filling first column and first row
    for (int i = 0; i<=m; i++) { [d insertObject:[NSNumber numberWithInt:i] atRow:i column:0]; }
    for (int j = 0; j<=n; j++) { [d insertObject:[NSNumber numberWithInt:j] atRow:0 column:j]; }

    // Filling each row/column with weights
    for (int i = 1; i<=m; i++) {
        for (int j = 1; j<=n; j++) {
            cost = ([s1 characterAtIndex:i - 1] == [s2 characterAtIndex:j - 1]) ? 0 : 1;
            [d insertObject:[NSNumber numberWithInt: MIN(MIN([[d objectAtRow: i - 1 column:j] intValue] + 1, 
				[[d objectAtRow:i column: j - 1] intValue] + 1), cost + 
				[[d objectAtRow:i - 1 column:j - 1] intValue])] atRow:i column:j];
        }
    }

    // Return LevenshteinDistance
    return [[d objectAtRow:m column:n] intValue];
}
@end
