//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Ivan Magda on 14.09.14.
//  Copyright (c) 2014 Ivan Magda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorViewControllerProtocol.h"

@interface CalculatorViewController : UIViewController
                                     <CalculatorViewControllerProtocol>
// properties
@property (nonatomic, strong) id<CalculatorViewControllerProtocol> delegate;
@property (nonatomic) CGFloat resultValue;

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *portView;

// Operations
- (IBAction)acButtonPressed:             (UIButton *)sender;

- (IBAction)leftBracketButtonPressed:    (UIButton *)sender;

- (IBAction)rightBracketButtonPressed:   (UIButton *)sender;

- (IBAction)divisionButtonPressed:       (UIButton *)sender;

- (IBAction)multiplicationButtonPressed: (UIButton *)sender;

- (IBAction)subtractionButtonPressed:    (UIButton *)sender;

- (IBAction)additionButtonPressed:       (UIButton *)sender;

- (IBAction)equalButtonPressed:          (UIButton *)sender;

- (IBAction)pointButtonPressed:          (UIButton *)sender;

// Numbers
- (IBAction)zeroButtonPressed: (UIButton *)sender;
- (IBAction)oneButtonPressed:  (UIButton *)sender;
- (IBAction)twoButtontPressed: (UIButton *)sender;
- (IBAction)threeButtonPressed:(UIButton *)sender;
- (IBAction)fourButtonPressed: (UIButton *)sender;
- (IBAction)fiveButtonPressed: (UIButton *)sender;
- (IBAction)sixButtonPressed:  (UIButton *)sender;
- (IBAction)sevenButtonPressed:(UIButton *)sender;
- (IBAction)eightButtonPressed:(UIButton *)sender;
- (IBAction)nineButtonPressed: (UIButton *)sender;

@end
