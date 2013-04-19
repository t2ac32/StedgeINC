//
//  ViewController.h
//  STegdeINC
//
//  Created by Lion User on 3/24/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myViewController.h"

@interface ViewController : UIViewController
- (IBAction)startScreenPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *rememberButton;
- (IBAction)loginPressed:(id)sender;
- (IBAction)registrarPressed:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)infoPressed:(id)sender;
- (IBAction)rememberPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *registroMail;
@property (strong, nonatomic) IBOutlet UITextField *registroNombre;
@property (strong, nonatomic) IBOutlet UITextField *registroApellido;
@property (strong, nonatomic) IBOutlet UITextField *registroPassword;
@property (strong, nonatomic) IBOutlet UITextField *registroVerificarPassword;
@property (strong, nonatomic) IBOutlet UIButton *registrarsePressed;
- (IBAction)cancelRegistroPressed:(id)sender;
- (IBAction)registroDismissKeyboard:(id)sender;
- (IBAction)registrarsePressed:(id)sender;


@end
