//
//  ANVAskViewController.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 10/12/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVAskViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ANVAskViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ANVAskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)addAsset:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    imagePicker.sourceType =
    UIImagePickerControllerSourceTypeCamera;
    
    imagePicker.mediaTypes = @[(NSString*)kUTTypeImage, (NSString *)kUTTypeVideo];
    
    
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker
                       animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _image.image = info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.hidesBottomBarWhenPushed = YES;
}

@end
