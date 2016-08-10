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
                                          //@"mp_custom_css_url": [[NSBundle mainBundle] pathForResource:@"custom.css" ofType:nil], // Optional for custom UI
                                          //@"mp_is_recurring": [NSNumber numberWithBool:NO] // Optional, set true to process this transaction through the recurring api, please refer the MOLPay Recurring API pdf
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
