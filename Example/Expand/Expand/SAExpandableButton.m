//
//  SAExpandableButton.m
//  SAExpandableButton
//
//  Created by Nop Shusang on 8/3/14.
//  Copyright (c) 2014 SyncoApp. All rights reserved.
//

#import "SAExpandableButton.h"

@interface SAExpandableButton(){
    CGRect originalFrame;
    NSMutableArray *allButtons;
    BOOL expanded;
}

@end

@implementation SAExpandableButton

/**
 *  Initialize the SAExpandableButton object with default values
 */
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _numberOfButtons = 1;
        _expandDirection = SAExpandDirectionCenter;
        allButtons = [NSMutableArray array];
        _selectedIndex = 0;
        expanded = NO;
        
        originalFrame = frame;
        
        [self addObserver:self forKeyPath:@"numberOfButtons" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"expandDirection" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"buttonTitles" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"buttons" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
        
        [self drawButtons];
    }
    return self;
}

/**
 *  Add UIButtons object to the frame. Get called every time one of the property changes, corresponds to the KVO design pattern.
 */
-(void)drawButtons
{
    self.backgroundColor = [UIColor clearColor];
    
    for (UIButton *button in allButtons) {
        [button removeFromSuperview];
    }
    
    [allButtons removeAllObjects];

    
    for (int i = 0; i < _numberOfButtons; i++) {
        UIButton *button;
        
        if (_buttons) {
            button = [_buttons objectAtIndex:i];
        }
        else{
            button = [UIButton buttonWithType:UIButtonTypeSystem];

            
            NSString *title = _buttonTitles && [_buttonTitles count] >= _numberOfButtons ? [_buttonTitles objectAtIndex:i] : [NSString stringWithFormat:@"button%i",i];
            [button setTitle:title forState:UIControlStateNormal];
        }
        
        button.frame = CGRectMake(0, 0, originalFrame.size.width, originalFrame.size.height);
        button.tag = i;
        [button addTarget:self
                   action:@selector(buttonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        
        if (i != _selectedIndex) {
            button.alpha = 0;
        }
        
        [self addSubview:button];
        [allButtons addObject:button];

    }
    
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    [self drawButtons];
}

/**
 *  Handles when the buttons are clicked.
 *  Contains the logic behid the expanding and collasping animation
 */
- (void)buttonClicked:(id)sender{
    UIButton *selectedButton = (UIButton*)sender;
    _selectedIndex = selectedButton.tag;
    
    CGPoint origin = originalFrame.origin;
    CGSize size = originalFrame.size;
    CGFloat beginingPosition = 0;
    
    /**
     *  Expand
     */
    if (!expanded) {
        if (_expandDirection == SAExpandDirectionCenter) {
            self.frame = CGRectMake(origin.x - (_numberOfButtons/2) * size.width, origin.y, size.width * _numberOfButtons, size.height);
            beginingPosition = (size.width * _numberOfButtons)/2 - originalFrame.size.width/2;
        }
        else if (_expandDirection == SAExpandDirectionLeft) {
            self.frame = CGRectMake(origin.x - (_numberOfButtons-1) * size.width, origin.y, size.width * _numberOfButtons, size.height);
            beginingPosition = originalFrame.size.width * (_numberOfButtons-1);
        }
        else if (_expandDirection == SAExpandDirectionRight) {
            self.frame = CGRectMake(origin.x, origin.y, size.width * _numberOfButtons, size.height);
            beginingPosition = 0;
        }
        
        for (int i = 0; i < _numberOfButtons; i++) {
            UIButton *button = [allButtons objectAtIndex:i];
            button.frame = CGRectMake(beginingPosition, 0, self.frame.size.width/_numberOfButtons, self.frame.size.height);
        }

        
        for (int i = 0; i < _numberOfButtons; i++) {
            UIButton *button = [allButtons objectAtIndex:i];
            
            [UIView animateWithDuration:0.2
                             animations:^{
                                 button.frame = CGRectMake(i * originalFrame.size.width, 0, self.frame.size.width/_numberOfButtons, self.frame.size.height);
                                 button.alpha = 1;
                             } completion:^(BOOL finished) {
                                 
                             }];
            
            
        }
        expanded = YES;
    }
    
    /**
     *  Collaspe
     */
    else{
        
        if (_expandDirection == SAExpandDirectionCenter) {
            beginingPosition = (size.width * _numberOfButtons)/2 - originalFrame.size.width/2;
        }
        else if (_expandDirection == SAExpandDirectionLeft) {
            beginingPosition = originalFrame.size.width * (_numberOfButtons-1);
        }
        else if (_expandDirection == SAExpandDirectionRight) {
            beginingPosition = 0;
        }
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        
        __block int syncCount = 0;
        for (int i = 0; i < _numberOfButtons; i++) {
            UIButton *button = [allButtons objectAtIndex:i];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 button.frame = CGRectMake(beginingPosition, 0, originalFrame.size.width, originalFrame.size.height);
                                 if (i != _selectedIndex) {
                                     button.alpha = 0;
                                 }
                                 
                             } completion:^(BOOL finished) {
                                 syncCount++;
                                 if (syncCount == _numberOfButtons) {
                                     self.frame = originalFrame;
                                     for (int i = 0; i < _numberOfButtons; i++){
                                         UIButton *button = [allButtons objectAtIndex:i];
                                         button.frame = CGRectMake(0, 0, originalFrame.size.width, originalFrame.size.height);
                                     }
                                     
                                 }
                                 
                             }];
            
            
        }
        expanded = NO;
    }
}
@end
