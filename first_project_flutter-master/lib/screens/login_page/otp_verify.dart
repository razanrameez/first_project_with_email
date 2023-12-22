import 'package:firstproject/screens/login_page/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Otp_verify extends StatelessWidget {
  const Otp_verify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          IconButton(onPressed:(){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
          SizedBox(height: 300,),
          OtpTextField(
            numberOfFields: 6,
            borderColor: Colors.black,
            //set to true to show as box or false to show as dash
            showFieldAsBox: true, 
            //runs when a code is typed in
            onCodeChanged: (String code) {
                //handle validation or checks here           
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode){
                showDialog(
                    context: context,
                    builder: (context){
                    return 
                    AlertDialog(
                        title: Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                    );
                    }
                );
            }, // end onSubmit
    ),
    
    Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(78.0),
        child: Container(
          height: 45,
          child: ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Sign_in(),));
          },style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black), child:Text("Submit",style: TextStyle(fontWeight: FontWeight.bold),)),
        ),
      ))
        ],
      ),),
    );
  }
}