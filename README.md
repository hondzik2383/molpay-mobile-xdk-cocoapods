<!--
 # license: Copyright © 2011-2016 MOLPay Sdn Bhd. All Rights Reserved. 
 -->

# molpay-mobile-xdk-cocoapods

This is the complete and functional MOLPay iOS payment module that is ready to be implemented into
Xcode application project through Cocoapods framework. An example Cocoapods application project 
(Example) is provided for MOLPayXDK framework integration reference.

## Recommended configurations

- __Xcode version__: 7 ++

- __Minimum target version__: iOS 7

## Installation

Step 1 - Add pod 'MOLPayXDK', '~> _(Current version)_' to the Podfile, then Pod install.

Step 2 - Add #import <MOLPayXDK/MOLPayLib.h>

Step 3 - Add <MOLPayLibDelegate> to @interface

Step 4 - Add -(void)transactionResult:(NSDictionary *)result for all delegate callbacks

Step 5 - Add `App Transport Security Settings > Allow Arbitrary Loads > YES` to the application project info.plist

## Prepare the Payment detail object

- Instantiate a new NSDictionary object and add the required pair key/value(s) listed below to form the payment detail
object to be passed to the MOLPayLib processing object

- `mp_amount`: Mandatory _(String)_ value not less than `1.00`

- `mp_username`: Mandatory _(String)_. Please obtain this from MOLPay support if you're not a registered MOLPay merchant.

- `mp_password`: Mandatory _(String)_. Please obtain this from MOLPay support if you're not a registered MOLPay merchant.

- `mp_merchant_ID`: Mandatory _(String)_. Please obtain this from MOLPay support if you're not a registered MOLPay merchant.

- `mp_app_name`: Mandatory _(String)_. Please obtain this from MOLPay support if you're not a registered MOLPay merchant.

- `mp_order_ID`: Mandatory _(String)_

- `mp_currency`: Mandatory _(String)_. Malaysia currency is `MYR`.

- `mp_country`: Mandatory _(String)_. Malaysia is `MY`.

- `mp_verification_key`: Mandatory _(String)_. Please obtain this from MOLPay support if you're not a registered MOLPay merchant.

- `mp_channel`: Optional _(String)_. Defaulted to `multi` if no value provided thus all subscribed channels will be selectable.

- `mp_bill_description`: Optional _(String)_. `mp_editing_enabled` will be defaulted to 1 if no value provided thus this field
be editable.

- `mp_bill_name`: Optional _(String)_. Same as above.

- `mp_bill_email`: Optional _(String)_. Same as above.

- `mp_bill_mobile`: Optional _(String)_. Same as above.

- `mp_channel_editing`: Optional _(int)_. Defaulted to `0` except when `mp_channel` value is `multi` if no value provided thus
the channel cannot be changed.

- `mp_editing_enabled`: Optional _(int)_. Defaulted to `0` except any bill information not provided.

- `mp_transaction_id`: Optional _(String)_. This is MOLPay returned value, set this value to show the `Cash Channel Payment Instruction`
or during a transaction request process.

- `mp_request_type`: Optional _(String)_. Set this value as the callback reference id when executing a transaction request. `Receipt` is
the MOLPay reserved keyword, refrain from using it here.

## Start the payment module

MOLPayLib mp = [[MOLPayLib alloc] initWithDelegate:self andPaymentDetails:_(Payment detail object)_];

## Show the payment UI

[self presentViewController:mp animated:NO completion:nil];

## Close the payment module

[mp closemolpay];

_(Notes)_: The host application needs to implement the MOLPay payment module manually upon getting a final callback from the close event 

## Transaction request service

Step 1 - Prepare the Payment detail object

Step 2 - Start the payment module

Step 3 - [mp transactionRequest];

_(Notes)_: The transaction request can process without showing the UI

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