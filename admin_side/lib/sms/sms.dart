// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';

Future<String> curl(String url) async {
  HttpClient httpClient = HttpClient();
  HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
  HttpClientResponse response = await request.close();
  String responseBody = await response.transform(utf8.decoder).join();
  httpClient.close();
  return responseBody;
}

void sendSignupOtp(String mobilenumber,String username,int otp) async {
  String numbers = mobilenumber; // enter Mobile numbers comma separated
  String apiId = "NzkwNzg4NzI1MQ";
  String senderId = "CNTSMS"; // Your sender id
  String mess = "Dear $username, you OTP is $otp. Thank you for using our service - CNTSMS";
  String message = Uri.encodeComponent("$mess");
  String port = "TA"; // required route
  String dltId = "7907887251"; // provide your DLT ID
  String tempId = "1707162253174837192"; // provide your template ID

  String url = "https://app.smsbits.in/api/web?id=$apiId&senderid=$senderId&to=$numbers&msg=$message&port=$port&dltid=$dltId&tempid=$tempId";
  // String response = await curl(url);
}