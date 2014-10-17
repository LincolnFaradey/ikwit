//
//  ANVAskViewController.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 10/12/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVAskViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

enum ActionListButtons {
    PHOTO_CAMERA_BUTTON = 0,
    PHOTO_LIBRARY_BUTTON,
    VIDEO_CAMERA_BUTTON
};

@interface ANVAskViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

- (void)takePhoto;
- (void)openPhotoLibrary;

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
    [self.tabBarController.tabBar setHidden:YES];
    [self.tabBarController setHidesBottomBarWhenPushed: YES];
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
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose the type of media"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Photo Library", @"Video", nil];
    actionSheet.tag = 101;
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _image.image = info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ActionSheet metods

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 101) {
        switch (buttonIndex) {
            case PHOTO_CAMERA_BUTTON:
                [self takePhoto];
                break;
            case PHOTO_LIBRARY_BUTTON:
                [self openPhotoLibrary];
                break;
            case VIDEO_CAMERA_BUTTON:
                [self makeVideo];
                break;
            default:
                break;
        }
    }
}

- (void)takePhoto
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        //        imagePicker.mediaTypes = @[(NSString*)kUTTypeImage, (NSString *)kUTTypeVideo];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.allowsEditing = YES;
    //    [self presentViewController:imagePicker
    //                       animated:YES completion:nil];
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

- (void)openPhotoLibrary
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.allowsEditing = YES;
    
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

- (void)makeVideo
{
    UIVideoEditorController* videoEditor = [[UIVideoEditorController alloc] init];
    videoEditor.delegate = self;
    NSString* videoPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"MOV"];
    if ( [UIVideoEditorController canEditVideoAtPath:videoPath] ) {
        videoEditor.videoPath = videoPath;
        [self presentViewController:videoEditor animated:YES completion:nil];
    } else {
        NSLog( @"can't edit video at %@", videoPath );
    }
}

@end
