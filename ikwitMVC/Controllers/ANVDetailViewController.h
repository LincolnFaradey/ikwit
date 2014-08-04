//
//  ANVCustomItemViewController.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/1/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANvCustomCell.h"

@interface ANVDetailViewController : UIViewController 

@property (nonatomic)ANVCustomCell *cell;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
