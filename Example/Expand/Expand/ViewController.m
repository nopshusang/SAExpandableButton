//
//  ViewController.m
//  SAExpandableButton
//
//  Created by Nop Shusang on 8/3/14.
//  Copyright (c) 2014 SyncoApp. All rights reserved.
//

#import "ViewController.h"
#import "SAExpandableButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  Provide custom buttons by providing an array of UIButtons in to the "buttons" property
     */
    SAExpandableButton *customButton = [[SAExpandableButton alloc]initWithFrame:CGRectMake(110, 45, 100, 25)];
    customButton.expandDirection = SAExpandDirectionCenter;
    customButton.numberOfButtons = 3;
    customButton.selectedIndex = 1;
    
    // to identify which button is selected
    customButton.tag = 0;
    
    // Provide buttons
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"HDR Auto" forState:UIControlStateNormal];
    [button1 setTintColor:[UIColor yellowColor]];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:@"HDR on" forState:UIControlStateNormal];
    [button2 setTintColor:[UIColor yellowColor]];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button3 setTitle:@"HDR off" forState:UIControlStateNormal];
    [button3 setTintColor:[UIColor whiteColor]];
    
    customButton.buttons = [NSArray arrayWithObjects:button1,button2,button3, nil];
    
    // Link a function to get called when the value changed
    [customButton addTarget:self
                     action:@selector(valueChanged:)
           forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:customButton];
    
    
    /**
     *  To use the default system button, simply set the buttonTitles property to an array of titles
     *  These three buttons also demonstrate the expandDirectionProperties
     */
    SAExpandableButton *leftButton = [[SAExpandableButton alloc]initWithFrame:CGRectMake(10, 100, 100, 25)];
    leftButton.expandDirection = SAExpandDirectionRight;
    leftButton.numberOfButtons = 3;
    leftButton.buttonTitles = [NSArray arrayWithObjects:@"one",@"two",@"three", nil];
    
    leftButton.tag = 1;
    
    [leftButton addTarget:self
                   action:@selector(valueChanged:)
         forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:leftButton];
    
    SAExpandableButton *centerButton = [[SAExpandableButton alloc]initWithFrame:CGRectMake(110, 150, 100, 25)];
    centerButton.expandDirection = SAExpandDirectionCenter;
    centerButton.numberOfButtons = 3;
    centerButton.selectedIndex = 1;
    centerButton.buttonTitles = [NSArray arrayWithObjects:@"four",@"five",@"six", nil];
    
    centerButton.tag = 2;
    
    [centerButton addTarget:self
                     action:@selector(valueChanged:)
           forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:centerButton];
    
    SAExpandableButton *rightButton = [[SAExpandableButton alloc]initWithFrame:CGRectMake(210, 200, 100, 25)];
    rightButton.expandDirection = SAExpandDirectionLeft;
    rightButton.numberOfButtons = 3;
    rightButton.selectedIndex = 2;
    rightButton.buttonTitles = [NSArray arrayWithObjects:@"seven",@"eight",@"nine", nil];
    
    rightButton.tag = 3;
    
    [rightButton addTarget:self
                    action:@selector(valueChanged:)
          forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:rightButton];
    
    /**
     *  Only provide enough frame for one button, SAExpandableButton will scale itself automatically
     */
    SAExpandableButton *moreButton = [[SAExpandableButton alloc]initWithFrame:CGRectMake(30, 275, 45, 25)];
    moreButton.expandDirection = SAExpandDirectionRight;
    moreButton.numberOfButtons = 5;
    moreButton.buttonTitles = [NSArray arrayWithObjects:@"b1",@"b2",@"b3",@"b4",@"b5", nil];
    
    rightButton.tag = 4;
    
    [moreButton addTarget:self
                   action:@selector(valueChanged:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:rightButton];
    
    [self.view addSubview:moreButton];
    
}


-(void) valueChanged:(id)sender{
    SAExpandableButton *button = (SAExpandableButton*)sender;
    NSString *buttonName;
    switch (button.tag) {
        case 0:
            buttonName = @"custom button";
            break;
        case 1:
            buttonName = @"left button";
            break;
        case 2:
            buttonName = @"center button";
            break;
        case 3:
            buttonName = @"right button";
            break;
        case 4:
            buttonName = @"more button";
            break;
        default:
            break;
    }
    
    NSLog(@"%@ did select button at index : %i",buttonName, button.selectedIndex);
}

@end
