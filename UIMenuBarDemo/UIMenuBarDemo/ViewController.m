//
//  ViewController.m
//  TesdXcodeUserGuideDemo
//
//  Created by su xinde on 13-2-20.
//  Copyright (c) 2013年 su xinde. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *popMenuItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(popMenuAction:)];
    self.navigationItem.rightBarButtonItem = popMenuItem;
    [popMenuItem release];
}


- (void)popMenuAction:(id)sender
{
    UIMenuBarItem *menuItem1 = [[UIMenuBarItem alloc] initWithTitle:@"MenuItem1" target:self image:[UIImage imageNamed:@"10_device_access_network_cell.png"] action:@selector(clickAction:)];
    UIMenuBarItem *menuItem2 = [[UIMenuBarItem alloc] initWithTitle:@"MenuItem2" target:self image:[UIImage imageNamed:@"5-content-new-attachment.png"] action:@selector(clickAction:)];
    UIMenuBarItem *menuItem3 = [[UIMenuBarItem alloc] initWithTitle:@"MenuItem3" target:self image:[UIImage imageNamed:@"5_content_save.png"] action:@selector(clickAction:)];
    UIMenuBarItem *menuItem4 = [[UIMenuBarItem alloc] initWithTitle:@"MenuItem4" target:self image:[UIImage imageNamed:@"4_collections_labels.png"] action:@selector(clickAction:)];
    UIMenuBarItem *menuItem5 = [[UIMenuBarItem alloc] initWithTitle:@"MenuItem5" target:self image:[UIImage imageNamed:@"5_content_discard.png"] action:@selector(clickAction:)];
    UIMenuBarItem *menuItem6 = [[UIMenuBarItem alloc] initWithTitle:@"MenuItem6" target:self image:[UIImage imageNamed:@"5_content_copy.png"] action:@selector(clickAction:)];
    
    UIMenuBarItem *menuItem7 = [[UIMenuBarItem alloc] initWithTitle:@"MenuItem7" target:self image:[UIImage imageNamed:@"5_content_copy.png"] action:@selector(clickAction:)];
    UIMenuBarItem *menuItem8 = [[UIMenuBarItem alloc] initWithTitle:@"MenuItem8" target:self image:[UIImage imageNamed:@"5_content_copy.png"] action:@selector(clickAction:)];
    UIMenuBarItem *menuItem9 = [[UIMenuBarItem alloc] initWithTitle:@"MenuItem9" target:self image:[UIImage imageNamed:@"5_content_copy.png"] action:@selector(clickAction:)];
    UIMenuBarItem *menuItem10 = [[UIMenuBarItem alloc] initWithTitle:@"MenuItem10" target:self image:[UIImage imageNamed:@"5_content_copy.png"] action:@selector(clickAction:)];
    
    NSMutableArray *items =
    //[NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3,nil];
    //[NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3,  menuItem4, menuItem5, menuItem6, nil];
    [NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, menuItem6, menuItem7, menuItem8, menuItem9, menuItem10,nil];
    
    menuBar = [[UIMenuBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 240.0f) items:items];
    //menuBar.layer.borderWidth = 1.f;
    //menuBar.layer.borderColor = [[UIColor orangeColor] CGColor];
    //menuBar.tintColor = [UIColor orangeColor];
    menuBar.delegate = self;
    
    //menuBar.items = [NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3,nil];
    //menuBar.items = [NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3,  menuItem4, menuItem5, menuItem6, nil];

    menuBar.items = [NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, menuItem6, menuItem7, menuItem8, menuItem9, menuItem10,nil];
    
    [menuBar show];
    
    

}

- (void)clickAction:(id)sender
{
    NSLog(@"%s", __func__);
    [menuBar dismiss];
}


@end
