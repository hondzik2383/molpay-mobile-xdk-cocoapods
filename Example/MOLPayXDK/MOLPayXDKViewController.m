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
}
@end

@implementation MOLPayXDKViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSDictionary * paymentRequestDict = @{
                                          @"mp_amount": @"", // Mandatory
                                          @"mp_username": @"", // Mandatory
                                          @"mp_password": @"", // Mandatory
                                          @"mp_merchant_ID": @"", // Mandatory
                                          @"mp_app_name": @"", // Mandatory
                                          @"mp_order_ID": @"", // Mandatory
                                          @"mp_currency": @"", // Mandatory
                                          @"mp_country": @"", // Mandatory
                                          @"mp_verification_key": @"", // Mandatory
                                          @"mp_channel": @"", // Optional
                                          @"mp_bill_description": @"", // Optional
                                          @"mp_bill_name": @"", // Optional
                                          @"mp_bill_email": @"", // Optional
                                          @"mp_bill_mobile": @"", // Optional
                                          @"mp_channel_editing": [NSNumber numberWithBool:NO], // Optional
                                          @"mp_editing_enabled": [NSNumber numberWithBool:NO], // Optional
                                          @"mp_transaction_id": @"", // Optional, provide a valid cash channel transaction id here will display a payment instruction screen.
                                          @"mp_request_type": @"" // Optional, set 'Status' when performing a transactionRequest
                                          //@"mp_preferred_token": @"" // Optional, set the token id to nominate a preferred token as the default selection
                                          //@"mp_bin_lock": [NSArray arrayWithObjects:@"414170", @"414171", nil], // Optional for credit card BIN restrictions
                                          //@"mp_bin_lock_err_msg": @"Only UOB allowed" // Optional for credit card BIN restrictions
                                          //@"mp_is_escrow": @"" // Optional for escrow
                                          //@"mp_filter": @"", // Optional for debit card transactions only
                                          //@"mp_custom_css_url": [[NSBundle mainBundle] pathForResource:@"custom.css" ofType:nil] // Optional for custom UI
                                          };
    
    mp = [[MOLPayLib alloc] initWithDelegate:self andPaymentDetails:paymentRequestDict];
    //    [self presentViewController:mp animated:NO completion:nil];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mp];
    mp.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(closemolpay:)];
    [self presentViewController:nc animated:NO completion:nil];
    
}

- (IBAction)closemolpay:(id)sender
{
    // Closes MOLPay
    [mp closemolpay];
}

// MOLPayLibDelegates
- (void)transactionResult: (NSDictionary *)result
{
    NSLog(@"transactionResult result = %@", result);
}

@end
