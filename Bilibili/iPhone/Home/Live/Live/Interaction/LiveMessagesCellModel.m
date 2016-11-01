//
//  LiveMessagesCellModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/25.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveMessagesCellModel.h"
#import "extension.h"

@implementation LiveMessagesCellModel

- (instancetype)initWithLiveMessage:(LiveMessageModel *)liveMessage
{
    if (self = [super init])
    {
        _liveMessage = liveMessage;
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    NSString * string = _liveMessage.text.copy;
    
    NSMutableAttributedString * aString = [NSMutableAttributedString new];
    aString.lineSpacing = 4;
    
    //Presets...
    UIFont * font = [UIFont systemFontOfSize:12];
    
    //Medal.
    if (_liveMessage.medal && _liveMessage.medal.count >= 2)
    {
        LiveMessageMedal * medal = [LiveMessageMedal defaultMedal];
        medal.titleLabel.text = _liveMessage.medal[1];
        medal.levelLabel.text = [NSString stringWithFormat:@"%02ld", (long)[_liveMessage.medal[0] integerValue]];
        
        NSAttributedString * attachment = [NSAttributedString attachmentStringWithContent:medal contentMode:UIViewContentModeBottom attachmentSize:medal.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [aString appendAttributedString: attachment];
        
        [aString appendString:@" "];
    }
    
    //Level.
    if (_liveMessage.user_level && _liveMessage.user_level.count)
    {
        UILabel * label = [UILabel new];
        label.text = [NSString stringWithFormat:@" UL%02ld ", (long)[_liveMessage.user_level.firstObject integerValue]];
        label.textColor = [UIColor whiteColor];
        label.font = font;
        label.backgroundColor = [UIColor orangeColor];
        label.layer.cornerRadius = 2.5;
        label.clipsToBounds = YES;
        [label sizeToFit];
        
        NSAttributedString * attachment = [NSAttributedString attachmentStringWithContent:label contentMode:UIViewContentModeBottom attachmentSize:label.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [aString appendAttributedString: attachment];
        
        [aString appendString:@" "];
    }
    
    //Username.
    NSString * username = [NSString stringWithFormat:@"%@: ", _liveMessage.nickname];
    NSMutableAttributedString * nameString = [[NSMutableAttributedString alloc] initWithString:username];
    nameString.color = [UIColor lightGrayColor];
    nameString.font = font;
    [aString appendAttributedString:nameString];
    
    //Context.
    NSMutableAttributedString * textString = [[NSMutableAttributedString alloc] initWithString:string];
    textString.attributes = @{NSFontAttributeName : font,
                              NSForegroundColorAttributeName : [UIColor blackColor]};
    [aString appendAttributedString:textString];
    
    //Create Layout.
    YYTextContainer * container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - LIVE_MESSAGES_MARGIN * 2, CGFLOAT_MAX)];
    YYTextLayout * layout = [YYTextLayout layoutWithContainer:container text:aString];
    
    _layout = layout;
    _size = layout.textBoundingSize;
}



@end
