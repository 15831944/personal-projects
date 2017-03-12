#import "FBBitmapFont.h"

@implementation FBBitmapFont

+ (void)drawBackgroundWithDotType:(FBFontDotType)dotType
                            color:(UIColor *)color
                       edgeLength:(CGFloat)edgeLength
                           margin:(CGFloat)margin
                 horizontalAmount:(CGFloat)horizontalAmount
                   verticalAmount:(CGFloat)verticalAmount
                        inContext:(CGContextRef)ctx
{
    NSInteger i = 0;
    NSInteger j = 0;
    float l = edgeLength + margin;

    CGContextSetFillColorWithColor(ctx, color.CGColor);

    CGRect r;
    for (i = 0; i < verticalAmount; i++) {
        for (j = 0; j < horizontalAmount; j++) {
            r = CGRectMake(j * l, i * l, edgeLength, edgeLength);
            if (dotType == FBFontDotTypeSquare) {
                CGContextFillRect(ctx, r);
            } else {
                CGContextFillEllipseInRect(ctx, r);
            }
        }
    }
}

+ (void)drawSymbol:(FBFontSymbolType)symbol
       withDotType:(FBFontDotType)dotType
             color:(UIColor *)color
        edgeLength:(CGFloat)edgeLength
            margin:(CGFloat)margin
        startPoint:(CGPoint)startPoint
         inContext:(CGContextRef)ctx
{

    float x = 0;
    float y = 0;
    float l = edgeLength + margin;

    NSArray *coord = [self coordForSymbol:symbol];

    CGContextSetFillColorWithColor(ctx, color.CGColor);
        
    CGRect frm;
    for (int r = 0; r < [coord count]; r++) {
        NSArray *column = coord[r];
        for (int c = 0; c < [column count]; c++) {
            BOOL on = [column[c] boolValue];
            if (on) {
                y = startPoint.y + r * l;
                x = startPoint.x + c * l;
                frm = CGRectMake(x, y, edgeLength, edgeLength);
                if (dotType == FBFontDotTypeSquare) {
                    CGContextFillRect(ctx, frm);
                }
                else {
                    CGContextFillEllipseInRect(ctx, frm);
                }
            }
        }
    }
}

+ (NSInteger)numberOfDotsWideForSymbol:(FBFontSymbolType)symbol {
    NSArray *coord = [self coordForSymbol:symbol];
    return [[coord objectAtIndex:0] count];
}

