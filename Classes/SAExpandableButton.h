//
//  SAExpandableButton.h
//  SAExpandableButton
//
//  Created by Nop Shusang on 8/3/14.
//  Copyright (c) 2014 SyncoApp. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The direction the button will expand when clicked
 */
typedef NS_ENUM(NSInteger, SAExpandDirection) {
    /**
     *  Expand to both left and right, place the button in the center
     */
    SAExpandDirectionCenter,
    /**
     *  Expand to the left, place the button on the right
     */
    SAExpandDirectionLeft,
    /**
     *  Expand to the right, place the button on the left
     */
    SAExpandDirectionRight
};

@interface SAExpandableButton : UIControl

/**
 *  The total number of buttons in the expandable set
 */
@property NSUInteger numberOfButtons;

/**
 *  The expand direction, default to center
 */
@property SAExpandDirection expandDirection;

/**
 *  The index of the button which is currently selected
 *  Can be dynamically changed through the KVO pattern
 */
@property NSUInteger selectedIndex;

/**
 *  To use the default system buttons, simply provide the titles of those buttons in an array
 */
@property NSArray *buttonTitles;

/**
 *  To customize the buttons, provide an array of UIButton objects to this property
 */
@property NSArray *buttons;

@end
