//
//  ANVCustomItemViewController.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/1/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVDetailViewController.h"

@interface ANVDetailViewController ()

@end

@implementation ANVDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ANVCustomCell *cell = [ANVCustomCell new];
    self.userName.text = cell.userName.text;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
