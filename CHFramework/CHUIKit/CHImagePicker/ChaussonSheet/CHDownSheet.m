//
//  CHDownSheet.m
//
//
//  Created by Chausson on 14-7-19.
//  Copyright (c) 2014年 Chausson. All rights reserved.
//
#define KNavitionBarHeight 64
#import "CHDownSheet.h"
@interface CHDownSheet()
@property (assign ,nonatomic) BOOL isTranslucent;
@end
@implementation CHDownSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithlist:(NSArray *)list height:(CGFloat)height{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = RGBACOLOR(0, 0, 0,.7);
        view = [[UITableView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth,49*[list count]+7) style:UITableViewStylePlain];
        view.dataSource = self;
        view.delegate = self;
        view.separatorStyle = NO;
        listData = list;
        view.scrollEnabled = NO;
        [self addSubview:view];

    }
    return self;
}
- (void)showInView:(UIViewController *)Sview
{
    
    if(Sview==nil){
        //        [[UIApplication sharedApplication].delegate.window addSubview:self];
    }else{
        //[view addSubview:self];
        self.isTranslucent =  !Sview.navigationController.navigationBar.isTranslucent && Sview.navigationController.navigationBar;
    
        [Sview.view addSubview:self];
        
    }
    [self animeData];
}
-(void)animeData{
    //self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    CGFloat orginY = ScreenHeight - view.frame.size.height ;
    if (self.isTranslucent) {
        orginY-=KNavitionBarHeight;
    }
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = RGBACOLOR(0, 0, 0,.7);
        [UIView animateWithDuration:.25 animations:^{
            [view setFrame:CGRectMake(view.frame.origin.x, orginY, view.frame.size.width, view.frame.size.height)];
        }];
    } completion:^(BOOL finished) {
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}

-(void)tappedCancel{
    [UIView animateWithDuration:.25 animations:^{
        [view setFrame:CGRectMake(0, ScreenHeight,ScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listData count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if(indexPath.row == listData.count-1){
      UITableViewCell*  cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gap"];
        cell.contentView.backgroundColor = RGBCOLOR(214, 214, 221);
         return cell;
    }else {
        CHDownSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        if(cell==nil){
            
           cell = [[CHDownSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if (indexPath.row == listData.count) {
            [cell setData:[listData objectAtIndex:listData.count-1]];
        }else {
            [cell setData:[listData objectAtIndex:indexPath.row]];
        }
        
         return cell;
    }
    
    
    
    
    
    // Configure the cell...
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tappedCancel];
    if(_delegate!=nil && [_delegate respondsToSelector:@selector(didSelectIndex:)]){
        [_delegate didSelectIndex:indexPath.row];
        
        return;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == listData.count-1){
        return 7;
    }else{
        return 49;
    }
}
- (void)dealloc{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end


