//
//  CHCommentaryCellVM.h
//  CommentaryModule
//
//  Created by Chausson on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHCommentaryCellVM : NSObject

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *imageUrl;

@property (copy ,nonatomic) NSString *time;

@property (copy, nonatomic) NSString *content;

@property (assign, nonatomic) NSInteger praiseNum;

@property (assign, nonatomic) BOOL isVIP;

@end
