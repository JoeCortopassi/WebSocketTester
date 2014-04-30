//
//  MainViewController.m
//  TestJavascriptBridge
//
//  Created by Joseph Cortopassi on 4/26/14.
//  Copyright (c) 2014 Joseph Cortopassi. All rights reserved.
//

#import "MainViewController.h"
#import "TestObject.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SRWebSocket.h"
#import "SocketIO.h"
#import "SocketIOPacket.h"



@interface MainViewController () <SRWebSocketDelegate>
@property (nonatomic, strong) SocketIO *socketIO;
@property (nonatomic, strong) UITextField *inputMessage;
@end




@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.socketIO = [[SocketIO alloc] initWithDelegate:self];
        [self.socketIO connectToHost:@"192.168.1.8" onPort:8000];
        self.socketIO.delegate = self;
        
        self.inputMessage = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 250, 40)];
        [self.inputMessage addTarget:self action:@selector(checkInput) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:self.inputMessage];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) checkInput
{
    NSString *sentMessage = self.inputMessage.text;
    NSLog(@"-> %@", sentMessage);
    [self.socketIO sendMessage:sentMessage];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}









- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet;
{
    NSLog(@"<- %@", [packet data]);
    self.inputMessage.text = [packet data];
}




@end
