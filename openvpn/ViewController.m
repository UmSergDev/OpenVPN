//
//  ViewController.m
//  openvpn
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NEVPNManager *manager = [NEVPNManager sharedManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vpnConnectionStatusChanged) name:NEVPNStatusDidChangeNotification object:nil];
    [manager loadFromPreferencesWithCompletionHandler:^(NSError *error) {
        if(error) {
            NSLog(@"Load error: %@", error);
        }}];
    NEVPNProtocolIPSec *p = [[NEVPNProtocolIPSec alloc] init];
    p.username = @“[My username]”;
    p.passwordReference = [KeyChainAccess loadDataForServiceNamed:@"VIT"];
    p.serverAddress = @“[My Server Address]“;
    p.authenticationMethod = NEVPNIKEAuthenticationMethodCertificate;
    p.localIdentifier = @“[My Local identifier]”;
    p.remoteIdentifier = @[My Remote identifier]”;
    p.useExtendedAuthentication = NO;
    p.identityData = [My VPN certification private key];
    p.disconnectOnSleep = NO;
    [manager setProtocol:p];
    [manager setOnDemandEnabled:NO];
    [manager setLocalizedDescription:@"VIT VPN"];
    NSArray *array = [NSArray new];
    [manager setOnDemandRules: array];
    NSLog(@"Connection desciption: %@", manager.localizedDescription);
    NSLog(@"VPN status:  %i", manager.connection.status);
    [manager saveToPreferencesWithCompletionHandler:^(NSError *error) {
        if(error) {
            NSLog(@"Save error: %@", error);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
