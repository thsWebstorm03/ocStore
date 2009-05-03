<?php
// Heading
$_['heading_title']         = 'PayPal Direct Payments (UK)';

// Text 
$_['text_payment']          = 'Payment';
$_['text_success']          = 'Success: You have modified PayPal account details!';
$_['text_development']      = '<span style="color: red;">In Development</span>';
$_['text_paypal_direct_uk'] = '<a onclick="window.open(\'https://www.paypal.com/uk/mrb/pal=W9TBB5DTD6QJW\');"><img src="view/image/payment/paypal.png" align="PayPal" title="PayPal" style="border: 1px solid #EEEEEE;" /></a>';
$_['text_checkout']         = 'On Checkout';
$_['text_callback']         = 'On Callback';

// Entry
$_['entry_email']           = 'E-Mail:';
$_['entry_encryption']      = 'Encryption Key:';
$_['entry_callback']        = 'Confirm Order:';
$_['entry_test']            = 'Test Mode:';
$_['entry_order_status']    = 'Order Status:';
$_['entry_geo_zone']        = 'Geo Zone:';
$_['entry_status']          = 'Status:';
$_['entry_sort_order']      = 'Sort Order:';

// Help
$_['help_encryption']       = 'Please provider a secret key that will be used to hide the order ID when sending information to PayPal.';
$_['help_callback']         = 'Sometimes PayPal\'s callback can not contact your site so it maybe necessary to confirm the order as your customer leaves the checkout confirm page.';

// Error
$_['error_permission']      = 'Warning: You do not have permission to modify payment PayPal!';
$_['error_email']           = 'E-Mail Required!'; 
$_['error_encryption']      = 'Encryption Key Required!';
?>