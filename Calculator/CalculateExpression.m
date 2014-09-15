//
//  CalculateExpression.m
//  Calculator
//
//  Created by Ivan Magda on 15.09.14.
//  Copyright (c) 2014 Ivan Magda. All rights reserved.
//

#import "CalculateExpression.h"
#import "CalculatorViewController.h"

@implementation CalculateExpression

#pragma mark - CalculatorViewControllerProtocol -

- (void)calculatorViewController:(CalculatorViewController *)controller didAskedForCalculatingExpression:(NSString *)expression
{
    NSExpression *calculateExpression = [NSExpression expressionWithFormat:expression];
    CGFloat value = [[calculateExpression expressionValueWithObject:nil context:nil]floatValue];
    controller.resultValue = value;
}

@end
