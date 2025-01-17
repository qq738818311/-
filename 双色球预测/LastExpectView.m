//
//  LastExpectView.m
//  双色球预测
//
//  Created by Sifude_PF on 2016/11/25.
//  Copyright © 2016年 CPF. All rights reserved.
//

#import "LastExpectView.h"

#define SPACING_LastExpectView viewAdapter(8)//间距

@implementation LastExpectView

- (instancetype)init
{
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book_detail_note"]];
    [self addSubview:titleImage];
    [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(viewAdapter(12));
        make.left.equalTo(self).offset(viewAdapter(20));
        make.width.height.mas_equalTo(viewAdapter(20));
    }];
    
    self.titleLable = [UILabel new];
    [self addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleImage);
        make.left.equalTo(titleImage.mas_right).offset(viewAdapter(5));
    }];
    self.titleLable.text = @"上期开奖号码:";
    self.titleLable.font = [UIFont systemFontOfSize:viewAdapter(16)];
    self.titleLable.textColor = [UIColor lightGrayColor];
    
    [self layoutIfNeeded];
    
    UIView *numberBg = [UIView new];
    [self addSubview:numberBg];
    [numberBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable.mas_bottom).offset(viewAdapter(10));
        make.left.equalTo(self).offset(viewAdapter(5));
        make.bottom.equalTo(self).offset(viewAdapter(-10));
    }];
    
    UIView *tempView = nil;
    for (int i = 0; i < 7; i++) {
        UILabel *numberLabel = [UILabel new];
        numberLabel.layer.masksToBounds = YES;
        numberLabel.layer.cornerRadius = viewAdapter(30)/2;
        numberLabel.layer.borderColor = i == 6 ? [UIColor blueColor].CGColor : [UIColor redColor].CGColor;
        numberLabel.layer.borderWidth = viewAdapter(1.5);
        numberLabel.tag = 1000 + i;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        //红球白字
        numberLabel.backgroundColor = i == 6 ? [UIColor blueColor] : [UIColor redColor];
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.font = [UIFont boldSystemFontOfSize:viewAdapter(17)];
        //红圈红字
//        numberLabel.textColor = i == 6 ? [UIColor blueColor] : [UIColor redColor];
//        numberLabel.font = [UIFont systemFontOfSize:viewAdapter(17)];
        [numberBg addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(numberBg).offset(viewAdapter(5));
            make.width.height.mas_equalTo(viewAdapter(30));
            NSLog(@"ssssssssss:%f",(WIDTH - self.titleLable.bounds.origin.x - self.titleLable.bounds.size.width - viewAdapter(30) - viewAdapter(8) - SPACING_LastExpectView*6)/7);
            if (!tempView) {
                make.left.equalTo(numberBg).offset(SPACING_LastExpectView);
            }else{
                make.left.equalTo(tempView.mas_right).offset(SPACING_LastExpectView);
            }
            if (i == 6) {
                make.right.equalTo(numberBg).offset(-SPACING_LastExpectView);
                make.bottom.equalTo(numberBg.mas_bottom).offset(viewAdapter(-5)).priorityLow();
            }
        }];
        numberLabel.text = @"--";
        tempView = numberLabel;
    }
    
//    self.startBtn = [UIButton new];
//    [self addSubview:self.startBtn];
//    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(numberBg.mas_right).offset(viewAdapter(10));
////        make.right.equalTo(self).offset(viewAdapter(-25));
//        make.width.height.mas_equalTo(viewAdapter(60));
//        make.centerY.equalTo(self);
//    }];
////    self.startBtn.titleEdgeInsets = UIEdgeInsetsMake(0, viewAdapter(20), 0, 0);
//    self.startBtn.titleLabel.font = [UIFont systemFontOfSize:viewAdapter(14)];
//    [self.startBtn setTitleColor:RGBACOLOR(78, 47, 34, 1) forState:UIControlStateNormal];
//    [self.startBtn setTitle:@"开始" forState:UIControlStateNormal];
//    [self.startBtn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
//    [self.startBtn setTitle:@"停止" forState:UIControlStateSelected];
//    [self.startBtn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateSelected];
//    [self.startBtn setBackgroundImage:[UIImage imageWithColor:RGBACOLOR(253, 185, 17, 1)] forState:UIControlStateNormal];
//    [self.startBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xd4d4d9)] forState:UIControlStateDisabled];
//    self.startBtn.layer.masksToBounds = YES;
//    self.startBtn.layer.cornerRadius = viewAdapter(60)/2;
//    self.startBtn.tag = 2000;
//    [self.startBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮的背景
    self.btnBg = [UIView new];
    [self addSubview:self.btnBg];
    [self.btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(viewAdapter(140));
        make.height.mas_equalTo(viewAdapter(30));
//        make.centerX.equalTo(self);
//        make.top.equalTo(numberBg.mas_bottom).offset(viewAdapter(10));
//        make.bottom.equalTo(self);
        make.centerY.equalTo(numberBg);
        make.left.equalTo(numberBg.mas_right).offset(viewAdapter(5));
        make.right.equalTo(self).offset(viewAdapter(-15));
    }];
