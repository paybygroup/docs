
# PayByGroup v1.1 API Reference

Reference documentation for all merchant-facing, programmatic, PayByGroup interfaces. 
(See [API conventions](#api_conventions) for details common across all APIs.)


### Merchant Initiated APIs

| Resources                                                         | Description
| ----------------------------------------------------------------- | ------------
| 1 [/api_v1.1/purchases](#purchase_index)                          | Returns the details for matching selection of purchases
| 2. [/api_v1.1/purchases/:id/show](#purchase_show)                  | Returns the details for single group purchase
| 9 [/api_v1.1/purchases/:id/edit](#purchase_edit)                  | Allows merchant to update parameters of a purchase.
| 3. [/api_v1.1/purchases/:id/action/:action](#purchase_action) &nbsp; &nbsp; &nbsp; &nbsp;  | Executes specified action on specified purchase
| 6 [/api_v1.1/purchases/:id/invitees](#invitees_index)             | Returns details about selected invitees for a purchase
| 7 [/api_v1.1/transactions](#transaction_index)                    | Returns the details for matching selection of transactions

### PayByGroup Initiated APIs
| Resources                                                         | Description
| ----------------------------------------------------------------- | -------------
| 4. [https://MERCHANT_HOST.COM/pbg_api_v1.1/purchases/:id/show](#purchase_pull_info)         | PBG requests details from merchant regarding a specific purchase
| 8 [https://MERCHANT_HOST.COM/pbg_api_v1.1/purchases/:id/availability](#pbg_get_availablity) &nbsp; &nbsp;  | PBG requests details from merchant regarding inventory availablity for a specific purchase
| 5 [https://MERCHANT_HOST.COM/pbg_api_v1.1/purchases/update](#pbg_push_purch_info)          | PBG pushes requested purchase updates to merchant



<br><br><br><br>
<p id="api_conventions"></p>
## **API Conventions**
The following describes the approach used by PayByGroup APIs unless explicitly stated otherwise.

#### FORMAT
  - Data is transferred using post requests with URL encoded parameters.
  - Responses are encoded as a single JSON encoded hash in the post's body.
  - The posts format is listed as 'application/json'.
  - The calling parameters for all API calls must contain the 'api_key' parameter containing the merchant-specific 
    authorization token obtained from the merchant account's PayByGroup dashboard.

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
  - CURRENCY:      "#####.##" -- The current format is a simple decimal encoded as a string representing US dollars.
    - Our future format will include currency indicators:  "###.## USD"
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

#### RESPONSE FORMAT
 - All API calls return a hash with the following optional parameters along with parameters specific
   to each API call.

    {"code":200,
     "user_message": "An optional English language message suitable for display to the end user."
     "developer_message": "A more detailed message affording the developer greater insight into the error."
     "more_info": "Additional information, e.g. a link to documentation"
    }


Codes Used By PayByGroup 
200 - OK 
400 - Bad Request 
404 – Not Found 
401 - Unauthorized
500 - Internal Server Error







<br><br><br><br>
<p id="purchase_index"></p>
## **Purchase Index**
Interface for querying PayByGroup about existing group purchases.

#### FUNCTION 
  Provides a RESTful way for merchants to query status and parameters for a filtered subset of PayByGroups over a 
  given date range at any point. 

This API provides three querying mechanisms that can be employed in combination as needed:
1. Group Purchases can be retrieved by purchase\_id (both merchant, and PayByGroup ids)
2. Group Purchases can be retrieved by conjunction of constraints on Purchase field values (status, etc.)
3. Group Purchases can be retrieved by selected those that has a specific state change occur within a specified time window.
   This allows the merchant to reliably process all purchases that at a specific point in their life cycle (like completion, or expiration).

#### URL 
  &nbsp; &nbsp; https://PBG\_IP\_ADDRESS/api/merch\_get\_purch\_info.json

#### REQUEST PARAMETERS
- **:api\_key**         _(string)_  --  [REQUIRED] The Merchant's API key (a secret authorization token).
                                        This can be obtained from the merchant's master user account.
- **:merchant\_id**     _(string)_  –-  Constrains purchases to those with this merchant id.
- **:inventory\_id**    _(string)_  –-  Constrains purchases to those with this inventory id.
- **:purchase\_id**     _(string)_  –-  Constrains purchases to the one with this purchase id.
- **:created\_after**   _(date)_    -–  Constrains purchases to those created on or after this.  (inclusive start of date range)
- **:created\_before**  _(date)_    -–  Constrains purchases to those created before.  (exclusive end of date range)
- **:status**  _(array of string)_  -–  Constrains purchases to those w. matching status states.  (See Group Purchase 'status' for possible values)


#### RESPONSE PARAMETERS
Returns a hash with "group_purchases" mapped to an array of group purchase descriptors for each existing group purchase that matches the joint constraints defined by the request parameters.  Each group purchase descriptor in turn is a hash of parameters desribing the current state of that group purchase.

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
<p id="purchase_show"></p>
## **Purchase Show**

#### FUNCTION 
  Interface allowing a merchant to access the current state and parameters for a single group purchase using the purchase_id that the merchant supplied when this group purchase was created.

URL: /api_v1.1/purchases/:id/show

      
#### REQUEST PARAMETERS
- **:api\_key** _(string)_         --  [REQUIRED]  The Merchant's API key (a secret authorization token).
- **:purchase\_id**    _(string)_  –-  [REQUIRED]  The id of the purchase whose infomation is to be returned.


#### RESPONSE PARAMETERS
Returns a hash with "group_purchase" mapped the group purchase descriptor as described in "purchase index" 
Will return BadRequest, Unauthorized, or NotFound return codes as appropriate.

Example results format:

    { "code":                200,
      "group_purchase": 
        { "purchase_id”:     "ABC_12345",
          "status":          "pending",
          “purchase_name”:   “1600 Whitmarsh Avenue”,
          . . .              . . .
        },
        { "purchase_id”:     "ABC_98765",
          "status":          "payment_completed",
          . . .              . . .
        }
    }



<br><br><br><br>
<p id="purchase_action"></p>
## **Purchase Action**

FUNCTION
Provides API control over actions that can be taken by the merchant on a given PayByGroup.

URL   /api_v1.1/purchases/:id/action/:action

#### REQUEST PARAMETERS
- **:api\_key**       _(string)_   --  [REQUIRED]  The Merchant's API key.
- **:purchase\_id**   _(string)_   –-  [REQUIRED]  The id of the purchase to be manipulated
- **:action**         _(string)_   --  [REQUIRED]  The action (listed below) to be performed on the purchase. 


AVAILALABLE ACTIONS
- delete -- Completely removes a purchase from the PayByGroup system.  Use with care, will "break" 
  email links sent to users relating to this purchase.  (Cancel should generally be used instead of delete for most purchases, unless the merchant knows 'real' users are not involved with this purchase. Available for any purchase where no funds have been collected.
- cancel -- Permanently cancels this PayByGroup, refunds any transacations, and cancels any 
  credit card authorizations currently in place.  Available for any purchase where no user 
  funds are currently captured.
- collect_funds -- Confirms that the inventory is available to complete the purchase and triggers 
  transfer of funds to the merchant’s bank account.  Available when the purchase is in the state of org_commit 
  (this state)
- refund -- Returns all funds collected for this PayByGroup and cancels any existing authorizations 
  on credit cards tied to this PayByGroup.  Available after funds (some) have been collected.
- set_unavailable -- Notifies the organizer and merchant’s agent that the specific inventory is no 
  longer available and prompts them to settle on substitute inventory with the organizer to which 
  to apply this PayByGroup.  Available after a purchase has been claimed by the organizer, and before it has been cancelled or collected.


#### RESPONSE FORM
- Standard response parameters as listed in the conventions section are employed.








<br><br><br><br>
< id="purchase_edit"></p>
## **Purchase Edit**

FUNCTIONS
Allows merchant to edit properties of an existing purchase.

--- TBD ---







---------------
# MERCHANT PROVIDED API HOOKS

<br><br><br><br>
< id="purchase_pull_info"></p>
## **Purchase Pull** -- 

FUNCTION
Allows PayByGroup to query the merchant for additional parameters about a purchase.  


Gather information about a potential purchase from the merchant using the 'purchase_id' passed from the merchant to PBG when the user chooses to create a PayByGroup. Any optional variables may be set universally and will apply to all purchases unless overridden in a response parameter here. 
  
URL:   
http://MERCHANT_API_IP_ADDRESS/purchase/pull_info.json?merchant_id=XXX


#### REQUEST PARAMETERS
- **:api\_key**       _(string)_   --  [REQUIRED]  The Merchant's API key.
- **:purchase\_id**   _(string)_   –-  [REQUIRED]  The id of the purchase to be manipulated.

#### RESPONSE FORM
- **:group_purchase** _(hash)_     --  [REQUIRED]  Hash of values to be merged into the parameters of
  the PayByGroup.
- Standard response parameters as listed in the conventions section may be employed by the merchant as 
  appropriate.


[GORAN:  look at gp_create to see existing call to this API.  Add list of parameters that are
whitelisted there into the docs here.]


• :purchase_cost currency [merchant] -- Idealized total cost of the purchase (including deposits, taxes, and fees). This is the amount PBG sends to the merchant when the PayByGroup completes, unless merchant collected an organizer deposit
OR
• :cost_per_person currency [merchant] -- Total cost of one spot (including deposits, taxes, and fees). This amount, multiplied by the total number of people in the group, is sent to the merchant when the PayByGroup completes
• :purchase_image_url url [merchant] -- URL of the .png or .jpg image that best represents what is being purchased. It is scaled to be the main image on the dashboard. Image is downloaded from URL at the time of the call and proportionately resized so it is 270 pixels high. If its width is greater than 400 pixels, the left and right edges are proportionately clipped to reduce the height to 270 pixels.


• :purchase_name
• :purchase_description
• :purchase_link_url
• :merchant_org_email 






<br><br><br><br>
<p id="pbg_push_purch_info"></p>
## **PBG Push Purchase Info** --


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
<p id="pbg_get_availablity"></p>
## **PBG Get Inventory Availability** --


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


