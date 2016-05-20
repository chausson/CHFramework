//
//  CHPickerImage.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/17.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHPickerImage.h"
#import "CHImagePicker.h"
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


@end
