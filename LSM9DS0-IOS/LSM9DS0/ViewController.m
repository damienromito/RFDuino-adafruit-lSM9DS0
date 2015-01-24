//
//  ViewController.m
//  LSM9DS0
//
//  Created by Damien Romito on 24/01/15.
//  Copyright (c) 2015 Damien Romito. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"
#import "RFduinoManagerDelegate.h"
#import "RFduinoManager.h"
#import "RFduino.h"

@interface ViewController ()<RFduinoDelegate, RFduinoManagerDelegate, RFduinoDelegate>
@property (nonatomic, strong) RFduinoManager *rfduinoManager;
@property (strong, nonatomic) RFduino *rfduino;
@end

@implementation ViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rfduinoManager = [RFduinoManager sharedRFduinoManager];
        self.rfduinoManager.delegate = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - RfduinoDelegate methods


- (void)didReceive:(NSData *)data
{
    
    NSInteger value = dataInt(data);
//    if (value > 0 && value <= 8) {
//        self.penColor = dataInt(data);
//    }
//    
    NSLog(@" Accel X: %i", value);
    //self.penColor = PenColorBlue;
}


#pragma mark - RfduinoDiscoveryDelegate methods

- (void)didDiscoverRFduino:(RFduino *)rfduino
{
    NSLog(@"didDiscoverRFduino");
    //    if (! editingRow) {
    //        NSLog(@"reloadData");
    //        [self.tableView reloadData];
    //    }
}

- (void)didUpdateDiscoveredRFduino:(RFduino *)rfduino
{
    NSLog(@"RFDUINO %@",self.rfduinoManager.rfduinos);

    
    for (RFduino *rfduino in self.rfduinoManager.rfduinos ) {
        
        if ([rfduino.name isEqualToString:@"RFduino"]) {
            NSLog(@"RFDUINO CONNECTED");
            [self.rfduinoManager connectRFduino:rfduino];
        }
    }
    //    if (! editingRow) {
    //        [self.tableView reloadData];
    //    }
}

- (void)didConnectRFduino:(RFduino *)rfduino
{
    NSLog(@"didConnectRFduino");


    [self.rfduinoManager stopScan];
    NSLog(@"rfduino %@", self.rfduino);
    
    
    //
    //    loadService = false;
}

- (void)didLoadServiceRFduino:(RFduino *)rfduino
{
    self.rfduino = rfduino;
    [self.rfduino setDelegate:self];
    
    //    AppViewController *viewController = [[AppViewController alloc] init];
    //    viewController.rfduino = rfduino;
    //
    //    loadService = true;
    //    [[self navigationController] pushViewController:viewController animated:YES];
}

- (void)didDisconnectRFduino:(RFduino *)rfduino
{
    NSLog(@"didDisconnectRFduino");
    //
    //    if (loadService) {
    //        [[self navigationController] popViewControllerAnimated:YES];
    //    }
    //
    
    [self.rfduinoManager startScan];
    //    [self.tableView reloadData];
}

@end
