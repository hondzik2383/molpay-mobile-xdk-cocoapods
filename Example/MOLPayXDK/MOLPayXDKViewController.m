//
//  MOLPayXDKViewController.m
//  MOLPayXDK
//
//  Created by Clement on 02/29/2016.
//  Copyright (c) 2016 Clement. All rights reserved.
//

#import "MOLPayXDKViewController.h"
#import <MOLPayXDK/MOLPayLib.h>

@interface MOLPayXDKViewController () <MOLPayLibDelegate>
{
    MOLPayLib *mp;
    BOOL isCloseButtonClick;
    BOOL isPaymentInstructionPresent;
}
@end

@implementation MOLPayXDKViewController

- (IBAction)closemolpay:(id)sender
{
    // Closes MOLPay
    [mp closemolpay];
    
    isCloseButtonClick = YES;
}

- (IBAction)startmolpay:(id)sender
{
    // Default setting for Cash channel payment result conditions
    isPaymentInstructionPresent = NO;
    isCloseButtonClick = NO;
    
    // Setup payment details
    NSDictionary * paymentRequestDict = @{
                                          @"mp_amount": @"0.01", // Mandatory
                                          @"mp_username": @"api_razer", // Mandatory
                                          @"mp_password": @"api_rr365eR#", // Mandatory
                                          @"mp_merchant_ID": @"razer_Dev", // Mandatory
                                          @"mp_app_name": @"razer-pay-ios", // Mandatory
                                          @"mp_order_ID": @"XDK002", // Mandatory
                                          @"mp_currency": @"MYR", // Mandatory
                                          @"mp_country": @"MY", // Mandatory
                                          @"mp_verification_key": @"337d4d9b4c7a7d3eba0605c7814ee69a", // Mandatory
                                          @"mp_channel": @"credit7", // Optional
                                          @"mp_bill_description": @"Hello", // Optional
                                          @"mp_bill_name": @"Clement", // Optional
                                          @"mp_bill_email": @"clement@molpay.com", // Optional
                                          @"mp_bill_mobile": @"0162228207", // Optional
                                          @"mp_channel_editing": [NSNumber numberWithBool:NO], // Optional
                                          @"mp_editing_enabled": [NSNumber numberWithBool:NO], // Optional
                                          @"mp_credit_card_no": @"5426064000424979",
                                          @"mp_credit_card_cvv": @"979",
                                          @"mp_credit_card_expiry": @"12/24",
                                          @"mp_express_mode": [NSNumber numberWithBool:YES]
                                          
                                          //@"mp_dev_mode": [NSNumber numberWithBool:NO], // Optional, enable for online sandbox testing.
                                          
                                          //@"mp_transaction_id": @"", // Optional, provide a valid cash channel transaction id here will display a payment instruction screen.
                                          //@"mp_request_type": @"" // Optional, set 'Status' when performing a transactionRequest
                                          //@"mp_preferred_token": @"" // Optional, set the token id to nominate a preferred token as the default selection
                                          //@"mp_bin_lock": [NSArray arrayWithObjects:@"414170", @"414171", nil], // Optional for credit card BIN restrictions
                                          //@"mp_bin_lock_err_msg": @"Only UOB allowed" // Optional for credit card BIN restrictions
                                          //@"mp_is_escrow": @"" // Optional for escrow
                                          //@"mp_filter": @"", // Optional for debit card transactions only
                                          //@"mp_custom_css_url": [[NSBundle mainBundle] pathForResource:@"custom.css" ofType:nil], // Optional for custom UI
                                          //@"mp_is_recurring": [NSNumber numberWithBool:NO] // Optional, set true to process this transaction through the recurring api, please refer the MOLPay Recurring API pdf
                                          //@"mp_allowed_channels": [NSArray arrayWithObjects:@"credit", @"credit3", nil] // Optional for channels restriction
                                          //@"mp_sandbox_mode": [NSNumber numberWithBool:NO] // Optional for sandboxed development environment, set boolean value to enable.
                                          //@"mp_express_mode": [NSNumber numberWithBool:NO] // Optional, required a valid mp_channel value, this will skip the payment info page and go direct to the payment screen.
                                          //@"mp_advanced_email_validation_enabled": [NSNumber numberWithBool:YES] // Optional, enable this for extended email format validation based on W3C standards.
                                          //@"mp_advanced_phone_validation_enabled": [NSNumber numberWithBool:YES] // Optional, enable this for extended phone format validation based on Google i18n standards.
                                          //@"mp_bill_name_edit_disabled": [NSNumber numberWithBool:NO] // Optional, explicitly force disable billing name edit.
                                          //@"mp_bill_email_edit_disabled": [NSNumber numberWithBool:NO] // Optional, explicitly force disable billing email edit.
                                          //@"mp_bill_mobile_edit_disabled": [NSNumber numberWithBool:NO] // Optional, explicitly force disable billing mobile edit.
                                          //@"mp_bill_description_edit_disabled": [NSNumber numberWithBool:NO] // Optional, explicitly force disable billing description edit.
                                          //@"mp_language": @"EN" // Optional, EN, MS, VI, TH, FIL, MY, KM, ID, ZH.
                                          //@"mp_cash_waittime": @"48" // Optional, Cash channel payment request expiration duration in hour.
                                          //@"mp_non_3DS": [NSNumber numberWithBool:YES] // Optional, allow non-3ds on some credit card channels.
                                          };
    
    mp = [[MOLPayLib alloc] initWithDelegate:self andPaymentDetails:paymentRequestDict];
    mp.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(closemolpay:)];
    mp.navigationItem.hidesBackButton = YES;
    
    // Push method (This requires host navigation controller to be available at this point of runtime process,
    // refer AppDelegate.m for sample Navigation Controller implementations)
    //    [self.navigationController pushViewController:mp animated:YES];
    
    // Present method (Simple mode)
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mp];
    [self presentViewController:nc animated:NO completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Pay now"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(startmolpay:)];
}

// MOLPayLibDelegates
- (void)transactionResult: (NSDictionary *)result
{
    // Payment status results returned here
    NSLog(@"transactionResult result = %@", result);
    
    // All success cash channel payments will display a payment instruction, we will let the user to close manually
    if ([[result objectForKey:@"pInstruction"] integerValue] == 1 && isPaymentInstructionPresent == NO && isCloseButtonClick == NO)
    {
        isPaymentInstructionPresent = YES;
    }
    else
    {
        // Push method
        //        [self.navigationController popViewControllerAnimated:NO];
        
        // Present method
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
