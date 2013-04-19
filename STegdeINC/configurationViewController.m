//
//  configurationViewController.m
//  STegdeINC
//
//  Created by Lion User on 3/25/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import "configurationViewController.h"

@interface configurationViewController ()

@end

@implementation configurationViewController
NSString *emailC = @"",*passwordC=@"",*firstNameC=@"",*lastNameC=@"";
int idUser = 18;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([firstNameC isEqualToString:@""]){
        webData = [NSMutableData new];
        NSString *url = [[NSString alloc] initWithFormat:@"http://socialmemo.herokuapp.com/users/%d",idUser];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        //Creating the NSURLConnection
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                      delegate:self];
        
        if(!connection){
            NSLog(@"Hubo un error al cargar del servidor");
        }
    }
    nameTextField.text = firstNameC;
    mailLabel.text = emailC;
    x=0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - configurationView functions
- (IBAction)returnFirstView:(id)sender {
    myViewController *conf = [[myViewController alloc] init];
    conf = [self.storyboard instantiateViewControllerWithIdentifier:@"firstView"];
    conf.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:conf animated:YES completion:nil];
}

- (IBAction)perfilPressed:(id)sender {
    [contrasenaVerificaTextField resignFirstResponder];
    [contrasenaNuevaTextField resignFirstResponder];
    [contrasenaActualTextField resignFirstResponder];
    configurationViewController *conf = [[configurationViewController alloc] init];
    conf = [self.storyboard instantiateViewControllerWithIdentifier:@"perfilView"];
    conf.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:conf animated:YES completion:nil];
}

- (IBAction)anadirPressed:(id)sender {
    configurationViewController *conf = [[configurationViewController alloc] init];
    conf = [self.storyboard instantiateViewControllerWithIdentifier:@"añadirContactoView"];
    conf.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:conf animated:YES completion:nil];
}

- (IBAction)notificacionesPressed:(id)sender {
    configurationViewController *conf = [[configurationViewController alloc] init];
    conf = [self.storyboard instantiateViewControllerWithIdentifier:@"notificacionesView"];
    conf.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:conf animated:YES completion:nil];
}

- (IBAction)ayudaPressed:(id)sender {
    configurationViewController *conf = [[configurationViewController alloc] init];
    conf = [self.storyboard instantiateViewControllerWithIdentifier:@"ayudaView"];
    conf.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:conf animated:YES completion:nil];
}

- (IBAction)cerrarSesionPressed:(id)sender {
    firstNameC = @"";
    lastNameC = @"";
    passwordC = @"";
    emailC = @"";
    ViewController *conf = [[ViewController alloc] init];
    conf = [self.storyboard instantiateViewControllerWithIdentifier:@"loginView"];
    conf.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:conf animated:YES completion:nil];
}

#pragma mark - return configurationView
- (IBAction)returnConfigurationView:(id)sender {
    [nameTextField resignFirstResponder];
    [contrasenaVerificaTextField resignFirstResponder];
    [contrasenaNuevaTextField resignFirstResponder];
    [contrasenaActualTextField resignFirstResponder];
    [nuevoContactoTextField resignFirstResponder];
    configurationViewController *conf = [[configurationViewController alloc] init];
    conf = [self.storyboard instantiateViewControllerWithIdentifier:@"configuracionView"];
    conf.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:conf animated:YES completion:nil];
}

- (IBAction)keyboardDismiss:(id)sender {
    [nameTextField resignFirstResponder];
    [contrasenaVerificaTextField resignFirstResponder];
    [contrasenaNuevaTextField resignFirstResponder];
    [contrasenaActualTextField resignFirstResponder];
    [nuevoContactoTextField resignFirstResponder];
}

#pragma mark - perfilView functions
@synthesize nameTextField,mailLabel,pencilButton;
int x = 0;

