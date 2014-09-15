//
//  CalculatorViewControllerProtocol.h
//  Calculator
//
//  Created by Ivan Magda on 15.09.14.
//  Copyright (c) 2014 Ivan Magda. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalculatorViewController;
@class NSString;

@protocol CalculatorViewControllerProtocol <NSObject>

- (void)calculatorViewController:(CalculatorViewController *)controller didAskedForCalculatingExpression:(NSString *)expression;

@end
