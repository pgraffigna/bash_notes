<?php
//Import PHPMailer classes into the global namespace
//These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

//Load Composer's autoloader
//require 'vendor/autoload.php';

// solo necesario si no se usa composer
require '/home/vagrant/PHPMailer/src/Exception.php';
require '/home/vagrant/PHPMailer/src/PHPMailer.php';
require '/home/vagrant/PHPMailer/src/SMTP.php';

//Create an instance; passing `true` enables exceptions
$mail = new PHPMailer(true);

try {
    //Server settings
    $mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
    $mail->isSMTP();                                            //Send using SMTP
    $mail->Host       = 'smtp.cultura.gob.ar';                     //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
    $mail->Username   = 'USUARIO@CORREO';                     //SMTP username
    $mail->Password   = 'PASSWORD';                               //SMTP password
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
    $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

    //Recipients
    $mail->setFrom('USUARIO@CORREO', 'Mailer');
    $mail->addAddress('USUARIO@CORREO', 'pablo graffigna');     //Add a recipient

    //Content
    $mail->isHTML(true);                                  //Set email format to HTML
    $mail->Subject = 'ASUNTO';
    $mail->Body    = 'CUERPO DEL CORREO <b>in bold!</b>';
    $mail->AltBody = 'CUERPO DEL CORREO ALTERNATIVO PARA CLIENTES NO HTML';

    $mail->send();
    echo 'MENSAJE DE CONFIRMACION DE ENVIO';
} catch (Exception $e) {
    echo "MENSAJE DE ERROR: {$mail->ErrorInfo}";
}
