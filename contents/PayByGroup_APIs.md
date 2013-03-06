
# PayByGroup API reference documentation

Reference *documentation* _for_ all merchant-facing, programmatic, PayByGroup interfaces. 

## Contents
- [**API Conventions**](#api_conventions) 
- [**Merchant Get Purchase Info**](#merch_get_purch_info) 
- [**Merchant Push Purchase Info**](#merch_push_purch_info)  
- [**PBG Get Purchase Info**](#pbg_get_purch_info)
- [**PBG Push Purchase Info**](#pbg_push_purch_info)
- [**Merchant Push Action**](#merch_push_action)
- [**PBG Get Inventory Availability**](#pbg_get_availablity)

## URLS
- https://PBG\_IP\_ADDRESS/api/group\_purchase/query.json
- https://PBG\_IP\_ADDRESS/api/group\_purchase/update.json

- https://PBG\_IP\_ADDRESS/api/merch\_get\_purch\_info.json
- https://PBG\_IP\_ADDRESS/api/merch\_get\_purch\_info.json
- https://PBG\_IP\_ADDRESS/api/merch\_get\_purch\_info.json



<br><br><br><br>
<p id="api_conventions"></p>
## API Conventions
The following describes the approach used by PayByGroup APIs unless explicitly stated otherwise.

#### FORMAT
  - Data is transferred using post requests formatted as 'application/json'.
  - Responses are also a single JSON encoded object in the post's body.
  - Both the post parameters and the response values are each encoded as a single JSON map of values.
  - The calling map of all API calls must contain a merchant-specific auth token (a 32 character random identifier)

#### ADDRESSING
  - All API calls must originate from one of the PBG_ADDRESSES below or from the supplied MERCHANT_API_URLs
  - In production all calls to PBG must be to the 'production' address below.
  - Staging/testing of new API interactions will typically be done using the ‘test’ or ‘dev2’ addresses below.
  - API calls that originate from PBG to the merchant follow the same format above, and will 
    provide the same 'merchant_auth' and 'action' keys.

#### DATATYPES
  - DATE FORMAT:   "YYYY-MM-DD"
  - DATETIME FORMAT:   “YYYY-MM-DD HH:MM PST”
    (This is the rails default ISO-8601 format, pacific coast time.
     For simplicity, midnight PST time is the expiration time for all PayByGroups. That way no group is surprised to have theirs expire before midnight in their local time, and the expiration does not need to be conditioned on the location of one or more users.)
  - CURRENCY:      "###.## USD"
    A string containing a decimal followed by a space and a currency indicator
    (e.g. "USD" for US dollars)
    
#### PBG\_ADDRESSES
 - 184.106.133.37 (production)
 - 50.57.143.251 (test)
 - 50.57.115.142 (dev2)
 - 50.57.106.140 (dev1)

#### MERCHANT\_API\_URL
 - IP address supplied by the merchant

#### MERCHANT\_AUTH
 - 32-character sequence of printable ASCII characters




<br><br><br><br>
<p id="merch_get_purch_info"></p>
## **Merchant Get Purchase Info**
Interface for querying PayByGroup about existing group purchases.

#### FUNCTION 

  Provides a RESTful way for merchants to query status and parameters for a filtered subset of PayByGroups over a given date range at any point. 

This API provides three querying mechanisms that can be employed in combination as needed:
1. Group Purchases can be retrieved by purchase\_id (both merchant, and PayByGroup ids)
1. Group Purchases can be retrieved by conjunction of constraints on Purchase field values (status, etc.)
3. Group Purchases can be retrieved by selected those that has a specific state change occur within a specified time window.
   This allows the merchant to reliably process all purchases that at a spcific point in their life cycle (like completion, or expiration).

#### URL 

  &nbsp; &nbsp; https://PBG\_IP\_ADDRESS/api/merch\_get\_purch\_info.json

#### Request Parameters
- **:api\_key** _(string)_          --  [REQUIRED]  The Merchant's API key (a secret authorization token).  This can be obtained from the merchant's master user account.
- **:merchant\_id**     _(string)_  –-  Constrains purchases to those with this merchant id.
- **:inventory\_id**    _(string)_  –-  Constrains purchases to those with this inventory id.
- **:purchase\_id**     _(string)_  –-  Constrains purchases to the one with this purchase id.
- **:created\_after**   _(date)_    -–  Constrains purchases to those created on or after this.  (inclusive start of date range)
- **:created\_before**  _(date)_    -–  Constrains purchases to those created before.  (exclusive end of date range)
- **:status**  _(array of string)_  -–  Constrains purchases to those w. matching status states.  (See Group Purchase 'status' for possible values)


#### RESPONSE PARAMETERS

A hash of parameters for each selected group purchase will be returnedParameters for each group purchase will be returned.  

All input and output parameters for each group purchase will be returned for the set of PayByGroups requested. 

Example results format:

    { “group_purchases": 
      [
        { "purchase_id”:     "ABC_12345",
          "status":          "pending",
          “purchase_name”:   “1600 Whitmarsh Avenue”,
          . . .              . . .
        },
        { "purchase_id”:     "ABC_98765",
          "status":          "payment_completed",
          . . .              . . .
        }
      ]
    }



<br><br><br><br>
<p id="merch_push_purch_info"></p>
## **Merchant Push Purchase Info**

2 - Purchase Create API

OBJECTIVE 
Gather information about a potential purchase from the merchant using the 'purchase_id' passed from the merchant to PBG when the user chooses to create a PayByGroup. Any optional variables may be set universally and will apply to all purchases unless overridden in a response parameter here. 
  
URL:   
http://MERCHANT_API_IP_ADDRESS/purchase_create.json?merchant_id=XXX

SAMPLE VARIABLE
• :variable_name datatype [Source of variable] -- Extended variable explanation

REQUEST PARAMS: (both required)
• :merchant_auth string [PBG] -- A 32-character merchant authorization cookie
• :purchase_id string [merchant] – Unique ID for this single purchase supplied by the merchant. Retained by PBG and merchant for at least one calendar year and required for most APIs

RESPONSE PARAMS:

Required
• :purchase_cost currency [merchant] -- Idealized total cost of the purchase (including deposits, taxes, and fees). This is the amount PBG sends to the merchant when the PayByGroup completes, unless merchant collected an organizer deposit
OR
• :cost_per_person currency [merchant] -- Total cost of one spot (including deposits, taxes, and fees). This amount, multiplied by the total number of people in the group, is sent to the merchant when the PayByGroup completes
• :purchase_image_url url [merchant] -- URL of the .png or .jpg image that best represents what is being purchased. It is scaled to be the main image on the dashboard. Image is downloaded from URL at the time of the call and proportionately resized so it is 270 pixels high. If its width is greater than 400 pixels, the left and right edges are proportionately clipped to reduce the height to 270 pixels.

Optional
Any variables listed in the Merchant Input Variables list. Typically, merchants will pass at least the following:
• :purchase_name
• :purchase_description
• :purchase_link_url
• :merchant_org_email 
¬¬





<br><br><br><br>
< id="pbg_get_purch_info"></p>
## **PBG Get Purchase Info** -- 


RLAC's Purchase Info 


<br><br><br><br>
<p id="pbg_push_purch_info"></p>
## **PBG Push Purchase Info** --

6 - Change Push API

OBJECTIVE
Enable PayByGroup to push all values for a certain PayByGroup to the merchant anytime one or more values on that PayByGroup changes. The important values that, when updated, trigger the Change Push API are:
• :status
• :commit_deadline
• :num_people

URL
http://MERCHANT_IP_ADDRESS?merchant_id=XXX

REQUEST PARAMS
All input and output parameters for each group purchase that has had one of the values specified above changed since the last time the Change Push API was triggered 

Example format:
{“merchant_auth”:                   “XXXXXXXXXX”,
  "events": [   
    {"purchase_id:    "ABC_12345",
     "status":      "collected",
     “purchase_name”:   “1600 Whitmarsh Avenue”
     …        …
    }
    {"purchase_id:    "ABC_98765",
     "status":      "payment_completed",
     ...        …
    }
  ]
}

RESPONSE PARAMS
Example format:
{“result”:       true} 
{“result”:       false}




<br><br><br><br>
<p id="merch_push_action"></p>
## **Merchant Push Action** --

5 - Merchant Action API

OBJECTIVE
Gives the merchant automated control over all actions that can be taken by the merchant on a given PayByGroup.

URL
http://MERCHANT_API_IP_ADDRESS/purchase_action.json?merchant_id=XXX

REQUEST PARAMS
Required
• :merchant_auth string [PBG] -- A 32-character merchant authorization token
• :purchase_id string [merchant] – Unique ID for this single purchase supplied by the merchant. Retained by PBG and merchant for at least one calendar year and required for most APIs
• :action string [merchant] – The action to be taken on this PayByGroup. Possible actions are:
o :collect_funds – Confirms that the inventory is available to complete the purchase and triggers transfer of funds to the merchant’s bank account
o :set_unavailable -- Notifies the organizer and merchant’s agent that the specific inventory is no longer available and prompts them to settle on substitute inventory with the organizer to which to apply this PayByGroup
o :refund – Returns all funds collected for this PayByGroup and cancels any existing authorizations on credit cards tied to this PayByGroup
o :cancel – Permanently cancels this PayByGroup, refunds any transacations, and cancels any credit card authorizations currently in place

RESPONSE PARAMS:   
Example format:
{“result”:       true} 
{“result”:       false}




<br><br><br><br>
<p id="pbg_get_availablity"></p>
## **PBG Get Inventory Availability** --


3 - Inventory Status API

OBJECTIVE
Allows PBG to query and update the status of the inventory associated with a particular group purchase. This is used to improve the user experience for a fully automated integration so that the user may be notified the inventory is not available before submitting payment.

URL
http://MERCHANT_IP_ADDRESS?merchant_id=XXX

REQUEST PARAMS (both required)
• :merchant_auth string [PBG] -- A 32-character merchant authorization token
• :purchase_id string [merchant] – Unique ID for this single purchase supplied by the merchant. Retained by PBG and merchant for at least one calendar year and required for most APIs

RESPONSE PARAMS
• :inventory_state symbol [merchant] – Specifies the current state of the inventory underlying a purchase. Possible values are:
o :1 -- available – The inventory is still available
o :2 -- unavailable – The inventory is no longer available
o :3 -- unknown – The status of the inventory cannot be instantly determined

Example format:
{"result":      “available”}


