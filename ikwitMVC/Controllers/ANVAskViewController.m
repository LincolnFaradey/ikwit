//
//  ANVAskViewController.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 10/12/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVAskViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ANVKeyboardToolBar.h"

enum ActionListButtons {
    PHOTO_CAMERA_BUTTON = 0,
    PHOTO_LIBRARY_BUTTON,
    AUDIO_RECORD_BUTTON
};

@interface ANVAskViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (strong, nonatomic) ANVKeyboardToolBar *toolBar;

- (void)takePhoto;
- (void)openPhotoLibrary;

@end

@implementation ANVAskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_image setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    _toolBar = [[ANVKeyboardToolBar alloc] init];
    [self.view addSubview:_toolBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.tabBarController setHidesBottomBarWhenPushed: YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - ActionSheet metods

- (IBAction)addAsset:(id)sender {
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose the type of media"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Photo Library", @"Audio", nil];
    actionSheet.tag = 101;
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    
}

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
            case AUDIO_RECORD_BUTTON:
                [self recordAudio];
                break;
            default:
                break;
        }
    }
}

#pragma mark - ImagePicker metods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_videoController.view removeFromSuperview];
    _image.image = info[UIImagePickerControllerEditedImage];
    _videoURL = info[UIImagePickerControllerMediaURL];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_videoURL){
        self.videoController = [[MPMoviePlayerController alloc] init];
        
        [self.videoController setContentURL:self.videoURL];
        [self.videoController.view setFrame:CGRectMake (0, 0, 320, 460)];
        [self.view addSubview:self.videoController.view];
        
        [self.videoController play];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)takePhoto
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        //        imagePicker.mediaTypes = @[(NSString*)kUTTypeImage, (NSString *)kUTTypeVideo];
        imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.videoMaximumDuration = 10.0f;
    imagePicker.allowsEditing = YES;

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

- (void)recordAudio
{
    
}


#pragma mark -
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:1.0f animations:^{
        _toolBar.frame = CGRectMake(_toolBar.frame.origin.x, _toolBar.frame.origin.y - kbSize.height, _toolBar.frame.size.width, _toolBar.frame.size.height);
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:1.0f animations:^{
        _toolBar.frame = CGRectMake(_toolBar.frame.origin.x, _toolBar.frame.origin.y + kbSize.height, _toolBar.frame.size.width, _toolBar.frame.size.height);
    }];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
