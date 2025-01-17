//
//  OpenAwardView.m
//  双色球预测
//
//  Created by Sifude_PF on 2016/11/24.
//  Copyright © 2016年 CPF. All rights reserved.
//

#import "OpenAwardView.h"
#import "ViewController.h"

#define SPACING viewAdapter(10)//间距

static TCTimer *tcd;

@implementation OpenAwardView

- (instancetype)init
{
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.expectLabel = [UILabel new];
    [self addSubview:self.expectLabel];
    [self.expectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(viewAdapter(5));
        make.left.equalTo(self);
    }];
    self.expectLabel.text = @"第xxxxxxx期";
    self.expectLabel.font = [UIFont boldSystemFontOfSize:viewAdapter(18)];
    self.expectLabel.textColor = [UIColor whiteColor];
    
    self.timeLabel = [UILabel new];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(viewAdapter(0));
        make.centerY.equalTo(self.expectLabel);
    }];
    self.timeLabel.text = @"开奖日期:xxxx-xx-xx(周xx)";
    self.timeLabel.font = [UIFont systemFontOfSize:viewAdapter(16)];
    self.timeLabel.textColor = [UIColor whiteColor];

    UIView *tempView = nil;
    for (int i = 0; i < 7; i++) {
        UILabel *numberLabel = [UILabel new];
        numberLabel.layer.borderColor = i == 6 ? [UIColor blueColor].CGColor : [UIColor redColor].CGColor;
        numberLabel.layer.borderWidth = viewAdapter(2.5);
        numberLabel.layer.masksToBounds = YES;
        numberLabel.layer.cornerRadius = ((WIDTH - viewAdapter(40) - SPACING*6)/7)/2;
        numberLabel.tag = 1000 + i;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = i == 6 ? [UIColor blueColor] : [UIColor redColor];
//        numberLabel.layer.masksToBounds = YES;
//        numberLabel.backgroundColor = RGBACOLOR(255, 255, 255, 0.6);
        numberLabel.font = [UIFont systemFontOfSize:viewAdapter(25)];
        [self addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.expectLabel.mas_bottom).offset(viewAdapter(10));
            make.width.height.mas_equalTo((WIDTH - viewAdapter(40) - SPACING*6)/7);
            if (!tempView) {
                make.left.equalTo(self);
            }else{
                make.left.equalTo(tempView.mas_right).offset(SPACING);
            }
            if (i == 5) {
                make.right.equalTo(self).priorityLow();
                make.bottom.equalTo(self.mas_bottom).offset(viewAdapter(-5)).priorityLow();
            }
        }];
        numberLabel.text = @"--";
        tempView = numberLabel;
    }
}

- (void)setOpenAwardViewWithModel:(SaveModel *)model andWiningNumers:(NSArray *)numbers
{
    [ToolClass cancelTimeCountDownWith:tcd];
    
    self.expectLabel.text = [NSString stringWithFormat:@"第%@期", model.expect];
    self.timeLabel.text = [NSString stringWithFormat:@"开奖日期:%@", model.time];
    for (int i = 0; i < 7; i++) {
        UILabel *numberLabel = [self viewWithTag:1000 + i];
        NSString *str = [model.number substringWithRange:NSMakeRange(i*3, 2)];
        if (i < 6) {
            if ([numbers containsObject:str]) {
                numberLabel.backgroundColor = [UIColor redColor];
                numberLabel.textColor = [UIColor whiteColor];
            }else{
                numberLabel.backgroundColor = [UIColor clearColor];
                numberLabel.textColor = [UIColor redColor];
            }
        }else{
//            NSLog(@"tempCurrentChase == %@", tempCurrentChase);
            if ([str isEqualToString:tempCurrentChase]) {
                tcd = [ToolClass timeCountDownWithCount:1000 perTime:0.2 inProgress:^(int time) {
                    numberLabel.layer.borderColor = RANDOMCOLOR.CGColor;
                    numberLabel.backgroundColor = RGBACOLOR(arc4random()%255, arc4random()%255, arc4random()%255, 0.5);
                } completion:^{
                    numberLabel.layer.borderColor = [UIColor blueColor].CGColor;
                    numberLabel.backgroundColor = [UIColor clearColor];
                }];
            }else{
                numberLabel.layer.borderColor = [UIColor blueColor].CGColor;
                numberLabel.backgroundColor = [UIColor clearColor];
            }
        }
        numberLabel.text = str;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
