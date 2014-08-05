SAExpandableButton
==================

<p align="center">
  <img src="https://raw.githubusercontent.com/nopshusang/SAExpandableButton/master/Screenshots/SAExpandableButton.gif" alt="sample"/>
</p>

Expandable menu for choosing options as seen in the iOS camera app

Installation
==================

- Add **SAExpandableButton.h** and **SAExpandableButton.m** into your project
- Done

Basic Usage 
==================
- Import the header
```objective-c
#import "SAExpandableButton.h"
```

- To set up a simple SAExpandableButton object, simply set the following properties

```objective-c
    SAExpandableButton *yourButtons = [[SAExpandableButton alloc]initWithFrame:CGRectMake(110, 45, 100, 25)];
    yourButtons.expandDirection = SAExpandDirectionCenter;
    yourButtons.numberOfButtons = 3;
    yourButtons.selectedIndex = 1;

    yourButtons.buttonTitles = [NSArray arrayWithObjects:@"one",@"two",@"three", nil];

    [self.view addSubview:yourButtons];
```
Only set the **frame** of the object to be the size of **one button**, SAExpandableButton will expand itself after being selected

Customize
==================
- To provide your own buttons, provide an array of UIButton objects to the buttons property. In this case the buttonTitles array will be ignored
```objective-c
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
```

Control Events
==================
- To get notify when the user select on a button, simply add your function to the UIControlEventValueChanged event
```objective-c
[yourButtons addTarget:self
                     action:@selector(valueChanged:)
           forControlEvents:UIControlEventValueChanged];
```
- Your function would look like
```objective-c
-(void) valueChanged:(id)sender{
    SAExpandableButton *button = (SAExpandableButton*)sender;
    NSUInteger selectedIndex = button.selectedIndex;
    // do something with the selectedIndex
}
```