- (IBAction)perfilPencilPressed:(id)sender {
    if (x==0) {
        [pencilButton setImage:[UIImage imageNamed:@"Default Image"] forState:UIControlStateNormal];
        [nameTextField setUserInteractionEnabled:TRUE];
        [nameTextField becomeFirstResponder];
        x=1;
    }
    else {
        //CAMBIAR EL NOMBRE DE USUARIO
        webData = [NSMutableData new];
        NSString *url = [[NSString alloc] initWithFormat:@"http://socialmemo.herokuapp.com/users/%d",idUser];
        
        NSMutableDictionary *user = [NSMutableDictionary new];
        NSMutableDictionary *userParameters = [NSMutableDictionary new];
        //Setting the parameters of the user
        [userParameters setObject:nameTextField.text                       forKey:@"first_name"];        
        
        [user setObject:userParameters forKey:@"user"];
        
        //Making NSData from NSMutableDictionary
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:user
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
        //Changing from NSData to NSString;
        NSString *stringToSend = [[NSString alloc] initWithData:data
                                                       encoding:NSUTF8StringEncoding];
        
        //Creating the NSMutableRequest
        NSString *params = [[NSString alloc] initWithFormat:@"%@",stringToSend];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"PUT"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        //Creating the NSURLConnection
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                      delegate:self];
        if(!connection){
            NSLog(@"Hubo un error");
        }
        else{
            firstNameC = nameTextField.text;
            [pencilButton setImage:[UIImage imageNamed:@"Pencil.png"] forState:UIControlStateNormal];
            [nameTextField setUserInteractionEnabled:FALSE];
            [nameTextField resignFirstResponder];
            x=0;
            NSLog(@"lo hizo");
        }
    }
}

- (IBAction)cambiarContraPressed:(id)sender {
    [nameTextField resignFirstResponder];
    configurationViewController *conf = [[configurationViewController alloc] init];
    conf = [self.storyboard instantiateViewControllerWithIdentifier:@"cambiarContrasenaView"];
    conf.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:conf animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==nameTextField) {
        //CAMBIAR EL NOMBRE DE USUARIO
        webData = [NSMutableData new];
        NSString *url = [[NSString alloc] initWithFormat:@"http://socialmemo.herokuapp.com/users/%d",idUser];
        
        NSMutableDictionary *user = [NSMutableDictionary new];
        NSMutableDictionary *userParameters = [NSMutableDictionary new];
        //Setting the parameters of the user
        [userParameters setObject:nameTextField.text                       forKey:@"first_name"];
        
        [user setObject:userParameters forKey:@"user"];
        
        //Making NSData from NSMutableDictionary
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:user
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
        //Changing from NSData to NSString;
        NSString *stringToSend = [[NSString alloc] initWithData:data
                                                       encoding:NSUTF8StringEncoding];
        
        //Creating the NSMutableRequest
        NSString *params = [[NSString alloc] initWithFormat:@"%@",stringToSend];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"PUT"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        //Creating the NSURLConnection
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                      delegate:self];
        if(!connection){
            NSLog(@"Hubo un error");
        }
        else{
            firstNameC = nameTextField.text;
            [pencilButton setImage:[UIImage imageNamed:@"Pencil.png"] forState:UIControlStateNormal];
            [nameTextField setUserInteractionEnabled:FALSE];
            [nameTextField resignFirstResponder];
            x=0;
        }
    }
    else if (textField==contrasenaActualTextField){
        [contrasenaNuevaTextField becomeFirstResponder];
    }
    else if (textField==contrasenaNuevaTextField){
        [contrasenaVerificaTextField becomeFirstResponder];
    }
    else if (textField==contrasenaVerificaTextField){
        [contrasenaVerificaTextField resignFirstResponder];
    }
    else if (textField==nuevoContactoTextField){
        [nuevoContactoTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark -cambiarContraseñaView
@synthesize contrasenaActualTextField,contrasenaNuevaTextField,contrasenaVerificaTextField;

- (IBAction)cambiarContrasenaPressed:(id)sender {
    if([contrasenaActualTextField.text isEqual:passwordC]){//CHECAR LA CONTRASEÑA DEL USUARIO
        if (contrasenaNuevaTextField.text.length > 3 && contrasenaVerificaTextField.text.length > 3) {
            if ([contrasenaNuevaTextField.text isEqual:contrasenaVerificaTextField.text]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerta" message:@"¿Estas seguro que quieres cambiar tu contraseña?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Cambiar", nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sin coincidencia" message:@"La nueva contraseña y la verficación no coinciden" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];                
                [alert show];
                [contrasenaVerificaTextField becomeFirstResponder];
            }
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Numero de Caracteres" message:@"El número de caracteres minimo es de 4" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];            
            [alert show];
            [contrasenaNuevaTextField becomeFirstResponder];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contraseña Incorrecta" message:@"La contraseña actual escrita es incorrecta" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];        
        [alert show];
        [contrasenaActualTextField becomeFirstResponder];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        //CAMBIAR LA CONTRASEÑA
        [contrasenaVerificaTextField resignFirstResponder];
        [contrasenaNuevaTextField resignFirstResponder];
        [contrasenaActualTextField resignFirstResponder];        webData = [NSMutableData new];
        passwordC = contrasenaNuevaTextField.text;
        NSString *url = [[NSString alloc] initWithFormat:@"http://socialmemo.herokuapp.com/users/%d",idUser];
        
        NSMutableDictionary *user = [NSMutableDictionary new];
        NSMutableDictionary *userParameters = [NSMutableDictionary new];
        //Setting the parameters of the user
        [userParameters setObject:contrasenaNuevaTextField.text                       forKey:@"password"];
        
        [user setObject:userParameters forKey:@"user"];
        
        //Making NSData from NSMutableDictionary
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:user
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
        //Changing from NSData to NSString;
        NSString *stringToSend = [[NSString alloc] initWithData:data
                                                       encoding:NSUTF8StringEncoding];
        
        //Creating the NSMutableRequest
        NSString *params = [[NSString alloc] initWithFormat:@"%@",stringToSend];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"PUT"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        //Creating the NSURLConnection
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                      delegate:self];
        if(!connection){
            NSLog(@"Hubo un error");
        }
        else{
            passwordC = contrasenaNuevaTextField.text;
            configurationViewController *conf = [[configurationViewController alloc] init];
            conf = [self.storyboard instantiateViewControllerWithIdentifier:@"perfilView"];
            conf.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:conf animated:YES completion:nil];
        }
    }
}

