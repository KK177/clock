//
//  ViewController.m
//  时钟
//
//  Created by iiik- on 2021/2/24.
//

#import "ViewController.h"
#import "ClockView.h"

@interface ViewController ()

@property (nonatomic, strong)ClockView *clockView;

@end

@implementation ViewController

- (ClockView *)clockView {
    if (!_clockView) {
        _clockView = [[ClockView alloc] initWithFrame:CGRectMake(55, 100, 200, 200)];
    }
    return _clockView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
}

- (void)setUI {
    [self.view addSubview:self.clockView];
}

@end
