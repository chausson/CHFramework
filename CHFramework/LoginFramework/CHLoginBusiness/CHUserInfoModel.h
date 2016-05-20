//
//  CHUserInfoModel.h
//  weizhenNactive
//
//  Created by YouXieRen on 15/11/7.
//  Copyright (c) 2015年 李赐岩. All rights reserved.
//

#import "JSONModel.h"
@interface CHUserInfoProfile :JSONModel
@property (strong ,nonatomic) NSString <Optional>*userId;
@property (strong ,nonatomic) NSString <Optional>*nickName;
@end
@interface CHUserInfoModel : JSONModel
@property (strong ,nonatomic) NSString <Optional>*token;
@property (strong ,nonatomic) CHUserInfoProfile <Optional>*profile;
@end