#pragma mark - anadirContactoView
@synthesize nuevoContactoTextField;
- (IBAction)anadirContactoPressed:(id)sender {
    [nuevoContactoTextField resignFirstResponder];
    if([nuevoContactoTextField.text isEqual:@"usuario@mail.com"]){//VER SI EL USUARIO EXISTE
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Usuario Añadido" message:@"El usuario ha sido añadido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        nuevoContactoTextField.text = @"";
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"El usuario no existe" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [nuevoContactoTextField becomeFirstResponder];
    }
}

#pragma mark - notificacionesView

#pragma mark - ayudaView
        

#pragma mark - HTTP Request
NSMutableData *webData;
        
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [webData setLength:0];
    //NSLog(@"didReceiveResponse");
}
        
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webData appendData:data];
    //NSLog(@"didReceiveData");
}
        
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError *error;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:webData
                                                                     options:kNilOptions
                                                                       error:&error];
    //NSLog(@"Response: %@", response);
    NSString *aux = [[NSString alloc] initWithFormat:@"%@",response];
    NSLog(@"Comunico algo");
    if(![aux isEqual:@"(null)"]){
        firstNameC = [[response valueForKey:@"user"] valueForKey:@"first_name"];
        lastNameC = [[response valueForKey:@"user"] valueForKey:@"last_name"];
        emailC = [[response valueForKey:@"user"] valueForKey:@"email"];
        passwordC = [[response valueForKey:@"user"] valueForKey:@"password"];
        NSLog(@"%@ %@ %@ %@",firstNameC,lastNameC,emailC,passwordC);
    }
}

@end
