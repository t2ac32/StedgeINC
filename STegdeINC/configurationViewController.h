//
//  configurationViewController.h
//  STegdeINC
//
//  Created by Lion User on 3/25/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myViewController.h"
#import "ViewController.h"

@interface configurationViewController : UIViewController

#pragma mark - configuracionView
- (IBAction)returnFirstView:(id)sender;
- (IBAction)perfilPressed:(id)sender;
- (IBAction)anadirPressed:(id)sender;
- (IBAction)notificacionesPressed:(id)sender;
- (IBAction)ayudaPressed:(id)sender;
- (IBAction)cerrarSesionPressed:(id)sender;

#pragma mark - returnConfigurationView
- (IBAction)returnConfigurationView:(id)sender;

#pragma mark - perfilView
- (IBAction)perfilPencilPressed:(id)sender;
- (IBAction)keyboardDismiss:(id)sender;
- (IBAction)cambiarContraPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UIButton *pencilButton;

#pragma mark - cambiarContraseñaView
@property (strong, nonatomic) IBOutlet UITextField *contrasenaActualTextField;
@property (strong, nonatomic) IBOutlet UITextField *contrasenaNuevaTextField;
@property (strong, nonatomic) IBOutlet UITextField *contrasenaVerificaTextField;
- (IBAction)cambiarContrasenaPressed:(id)sender;

#pragma mark - anadirContactoView
@property (strong, nonatomic) IBOutlet UITextField *nuevoContactoTextField;
- (IBAction)anadirContactoPressed:(id)sender;


@end
