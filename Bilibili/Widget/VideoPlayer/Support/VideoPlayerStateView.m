//
//  VideoPlayerStateView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "VideoPlayerStateView.h"

@interface VideoPlayerStateView ()

@property (nonatomic, copy) NSString * text;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation VideoPlayerStateView

@synthesize text = _text;

+(instancetype)defaultView
{
    return [[NSBundle mainBundle] loadNibNamed:@"VideoPlayerStateView" owner:nil options:nil].firstObject;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    NSArray * images = @[[UIImage imageNamed:@"ani_loading_1"],
                         [UIImage imageNamed:@"ani_loading_2"],
                         [UIImage imageNamed:@"ani_loading_3"],
                         [UIImage imageNamed:@"ani_loading_4"],
                         [UIImage imageNamed:@"ani_loading_5"]];
    
    _imageView.animationImages = images;
    _imageView.animationDuration = 0.5;
    _imageView.animationRepeatCount = 0;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview)
        [_imageView startAnimating];
    else [_imageView stopAnimating];
}


-(void)log:(NSString *)text
{
    self.text = [NSString stringWithFormat:@"%@\n%@", self.text, text];
    [_textView sizeToFit];
}

-(void)clear
{
    self.text = @"";
    [_textView sizeToFit];
}

#pragma mark Getter & Setter

-(void)setText:(NSString *)text
{
    _text = text;
    _textView.text = text;
}

- (NSString *)text
{
    _text = _textView.text;
	if (_text == nil)
        _text = [[NSString alloc] init];
	return _text;
}

@end