+ (NSArray *)coordForSymbol:(FBFontSymbolType)symbol {
    
    switch (symbol) {
        case FBFontSymbol0:
            return @[@[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0]];
        case FBFontSymbol1:
            return @[@[@0,@0,@1,@0,@0],
                     @[@0,@1,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0]];
        case FBFontSymbol2:
            return @[@[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@0,@0,@0,@1],
                     @[@0,@0,@0,@1,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@1,@0,@0,@0],
                     @[@1,@1,@1,@1,@1]];
        case FBFontSymbol3:
            return @[@[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@0,@0,@0,@1],
                     @[@0,@0,@1,@1,@0],
                     @[@0,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0]];
        case FBFontSymbol4:
            return @[@[@0,@0,@0,@1,@0],
                     @[@0,@0,@1,@1,@0],
                     @[@0,@1,@0,@1,@0],
                     @[@1,@0,@0,@1,@0],
                     @[@1,@1,@1,@1,@1],
                     @[@0,@0,@0,@1,@0],
                     @[@0,@0,@0,@1,@0]];
        case FBFontSymbol5:
            return @[@[@1,@1,@1,@1,@1],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@1,@1,@1,@0],
                     @[@0,@0,@0,@0,@1],
                     @[@0,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0]];
        case FBFontSymbol6:
            return @[@[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0]];
        case FBFontSymbol7:
            return @[@[@1,@1,@1,@1,@1],
                     @[@0,@0,@0,@0,@1],
                     @[@0,@0,@0,@1,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@1,@0,@0,@0],
                     @[@0,@1,@0,@0,@0],
                     @[@0,@1,@0,@0,@0]];
        case FBFontSymbol8:
            return @[@[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0]];
        case FBFontSymbol9:
            return @[@[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@1],
                     @[@0,@0,@0,@0,@1],
                     @[@0,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0]];
        case FBFontSymbolA:
            return @[@[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@1,@1,@1,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1]];
        case FBFontSymbolB:
            return @[@[@1,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@1,@1,@1,@0]];
        case FBFontSymbolC:
            return @[@[@0,@1,@1,@1,@1],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@0,@1,@1,@1,@1]];
        case FBFontSymbolD:
            return @[@[@1,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@1,@1,@1,@0]];
        case FBFontSymbolE:
            return @[@[@1,@1,@1,@1,@1],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@1,@1,@1,@1]];
        case FBFontSymbolF:
            return @[@[@1,@1,@1,@1,@1],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0]];
        case FBFontSymbolG:
            return @[@[@0,@1,@1,@1,@1],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@1,@1,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0]];
        case FBFontSymbolH:
            return @[@[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@1,@1,@1,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1]];
        case FBFontSymbolI:
            return @[@[@1,@1,@1,@1,@1],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@1,@1,@1,@1,@1]];
        case FBFontSymbolJ:
            return @[@[@0,@0,@0,@1,@0],
                     @[@0,@0,@0,@1,@0],
                     @[@0,@0,@0,@1,@0],
                     @[@0,@0,@0,@1,@0],
                     @[@1,@0,@0,@1,@0],
                     @[@1,@0,@0,@1,@0],
                     @[@0,@1,@1,@0,@0]];
        case FBFontSymbolK:
            return @[@[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@1,@0],
                     @[@1,@0,@1,@0,@0],
                     @[@1,@1,@0,@0,@0],
                     @[@1,@0,@1,@0,@0],
                     @[@1,@0,@0,@1,@0],
                     @[@1,@0,@0,@0,@1]];
        case FBFontSymbolL:
            return @[@[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@1,@1,@1,@1]];
        case FBFontSymbolM:
            return @[@[@1,@0,@0,@0,@1],
                     @[@1,@1,@0,@1,@1],
                     @[@1,@0,@1,@0,@1],
                     @[@1,@0,@1,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1]];
        case FBFontSymbolN:
            return @[@[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@1,@0,@0,@1],
                     @[@1,@0,@1,@0,@1],
                     @[@1,@0,@0,@1,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1]];
        case FBFontSymbolO:
            return @[@[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0]];
        case FBFontSymbolP:
            return @[@[@1,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@0,@0,@0,@0]];
        case FBFontSymbolQ:
            return @[@[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@1,@0,@1],
                     @[@1,@0,@0,@1,@1],
                     @[@0,@1,@1,@1,@1]];
        case FBFontSymbolR:
            return @[@[@1,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@1,@1,@1,@0],
                     @[@1,@0,@1,@0,@0],
                     @[@1,@0,@0,@1,@0],
                     @[@1,@0,@0,@0,@1]];
        case FBFontSymbolS:
            return @[@[@0,@1,@1,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@0],
                     @[@0,@1,@1,@1,@0],
                     @[@0,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0]];
        case FBFontSymbolT:
            return @[@[@1,@1,@1,@1,@1],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0]];
        case FBFontSymbolU:
            return @[@[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@1,@1,@0]];
        case FBFontSymbolV:
            return @[@[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@0,@1,@0],
                     @[@0,@0,@1,@0,@0]];
        case FBFontSymbolW:
            return @[@[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@1,@0,@1],
                     @[@1,@0,@1,@0,@1],
                     @[@1,@1,@0,@1,@1],
                     @[@1,@0,@0,@0,@1]];
        case FBFontSymbolX:
            return @[@[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@0,@1,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@1,@0,@1,@0],
                     @[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1]];
        case FBFontSymbolY:
            return @[@[@1,@0,@0,@0,@1],
                     @[@1,@0,@0,@0,@1],
                     @[@0,@1,@0,@1,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0]];
        case FBFontSymbolZ:
            return @[@[@1,@1,@1,@1,@1],
                     @[@0,@0,@0,@0,@1],
                     @[@0,@0,@0,@1,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@1,@0,@0,@0],
                     @[@1,@0,@0,@0,@0],
                     @[@1,@1,@1,@1,@1]];
        case FBFontSymbolArrowUp:
            return @[@[@0,@0,@0,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@1,@1,@1,@0],
                     @[@1,@0,@1,@0,@1],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@0,@0,@0]];
        case FBFontSymbolArrowDown:
            return @[@[@0,@0,@0,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@1,@0,@1,@0,@1],
                     @[@0,@1,@1,@1,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@0,@0,@0]];
        case FBFontSymbolArrowLeft:
            return @[@[@0,@0,@0,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@1,@0,@0,@0],
                     @[@1,@1,@1,@1,@1],
                     @[@0,@1,@0,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@0,@0,@0]];
        case FBFontSymbolArrowRight:
            return @[@[@0,@0,@0,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@0,@1,@0],
                     @[@1,@1,@1,@1,@1],
                     @[@0,@0,@0,@1,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@0,@0,@0]];
        case FBFontSymbolDash:
            return @[@[@0,@0,@0,@0,@0],
                     @[@0,@0,@0,@0,@0],
                     @[@0,@0,@0,@0,@0],
                     @[@1,@1,@1,@1,@1],
                     @[@0,@0,@0,@0,@0],
                     @[@0,@0,@0,@0,@0],
                     @[@0,@0,@0,@0,@0]];
        case FBFontSymbolSpace:
            return @[@[@0,@0,@0,@0,@0],
                     @[@0,@0,@0,@0,@0],
                     @[@0,@0,@0,@0,@0],
                     @[@0,@0,@0,@0,@0],
                     @[@0,@0,@0,@0,@0],
                     @[@0,@0,@0,@0,@0],
                     @[@0,@0,@0,@0,@0]];
        case FBFontSymbolExclamationMark:
            return @[@[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@1,@0,@0],
                     @[@0,@0,@0,@0,@0],
                     @[@0,@0,@1,@0,@0]];
        case FBFontSymbolColon:
            return @[@[@0,@0,@0],
                     @[@0,@1,@0],
                     @[@0,@0,@0],
                     @[@0,@0,@0],
                     @[@0,@0,@0],
                     @[@0,@1,@0],
                     @[@0,@0,@0]];
        default:
            break;
    }
}

@end
