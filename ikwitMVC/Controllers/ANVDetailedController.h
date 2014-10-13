//
//  ANVDetailedController.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 9/23/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Question;

@interface ANVDetailedController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)Question *question;

@end
