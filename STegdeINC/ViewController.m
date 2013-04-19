//
//  ViewController.m
//  STegdeINC
//
//  Created by Lion User on 3/24/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize emailTextField,passwordTextField,rememberButton;
uint image = 0;
NSString *email = @"",*password=@"";
NSMutableData *webData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if(image == 1){
        emailTextField.text = email;
        passwordTextField.text = password;
        UIImage *Image= [UIImage imageNamed:@"greenButton.jpeg"];
        [rememberButton setImage:Image forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - start Screen
- (IBAction)startScreenPressed:(id)sender {
    ViewController *login = [[ViewController alloc] init];
    login = [self.storyboard instantiateViewControllerWithIdentifier:@"loginView"];
    login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:login animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==emailTextField) {
        [passwordTextField becomeFirstResponder];
    }
    else if(textField==passwordTextField){
        [passwordTextField resignFirstResponder];
    }
    else if(textField==registroMail){
        [registroNombre becomeFirstResponder];
    }
    else if(textField==registroNombre){
        [registroApellido becomeFirstResponder];
    }
    else if(textField==registroApellido){
        [registroPassword becomeFirstResponder];
    }
    else if(textField==registroPassword){
        [registroVerificarPassword becomeFirstResponder];
    }
    else if(textField==registroVerificarPassword){
        [registroVerificarPassword resignFirstResponder];
    }
    return YES;
}

#pragma mark - login Screen

- (IBAction)loginPressed:(id)sender {
    if(image == 1){
        email = emailTextField.text;
        password = passwordTextField.text;
    }
    else{
        email = @"";
        password = @"";
    }
    [emailTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    if([emailTextField.text isEqual: @"test@mail.com"] && [passwordTextField.text isEqual: @"test"]){//cambiar para preguntarle al servidor
        myViewController *login = [[myViewController alloc] init];
         login = [self.storyboard instantiateViewControllerWithIdentifier:@"firstView"];
         login.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
         [self presentViewController:login animated:YES completion:nil];
    }
}

- (IBAction)registrarPressed:(id)sender {
    [emailTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    ViewController *registro = [[ViewController alloc] init];
    registro = [self.storyboard instantiateViewControllerWithIdentifier:@"registroView"];
    registro.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:registro animated:YES completion:nil];
}

- (IBAction)dismissKeyboard:(id)sender {
    [emailTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

- (IBAction)infoPressed:(id)sender {
    UIAlertView *login = [[UIAlertView alloc] initWithTitle:@"STedgeINC app" message:@"Una aplicaciòn que te permite realizar memorandums que solo pueden ser modificados por el administrador o los administradores" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [login show];
}

- (IBAction)rememberPressed:(id)sender {
    if(image == 0){
        UIImage *Image= [UIImage imageNamed:@"greenButton.jpeg"];
        [rememberButton setImage:Image forState:UIControlStateNormal];
        image = 1;
    }
    else{
        UIImage *Image= [UIImage imageNamed:@"whiteButton.jpeg"];
        [rememberButton setImage:Image forState:UIControlStateNormal];
        image = 0;
    }
}

#pragma mark - Registro
@synthesize registroApellido,registroMail,registroNombre,registroPassword,registroVerificarPassword;
- (IBAction)cancelRegistroPressed:(id)sender {
    [registroVerificarPassword resignFirstResponder];
    [registroPassword resignFirstResponder];
    [registroMail resignFirstResponder];
    [registroNombre resignFirstResponder];
    [registroApellido resignFirstResponder];
    ViewController *login = [[ViewController alloc] init];
    login = [self.storyboard instantiateViewControllerWithIdentifier:@"loginView"];
    login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:login animated:YES completion:nil];
}

- (IBAction)registroDismissKeyboard:(id)sender {
    [registroVerificarPassword resignFirstResponder];
    [registroPassword resignFirstResponder];
    [registroMail resignFirstResponder];
    [registroNombre resignFirstResponder];
    [registroApellido resignFirstResponder];
}

-(BOOL) isDataMissing{
    if(registroNombre.text.length == 0)
        return TRUE;
    if(registroApellido.text.length == 0)
        return TRUE;
    if(registroMail.text.length == 0)
        return TRUE;
    if(registroPassword.text.length == 0)
        return TRUE;
    if(registroVerificarPassword.text.length == 0)
        return TRUE;
    return FALSE;
}

- (IBAction)registrarsePressed:(id)sender {
    if([self isDataMissing]){
        UIAlertView *errorAlert = [[UIAlertView alloc ] initWithTitle:@"Warning"
                                                              message:@"Complete the fields"
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [errorAlert show];
        return;
    }
    if (registroPassword.text.length > 3 && registroVerificarPassword.text.length > 3) {
        if ([registroPassword.text isEqual:registroVerificarPassword.text]) {
            webData = [NSMutableData new];
            NSString *url = @"http://socialmemo.herokuapp.com/users";
            
            NSMutableDictionary *user = [NSMutableDictionary new];
            NSMutableDictionary *userParameters = [NSMutableDictionary new];
            //Setting the parameters of the user
            [userParameters setObject:registroNombre.text                       forKey:@"first_name"];
            [userParameters setObject:registroApellido.text                   forKey:@"last_name"];
            [userParameters setObject:registroMail.text                      forKey:@"email"];
            [userParameters setObject:registroPassword.text                   forKey:@"password"];
            [userParameters setObject:registroVerificarPassword.text                   forKey:@"password_confirmation"];
            
            
            
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
            NSLog(@"%@",params);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
            
            //Creating the NSURLConnection
            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                          delegate:self];
            
            
            
            if(!connection){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Hubo un error al conectarse al servidor" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Felicidades" message:@"El usuario ha sido creado" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [registroVerificarPassword resignFirstResponder];
                [registroPassword resignFirstResponder];
                [registroMail resignFirstResponder];
                [registroNombre resignFirstResponder];
                [registroApellido resignFirstResponder];
                ViewController *login = [[ViewController alloc] init];
                login = [self.storyboard instantiateViewControllerWithIdentifier:@"loginView"];
                login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:login animated:YES completion:nil];
            }
            
            
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sin coincidencia" message:@"La contraseña y la verficación no coinciden" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            registroPassword.text = @"";
            registroVerificarPassword.text = @"";
            [alert show];
            [registroPassword becomeFirstResponder];
        }
    }else{
            
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Numero de Caracteres" message:@"El número de caracteres minimo es de 4" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        registroPassword.text = @"";
        registroVerificarPassword.text = @"";
        [alert show];
        [registroPassword becomeFirstResponder];
    }

    
    
    //CREAR UN NUEVO USUARIO CON TODO LO QUE IMPLICA
    NSMutableDictionary *user = [NSMutableDictionary new];
    NSMutableDictionary *userParameters = [NSMutableDictionary new];
    
    //Setting the parameters of the user
    [userParameters setObject:registroNombre.text                       forKey:@"name"];
    [userParameters setObject:registroPassword.text                   forKey:@"password"];
    [userParameters setObject:registroMail.text                      forKey:@"username"];
    
    [user setObject:userParameters forKey:@"user"];
}

#pragma mark - HTTP Request

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [webData setLength:0];
    NSLog(@"didReceiveResponse");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webData appendData:data];
    NSLog(@"didReceiveData");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError *error;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:webData
                                                             options:kNilOptions
                                                               error:&error];
    NSLog(@"Response: %@", response);
}
@end
