//
//  ClockView.m
//  时钟
//
//  Created by iiik- on 2021/2/24.
//

#import "ClockView.h"

//每一秒旋转度数
#define perSecA 6
//每一分旋转度数
#define perMinA 6
//每一小时旋转度数
#define perHourA 30
//每一份时针旋转的度数
#define perMinHour 0.5

#define angleZRad(angle) ((angle) / 180.0 * M_PI)

@interface ClockView()

@property (nonatomic, strong)UIImageView *imageView;

//秒针
@property (nonatomic, strong)CALayer *secLayer;

//分针
@property (nonatomic, strong)CALayer *minLayer;

//时针
@property (nonatomic, strong)CALayer *hourLayer;


@end

@implementation ClockView

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (CALayer *)secLayer {
    if (!_secLayer) {
        _secLayer = [CALayer layer];
    }
    return _secLayer;
}
- (CALayer *)minLayer {
    if (!_minLayer) {
        _minLayer = [CALayer layer];
    }
    return _minLayer;
}
- (CALayer *)hourLayer {
    if (!_hourLayer) {
        _hourLayer = [CALayer layer];
    }
    return _hourLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        
        //添加定时器
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secRotation) userInfo:nil repeats:YES];
        
        //定时器一开始隔了一秒才会去调用secRotation这个方法
        //先调用一下
        [self secRotation];
        
    }
    return self;
}

- (void)setUI {
    self.imageView.frame = self.frame;
    self.imageView.image = [UIImage imageNamed:@"WechatIMG636"];
    [self addSubview:self.imageView];
    
    //添加时针
    self.hourLayer.bounds = CGRectMake(0, 0, 3, 50);
    self.hourLayer.anchorPoint = CGPointMake(0.5, 1);
    self.hourLayer.position = CGPointMake(100, 100);
    self.hourLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.imageView.layer addSublayer:self.hourLayer];
    
    //添加分针
    self.minLayer.bounds = CGRectMake(0, 0, 3, 70);
    self.minLayer.anchorPoint = CGPointMake(0.5, 1);
    self.minLayer.position = CGPointMake(100, 100);
    self.minLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.minLayer.cornerRadius = 1.5;
    [self.imageView.layer addSublayer:self.minLayer];
    
    //添加秒针
    self.secLayer.bounds = CGRectMake(0, 0, 1, 80);
    self.secLayer.anchorPoint = CGPointMake(0.5, 1);
    self.secLayer.position = CGPointMake(100, 100);
    self.secLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.imageView.layer addSublayer:self.secLayer];
    
}

- (void)secRotation {
    //根据日历获取当前的秒数
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    //秒针
    NSInteger sec = comps.second + 1;
    self.secLayer.transform = CATransform3DMakeRotation(angleZRad(sec * perSecA), 0, 0, 1);
    
    //分针
    NSInteger min = comps.minute;
    self.minLayer.transform = CATransform3DMakeRotation(angleZRad(min * perMinA), 0, 0, 1);
    
    //时针
    NSInteger hour = comps.hour * perHourA + comps.minute * perMinHour ;
    self.hourLayer.transform = CATransform3DMakeRotation(angleZRad(hour), 0, 0, 1);
}
@end
