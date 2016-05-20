//
//  CommentaryModel.h
//  CommentaryModule
//
//  Created by 郭金涛 on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//@class CHCommentaryModelItems;
@protocol CHCommentaryModelItems <NSObject>

@end

@interface CHCommentaryModelItems :JSONModel
@property (copy ,nonatomic )NSString <Optional>*userName;

@property (copy, nonatomic)NSString <Optional>*photo;

@property (copy, nonatomic)NSString <Optional>*publicTime;

@property (copy, nonatomic)NSString <Optional>*content;

@property (assign, nonatomic)int createBy;
@end

@interface  CHCommentaryModelData:JSONModel
@property (nonatomic, strong)NSArray <Optional,CHCommentaryModelItems>*items;
@end

@interface CHCommentaryModel : JSONModel
@property (nonatomic, strong)CHCommentaryModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString <Optional>*message;
@end
