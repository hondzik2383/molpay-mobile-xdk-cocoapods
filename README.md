<!--
 # license: Copyright © 2011-2016 MOLPay Sdn Bhd. All Rights Reserved. 
 -->

# molpay-mobile-xdk-cocoapods

This is the complete and functional MOLPay iOS payment module that is ready to be implemented into Xcode application project through Cocoapods framework. An example Cocoapods application project (Example) is provided for MOLPayXDK framework integration reference.

## Recommended configurations

    - Xcode version: 7 ++

    - Minimum target version: iOS 7

## Installation

    Step 1 - Add pod 'MOLPayXDK', '~> <put latest release version here>' to the Podfile, then Pod install.

    Step 2 - Add #import <MOLPayXDK/MOLPayLib.h>

    Step 3 - Add <MOLPayLibDelegate> to @interface

    Step 4 - Add -(void)transactionResult:(NSDictionary *)result for all delegate callbacks

    Step 5 - Add 'App Transport Security Settings > Allow Arbitrary Loads > YES' to the application project info.plist

## Prepare the Payment detail object

    NSDictionary * paymentRequestDict = @{
        // Mandatory String. A value not less than '1.00'
        @"mp_amount": @"1.10",
    
        // Mandatory String. Values obtained from MOLPay
        @"mp_username": @"username",
        @"mp_password": @"password",
        @"mp_merchant_ID": @"merchantid",
        @"mp_app_name": @"appname",
        @"mp_verification_key": @"vkey123",
    
        // Mandatory String. Payment values
        @"mp_order_ID": @"orderid123",
        @"mp_currency": @"MYR",
        @"mp_country": @"MY",
        
        // Optional String.
        @"mp_channel": @"multi",
        @"mp_bill_description": @"billdesc",
        @"mp_bill_name": @"billname",
        @"mp_bill_email": @"email@domain.com",
        @"mp_bill_mobile": @"+1234567",
        @"mp_channel_editing": [NSNumber numberWithBool:NO],
        @"mp_editing_enabled": [NSNumber numberWithBool:NO],
        
        // For transaction request use only, do not use this on payment process
        @"mp_transaction_id": @"",
        @"mp_request_type": @""
    };

## Start the payment module

    MOLPayLib mp = [[MOLPayLib alloc] initWithDelegate:self andPaymentDetails:paymentRequestDict];

## Show the payment UI

    [self presentViewController:mp animated:NO completion:nil];

## Close the payment module

    [mp closemolpay];

    * Note: The host application needs to implement the MOLPay payment module manually upon getting a final callback from the close event.

## Transaction request service (optional)

    Step 1 - Prepare the Payment detail object

    Step 2 - Start the payment module

    Step 3 - [mp transactionRequest];
    
    * Notes: The transaction request can process without showing the UI

## Payment module callback

    - (void)transactionResult: (NSDictionary *)result

## Support

Submit issue to this repository or email to our support@molpay.com

Merchant Technical Support / Customer Care : support@molpay.com<br>
Sales/Reseller Enquiry : sales@molpay.com<br>
Marketing Campaign : marketing@molpay.com<br>
Channel/Partner Enquiry : channel@molpay.com<br>
Media Contact : media@molpay.com<br>
R&D and Tech-related Suggestion : technical@molpay.com<br>
Abuse Reporting : abuse@molpay.com<br>