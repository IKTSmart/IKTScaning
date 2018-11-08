//
//  ViewController.m
//  IKTScaning
//
//  Created by bcikt on 2018/10/17.
//  Copyright © 2018 bcikt. All rights reserved.
//

#import "ViewController.h"
#import "IKTScaning.h"

@interface ViewController ()

@property (nonatomic, strong) IKTScaning *scaning;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scaning = [[IKTScaning alloc] initWithFrame:CGRectMake(50, 100, 300, 300)];
    [self.view addSubview:_scaning];
    
    self.view.backgroundColor = [UIColor colorWithRed:0x21/255.0 green:0x93/255.0 blue:0xf4/255.0 alpha:1.0];
    
}
- (IBAction)startAction:(id)sender {
    
    [self.scaning start];
}

- (IBAction)endAction:(id)sender {
    
    [self.scaning end];
}

@end
