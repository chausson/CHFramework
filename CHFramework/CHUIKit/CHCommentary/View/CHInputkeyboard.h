//
//  CHInputkeyboard.h
//  CommentaryModule
//
//  Created by Chausson on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CHCommentarySendDelegate <NSObject>

- (void)pressSendBtn:(NSString *)text;

@end

@interface CHInputkeyboard : UIView<UITextViewDelegate>

@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)UIButton *sendBtn;

//@property(nonatomic,strong)UIButton *addBtn;

@property(nonatomic,strong)UIButton *recordBtn;

@property(nonatomic,weak)  id<CHCommentarySendDelegate>obj;
/**
 *  @brief  初始化输入框API
 *  @param  controller预导入视图控制器 签订CHCommentarySendDelegate协议
 *  @return 返回实例对象
 */
- (instancetype)initWithOwner:(UIViewController <CHCommentarySendDelegate>*)controller ;

@end
