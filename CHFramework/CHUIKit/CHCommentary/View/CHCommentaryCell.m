//
//  CHCommentaryCell.m
//  CommentaryModule
//
//  Created by Chausson on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHCommentaryCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define SCREENWITH   [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define kWidthFactor ([UIScreen mainScreen].bounds.size.width/375)
#define kHeightFactor ([UIScreen mainScreen].bounds.size.height/667)

#define COMMENTARYNAMEFONTSIZE 15
#define COMMENTARYTIMEFONTSIZE 10
#define COMMENTARYCONTENTFONTSIZE 16
#define COMMENTARYPRAISENUMFONTSIZE 15

CGFloat labelHeight;
@implementation CHCommentaryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        [self prepareLayout];
        
    }
    return self;
    
}

- (void)prepareLayout{
    
    
    _nameBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    
    _headImage  = [[UIImageView alloc]init];
    
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:COMMENTARYTIMEFONTSIZE*kWidthFactor];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:COMMENTARYCONTENTFONTSIZE*kWidthFactor];
    
    
    _praiseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
 
    
    _vipSymbolBtn = [UIButton buttonWithType:UIButtonTypeSystem];


    [self.contentView addSubview:self.nameBtn];
    [self.contentView addSubview:self.headImage];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.praiseBtn];
    [self.contentView addSubview:self.vipSymbolBtn];
}

- (void)loadDataWithVM:(CHCommentaryCellVM *)model{
    
    _nameBtn.titleLabel.numberOfLines = 1;
    _nameBtn.titleLabel.font = [UIFont systemFontOfSize:COMMENTARYNAMEFONTSIZE*kWidthFactor];
    NSAttributedString* atrName = [[NSAttributedString alloc] initWithString:model.name];
    NSRange nameRange = NSMakeRange(0, atrName.length);
    NSDictionary* dicName = [atrName attributesAtIndex:0 effectiveRange:&nameRange];
    CGSize nameSize = [model.name boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicName context:nil].size;
    _nameBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_nameBtn setTitle:model.name forState:UIControlStateNormal];
    _nameBtn.frame = CGRectMake(55*kWidthFactor, 5*kHeightFactor, nameSize.width, 5*kHeightFactor);
    CGFloat vipSymbolY = _nameBtn.frame.size.width + 55*kWidthFactor;
    [_nameBtn sizeToFit];
    _nameBtn.userInteractionEnabled = NO;
    
    _headImage.frame = CGRectMake(10*kWidthFactor, 10*kHeightFactor, 40*kWidthFactor, 40*kHeightFactor);
    NSURL *url  =[NSURL URLWithString:model.imageUrl];
    
    [_headImage  sd_setImageWithURL:url];
    [_headImage.layer setCornerRadius:20*kWidthFactor];
    [_headImage.layer setMasksToBounds:YES];
    
    
    _timeLabel.frame = CGRectMake(55*kWidthFactor, 35*kHeightFactor, 150*kWidthFactor, 15*kHeightFactor);
    _timeLabel.text = model.time;
    
    
    _contentLabel.text = model.content;
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    _contentLabel.frame = CGRectMake(55*kWidthFactor, 50*kHeightFactor, SCREENWITH - 80*kWidthFactor, labelHeight);
   [_contentLabel sizeToFit];

    
    model.praiseNum =100;
    NSString *praiseString = [NSString stringWithFormat:@"%ld",model.praiseNum];
    [_praiseBtn setTitle:praiseString forState:UIControlStateNormal];
    [_praiseBtn setTintColor:[UIColor grayColor]];
    _praiseBtn.frame = CGRectMake(SCREENWITH-60*kWidthFactor, 5*kHeightFactor, 100, 20*kHeightFactor);
    [_praiseBtn sizeToFit];
    [_praiseBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [_praiseBtn setImage:[UIImage imageNamed:@"likehighlight"] forState:UIControlStateSelected];
    _praiseBtn.userInteractionEnabled = NO;


    _vipSymbolBtn.frame = CGRectMake(vipSymbolY, 5*kHeightFactor, 15, 15);
    [_vipSymbolBtn setImage:[UIImage imageNamed:@"crown"] forState:UIControlStateNormal];
    if (model.isVIP) {
        _vipSymbolBtn.hidden = NO;
    }
    else{
        _vipSymbolBtn.hidden = YES;
    }
}

+ (CGFloat )calculateHengthViewModel:(CHCommentaryCellVM *)viewModel{
    
    
    NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:viewModel.content];
    NSRange range = NSMakeRange(0, atrString.length);
    NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
    CGSize size = [viewModel.content boundingRectWithSize:CGSizeMake(SCREENWITH - 80*kWidthFactor, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    UILabel *label = [[UILabel alloc]initWithFrame: CGRectMake(55*kWidthFactor, 50*kHeightFactor, SCREENWITH - 80*kWidthFactor, size.height)];
    label.text = viewModel.content;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:COMMENTARYCONTENTFONTSIZE*kWidthFactor];
    label.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    [label sizeToFit];
    
    labelHeight = label.frame.size.height;
    
    size = CGSizeMake(SCREENWITH, labelHeight + 60*kHeightFactor);
    
    return  size.height;
}
+ (NSString *)commentaryIdentifier{
    return @"CommentraryCell";
}
@end