//    [self.btnBg.superview layoutIfNeeded];
    self.btnBg.layer.masksToBounds = YES;
    self.btnBg.layer.cornerRadius = viewAdapter(5);
    self.btnBg.backgroundColor = RGBACOLOR(253, 185, 17, 1);
    
    self.startBtn = [UIButton new];
    [self.btnBg addSubview:self.startBtn];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.btnBg);
//        make.width.mas_equalTo(viewAdapter(75));
        make.width.equalTo(self.btnBg).multipliedBy(1.8/3);
    }];
//    self.startBtn.titleEdgeInsets = UIEdgeInsetsMake(0, viewAdapter(20), 0, 0);
    self.startBtn.titleLabel.font = [UIFont boldSystemFontOfSize:viewAdapter(14)];
    [self.startBtn setTitleColor:RGBACOLOR(78, 47, 34, 1) forState:UIControlStateNormal];
    [self.startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [self.startBtn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [self.startBtn setTitle:@"停止" forState:UIControlStateSelected];
    [self.startBtn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateSelected];
    [self.startBtn setBackgroundImage:[UIImage imageWithColor:RGBACOLOR(253, 185, 17, 1)] forState:UIControlStateNormal];
    [self.startBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xd4d4d9)] forState:UIControlStateDisabled];
    self.startBtn.tag = 2000;
    [self.startBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineView = [UIView new];
    [self.btnBg addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startBtn.mas_right);
        make.width.mas_equalTo(viewAdapter(2));
        make.height.equalTo(self.btnBg).offset(viewAdapter(-10));
        make.centerY.equalTo(self.btnBg);
    }];
    self.lineView.backgroundColor = RGBACOLOR(241, 164, 16, 1);
    
    self.saveBtn = [UIButton new];
    [self.btnBg addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.btnBg);
        make.left.equalTo(self.lineView.mas_right);
    }];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:RGBACOLOR(78, 47, 34, 1) forState:UIControlStateNormal];
    [self.saveBtn setBackgroundImage:[UIImage imageWithColor:RGBACOLOR(253, 185, 17, 1)] forState:UIControlStateNormal];
    [self.saveBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xd4d4d9)] forState:UIControlStateDisabled];
    self.saveBtn.titleLabel.font = [UIFont systemFontOfSize:viewAdapter(14)];
    self.saveBtn.tag = 2001;
    [self.saveBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
 
    
//    self.btnBgLineView = [UIView new];
//    [self insertSubview:self.btnBgLineView belowSubview:self.btnBg];
//    [self.btnBgLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(viewAdapter(1.5));
//        make.left.right.equalTo(self);
//        make.centerY.equalTo(self.btnBg);
//    }];
//    self.btnBgLineView.backgroundColor = RGBACOLOR(253, 185, 17, 1);
}

- (void)setLastExpectViewWithText:(NSString *)text
{
    for (int i = 0; i < 7; i++) {
        UILabel *numberLabel = [self viewWithTag:1000 + i];
        if (i == 6 && [self.titleLable.text containsString:@"下期预测号码"]) {
            numberLabel.backgroundColor = [UIColor redColor];
            numberLabel.textColor = [UIColor whiteColor];
//            numberLabel.textColor = [UIColor redColor];
            numberLabel.layer.borderColor = [UIColor redColor].CGColor;
        }
        numberLabel.text = text ? [text substringWithRange:NSMakeRange(i*3, 2)] : @"--";
    }
}

- (void)setButtonEnabled:(BOOL)buttonEnabled
{
    _buttonEnabled = buttonEnabled;
    self.startBtn.enabled = buttonEnabled;
    self.saveBtn.enabled = buttonEnabled;
    self.btnBg.backgroundColor = buttonEnabled ? RGBACOLOR(253, 185, 17, 1) : UIColorFromRGB(0xd4d4d9);
    self.lineView.backgroundColor = buttonEnabled ? RGBACOLOR(241, 164, 16, 1) : [UIColor lightGrayColor];
}

- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 2000) {//开始&停止
        button.selected = !button.selected;
        if (self.buttonClick) {
            self.buttonClick(button, 0);
        }
    }else{//保存
        if (self.buttonClick) {
            self.buttonClick(button, 1);
        }
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
