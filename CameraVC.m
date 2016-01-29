//
//  CameraVC.m
//  LuxuryRack
//
//  Created by Samuel Andros on 11/27/15.
//  Copyright (c) 2015 Samuel Andros. All rights reserved.
//

#import "CameraVC.h"
#import "camera.h"
#import "utilities.h"
#import "CreateCovershotVC.h"
#import "CameraSessionView.h"

@interface CameraVC () <CACameraSessionDelegate>

@property (weak, nonatomic) IBOutlet CameraSessionView *cameraView;
@end

@implementation CameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_cameraView hideCameraToogleButton];
    [_cameraView hideDismissButton];
    [_cameraView hideFlashButton];
    [_cameraView setTopBarColor:[UIColor clearColor]];
    
    _cameraView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClick_Cancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onClick_Library:(id)sender {
    ShouldStartPhotoLibrary(self, YES);
}

- (IBAction)onClick_off:(id)sender {
    [_cameraView setFlash];
    
}

- (IBAction)onClick_SwitchCamera:(id)sender {
    [_cameraView cameraTogle];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (image.size.width > 200) image = ResizeImage(image, 200, 200);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    CreateCovershotVC *vc = [[CreateCovershotVC alloc] initWithNibName:@"CreateCovershotVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)onClick_Capture:(id)sender {
    [_cameraView captureImage];
    
//    CreateCovershotVC *vc = [[CreateCovershotVC alloc] initWithNibName:@"CreateCovershotVC" bundle:nil];
//    [self.navigationController pushViewController:vc animated:true];
}


-(void)didCaptureImage:(UIImage *)image {
    NSLog(@"CAPTURED IMAGE");
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    [self.cameraView removeFromSuperview];
    CreateCovershotVC *vc = [[CreateCovershotVC alloc] initWithNibName:@"CreateCovershotVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

-(void)didCaptureImageWithData:(NSData *)imageData {
    NSLog(@"CAPTURED IMAGE DATA");
    //UIImage *image = [[UIImage alloc] initWithData:imageData];
    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //[self.cameraView removeFromSuperview];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //Show error alert if image could not be saved
    if (error) [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
