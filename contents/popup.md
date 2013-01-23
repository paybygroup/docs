# Popup Docs



### PayByGroup Informational Popup

The PBG Informational Popup is designed to provide merchants with considerable
flexibilty in configuring how paybygroup is presented to their customers.
Below we list the parameters that control this informational popup.  

These parameters are typically supplied directly to PayByGroup as a simple JSON hash
of values, but each parameter may also be directly encoded (or overridden) by supplying
an attribute on the HTML DIV used to launch the popup.  So for example, data-popup-button-action='to_pbg'
is often used to convert the default informational popup, into a second popup whose call to action will 
go to PayByGroup purchase creation page, rather than the default button-action which simply closes the
informational popup.

#### Popup Parameters

- **partial_name** -- Maps to `'default'` by default.  This parameter can be used (in conjunction with PayByGroup) to 
  provide a completely different skin for the look and feel for the informational popup.

- **step1** -- Text for step 1

Choose **PayByGroup** on any home's payment page.",
                                                                    step2: 'Set how to split the cost, and send the invites.',
                                                                    step3: 'Everyone joins, you confirm and all enjoy!',
                                                                    button_prefix: 'Ready?',
                                                                    button: 'Continue',
                                                                    button_action: :close,
                                                                    footer: "Details: When you choose PayByGroup, you aren't obligated to complete the purchase. Your booking is subject to availability. You can set a tipping point for the minimum number of people you need.  The booking is only completed and everyone charged when you give the go-ahead.",
                                                                    footer_link: 'more info',
                                                                    footer_link_url: 'http://paybygroup.com/paybygroup-faqs-rent-like-a-champion/'
                                                                  }
express the paybygoup service 

tailor the presentation of our service in the context of 

providing information about our service expressed in a
way that is idealized 
