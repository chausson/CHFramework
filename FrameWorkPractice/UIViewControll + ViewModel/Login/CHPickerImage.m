//
//  CHPickerImage.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/17.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHPickerImage.h"
#import "CHImagePicker.h"
#import "SDUploadImageAPI.h"
@interface CHPickerImage ()

@end

@implementation CHPickerImage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.icon.layer.cornerRadius = 5;
    self.icon.layer.masksToBounds = YES;
}
- (IBAction)pick:(UIButton *)sender {
    [[CHImagePicker shareInstance] showWithController:self finish:^(UIImage *image) {
        self.icon.image = image;
    } animated:YES];
}

- (IBAction)upload:(UIButton *)sender {
    SDUploadImageAPI *upload = [[SDUploadImageAPI alloc]initWithImage:self.icon.image imageName:@"头像" fileName:@"icon"];
    [upload startWithSuccessBlock:^(__kindof SDUploadImageAPI *request) {
        NSLog(@"request = %lu",request.baseResponse.code);
    } failureBlock:^(__kindof SDUploadImageAPI *request) {
        
    }];
}

@end
