//
//  CHSettingController.m
//  FrameWorkPractice
//
//  Created by YouXieRen on 15/12/5.
//  Copyright © 2015年 李赐岩. All rights reserved.
//

#import "CHSettingController.h"
#import "CHContentController.h"
#import "CHItemViewModel.h"
#define TABBAR_PLIST_FILENAME @"CHCellItemData"
@interface CHSettingController ()

@property (nonatomic, strong) UINavigationController *settingNavigationController;

@property (nonatomic, strong) NSBundle *settingBundle;

@end

@implementation CHSettingController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.settingBundle = [NSBundle bundleForClass:[self class]];
        NSString *bundlePath = [self.settingBundle pathForResource:@"CHSettingController" ofType:@"bundle"];
        if (bundlePath) {
            self.settingBundle = [NSBundle bundleWithPath:bundlePath];
        }
        [self setUpSettingNavigationController];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:TABBAR_PLIST_FILENAME ofType:@"plist"];
        NSArray *items = [[NSArray alloc] initWithContentsOfFile:plistPath];
        CHContentController *content = (CHContentController *)self.settingNavigationController.topViewController;
        NSMutableArray *itemArray = [[NSMutableArray alloc]initWithCapacity:items.count];
        for (NSDictionary *dic in items) {
            CHItemViewModel *viewModel = [[CHItemViewModel alloc]init];
            if (dic[@"identifier"]) {
                viewModel.identifier = dic[@"identifier"];
            }
            if (dic[@"segueIdentifier"]) {
                viewModel.segueIdentifier = dic[@"segueIdentifier"];
            }
            if (dic[@"name"]) {
                viewModel.name = dic[@"name"];
            }
            [itemArray addObject:viewModel];
        }
        content.items = [NSArray arrayWithArray:itemArray];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark Private
- (void)setUpSettingNavigationController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CHSettingController" bundle:self.settingBundle];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"SettingNavigationController"];
    
    [self addChildViewController:navigationController];
    
    navigationController.view.frame = self.view.bounds;
    [self.view addSubview:navigationController.view];
    
    [navigationController didMoveToParentViewController:self];
    
    self.settingNavigationController = navigationController;
}


@end
