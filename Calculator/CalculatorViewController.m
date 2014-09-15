//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Ivan Magda on 14.09.14.
//  Copyright (c) 2014 Ivan Magda. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculateExpression.h"

static const NSInteger kMaxPortViewTextSize = 50;
static const NSInteger kMinPortViewTextSize = 30;

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController
{
    NSMutableString *_stringExpressionForShowAtPortView; //this string displayed at the UILabel
    
    NSMutableString *_stringForCalculateExpression; //this string needs for correct calculation of expressions
    
    BOOL _newExpression;
    
    NSInteger _lengthOfExpression;
}

#pragma mark - UIViewController -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startNewExpression];
}

- (void)startNewExpression {
    _stringExpressionForShowAtPortView = [@"0"   mutableCopy];
    _stringForCalculateExpression      = [@"0.0" mutableCopy];
    _newExpression = YES;
    _lengthOfExpression = 1;
    
    [self updatePortViewText];
    [self checkForUpdatePortViewFont];
}

#pragma mark - Configurate PortView -

- (void)updatePortViewText {
    self.portView.text = _stringExpressionForShowAtPortView;
}

- (void)checkForUpdatePortViewFont
{
    if (_lengthOfExpression == 11 || _lengthOfExpression  > 11) {
        self.portView.font = [UIFont fontWithName:@"Arial" size:kMinPortViewTextSize];
    }
    else if (_lengthOfExpression >= 0 &&
             _lengthOfExpression < 11)
        self.portView.font = [UIFont fontWithName:@"Arial" size:kMaxPortViewTextSize];
}


#pragma mark - SetUp inputData for Calculate -

- (BOOL)isNewExpression
{
    if (_newExpression) {
        _newExpression = NO;
        return YES;
    }
    return NO;
}

- (void)addSymbolToExpression:(NSString *)symbol
{
    BOOL isNewExpression = [self isNewExpression];
    [self setupExpressionStringForCalculateWith:symbol isNewExpression:isNewExpression];
    
    if (isNewExpression) {
        _stringExpressionForShowAtPortView = [symbol mutableCopy];
    } else {
        [_stringExpressionForShowAtPortView appendString:symbol];
        _lengthOfExpression++;
        
        [self checkForUpdatePortViewFont];
    }
    [self updatePortViewText];
}

- (void)setupExpressionStringForCalculateWith:(NSString *)symbol isNewExpression:(BOOL)newExpression
{
    if (newExpression)
    {
        if ([self isNumber:symbol])
            _stringForCalculateExpression = [NSMutableString stringWithFormat:@"1.0*%@",symbol];
        else
            _stringForCalculateExpression = [symbol mutableCopy];
    }
    else if (!newExpression)
    {
        if ([self isNumber:symbol]) {
            [_stringForCalculateExpression appendString:[NSMutableString stringWithFormat:@"%@",symbol]];
        } else {
            if ([symbol isEqualToString:@"*"] || [symbol isEqualToString:@"("]) {
                [_stringForCalculateExpression appendString:symbol];
            } else {
                [_stringForCalculateExpression appendString:[NSMutableString stringWithFormat:@"*1.0%@",symbol]];
            }
        }
    }
}

- (BOOL)isNumber:(NSString *)string
{
    if ([string isEqualToString:@"0"]) {
        return YES;
    }
    else if ([string isEqualToString:@"1"]) {
        return YES;
    }
    else if ([string isEqualToString:@"2"]) {
        return YES;
    }
    else if ([string isEqualToString:@"3"]) {
        return YES;
    }
    else if ([string isEqualToString:@"4"]) {
        return YES;
    }
    else if ([string isEqualToString:@"5"]) {
        return YES;
    }
    else if ([string isEqualToString:@"6"]) {
        return YES;
    }
    else if ([string isEqualToString:@"7"]) {
        return YES;
    }
    else if ([string isEqualToString:@"8"]) {
        return YES;
    }
    else if ([string isEqualToString:@"9"]) {
        return YES;
    }
    return NO;
}

#pragma mark - Calculate process:

- (void)calculateExpression {
    [self calculatorViewController:self didAskedForCalculatingExpression:_stringForCalculateExpression];
}

#pragma mark   CalculatorViewControllerProtocol

- (void)calculatorViewController:(CalculatorViewController *)controller didAskedForCalculatingExpression:(NSString *)expression
{
    self.delegate = [[CalculateExpression alloc]init];
    
    [self.delegate calculatorViewController:controller didAskedForCalculatingExpression:expression];
}


#pragma mark - Show Result on Screen -

- (void)showResult {
    _lengthOfExpression = (CGFloat)[[NSString stringWithFormat:@"%@",@(self.resultValue)] length];
    
    [self outputResultSetUp];
    [self updatePortViewText];
    [self checkForUpdatePortViewFont];
    
    NSLog(@"%ld", (long)_lengthOfExpression);
    NSLog(@"%f", self.resultValue);
    NSLog(@"%@", _stringExpressionForShowAtPortView);
}

- (void)outputResultSetUp {
    NSInteger integerPart = (NSInteger)self.resultValue;
    CGFloat fractionPart = self.resultValue - integerPart;
    
    if (fractionPart == 0.0) {
        _stringExpressionForShowAtPortView = [NSMutableString stringWithFormat:@"%ld", (long)integerPart];
        _stringForCalculateExpression = [NSMutableString stringWithFormat:@"%ld.0",integerPart];
    } else {
        _stringExpressionForShowAtPortView = [NSMutableString stringWithFormat:@"%@",@(self.resultValue)];
        _stringForCalculateExpression = [NSMutableString stringWithFormat:@"%@",@(self.resultValue)];
    }
}

#pragma mark - Animation -

- (void)showAnimationAtResult:(BOOL)isResult orAcButtonPressed:(BOOL)isButton {
    CGFloat originalAlpha = self.portView.alpha;
    self.portView.alpha = 0;
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn |UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         if (isResult) {
                             [self showResult];
                             self.portView.alpha = originalAlpha;
                         }
                         else
                             self.portView.alpha = originalAlpha;
                     }
                     completion:^(BOOL finished) {
                         finished = YES;
                     }];
}

#pragma mark - Actions:

#pragma mark Operations

- (IBAction)acButtonPressed:(UIButton *)sender {
    [self startNewExpression];
    [self showAnimationAtResult:NO orAcButtonPressed:YES];
}

- (IBAction)leftBracketButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"("];
}

- (IBAction)rightBracketButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@")"];
}

- (IBAction)divisionButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"/"];
}

- (IBAction)multiplicationButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"*"];
}

- (IBAction)subtractionButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"-"];
}

- (IBAction)additionButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"+"];
}

- (IBAction)equalButtonPressed:(UIButton *)sender {
    [self calculateExpression];
    [self showAnimationAtResult:YES orAcButtonPressed:NO];
}

- (IBAction)pointButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@","];
}

#pragma mark Numbers Buttons

- (IBAction)zeroButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"0"];
}

- (IBAction)oneButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"1"];
}

- (IBAction)twoButtontPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"2"];
}

- (IBAction)threeButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"3"];
}

- (IBAction)fourButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"4"];
}

- (IBAction)fiveButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"5"];
}

- (IBAction)sixButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"6"];
}

- (IBAction)sevenButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"7"];
}

- (IBAction)eightButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"8"];
}

- (IBAction)nineButtonPressed:(UIButton *)sender {
    [self addSymbolToExpression:@"9"];
}

@end
