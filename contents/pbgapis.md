# PayByGroup v1 API Reference

Reference documentation for all merchant-facing, programmatic interfaces with PayByGroup.
(See [API conventions](/api_conventions) for details common across all APIs.)

### API Endpoint
    https://lets.paybygroup.com/api/v1/

### Authentication
You need to include `api_key` to authenticate.
<pre class="terminal">
  $ curl -i "https://lets.paybygroup.com/api/v1/?api_key=XXX"

  HTTP/1.1 200 OK
  Content-Type: application/json

  {
    message: "Welcome to PayByGroup"
  }
</pre>

## Group Purchase API

Action    | Resource                                          | Description
----------| --------------------------------------------------| ----------------------------------------------------------
GET       | [/group_purchases](#purchase_index)                     | Returns the details for matching selection of purchases
GET       | /group_purchases/:purchase_id                  | Returns the details for single group purchase
POST      | /group_purchases/:id/collect_funds        | Confirms that the inventory is available to complete the purchase and triggers final capture of the funds to the merchant's account [](info#purchase_collect_funds_info)
PUT      | /group_purchases/:id/set_unavailable      | Notifies the organizer and the merchant by email that the specific inventory is no longer available and prompts the merchant to contact the organizer regarding substitute inventory to which to apply this PayByGroup [](info#purchase_set_unavailable_info)
PUT      | /group_purchases/:id/cancel     | Permanently cancels this PayByGroup, refunds any transacations, and cancels any credit card authorizations currently in place [](info#purchase_cancel_info)
POST      | /group_purchases/:id/refund        | Returns all funds collected for this PayByGroup and cancels any existing authorizations on credit cards tied to this PayByGroup [](info#purchase_refund_info)
GET       | [/group_purchases/:id/invitees](#invitees_index)        | Returns details on all members of the selected group purchase 
GET       | [/group_purchases/:id/transactions](#transaction_index) | Returns the details for all transactions that are part of the selected group purchase
DELETE      | [/group_purchases/:id/delete](https://lets.paybygroup.com/api/v1/group_purchases/:id/delete)        | Completely removes a purchase from the PayByGroup system (Use with EXTREME CAUTION) [](info#purchase_delete_info)


<div class="hide">
  <div class="well" id="purchase_delete_info">
Use with care, will "break" email links sent to users relating to this purchase.  (Cancel should generally be used instead of delete for most purchases, unless the merchant knows 'real' users are not involved with this purchase. Available for any purchase where no funds have been collected.
  </div>
  <div class="well" id="purchase_cancel_info">
    Available for any purchase where no user funds are currently captured.
  </div>
  <div class="well" id="purchase_collect_funds_info">
    Available when the status of the purchase is payment_authorized.
  </div>
  <div class="well" id="purchase_refund_info">
    Available after some or all of the funds have been collected.
  </div>
  <div class="well" id="purchase_set_unavailable_info">
    Available after a purchase has been claimed by the organizer and before it has been cancelled or collected.
  </div>
</div>

<br />
<br />

<p id="purchase_index"></p>
## Group Purchase Search
Querying PayByGroup about existing group purchases using certain parameters.

<pre class="terminal">
  $ curl -i "https://lets.paybygroup.com/api/v1/group_purchases?PARAMETER=XXX&api_key=XXX"

  HTTP/1.1 200 OK
  Content-Type: application/json

  { "group_purchases":
    [
      {
        "id": "ABC_12345",
        "status": "GP_MERCHANT_PAID",
        "name": "1600 Whitmarsh Avenue",
        "commit_deadline": "2013-04-19T15:54:05-07:00",
        "min_people": 2,
        "max_people": 5,
        "splitting_method_type": "GroupPurchases::SimpleSplit",
        "purchase_cost": "1500.00",
        "merchant_id": "test",
        "merchant_name": "John Doe"
      },
      {

      }
    ]
  }
</pre>

**PARAMETERS**

- `api_key` __(string)__  -  The Merchant's API key (a secret authorization token).This can be
obtained from the merchant's master user account.
- `merchant_id` __(string)__  -  Constrains purchases returned to those with this merchant id.
- `inventory_id`    __(string)__  -  Constrains purchases returned to those with this inventory id.
- `purchase_id`     __(string)__  -  Constrains purchases returned to the one with this purchase id.
- `created_after`   __(date)__    -  Constrains purchases returned to those created on or after this.  (inclusive of start of date range)
- `created_before`  __(date)__    -  Constrains purchases returned to those created before this date (exclusive of end of date range).
- `status`  __(array of string)__  -  Constrains purchases to those with matching status states.  (See [Group Purchase Status](/group_purchase_output_variables) for possible values)




<br><br>
<p id="invitees_index"></p>
## Group Purchase Invitees
Call for querying PayByGroup about users associated with an existing group purchase.

**RESPONSE**
  Returns a hash with `invitees` array containing an info hash for each member of the group.

  Each user info hash contains:

  - `id` -- an integer that uniquely identifies this invitee 'slot'.  This id will be unique across all invitees across all group purchases.
  - `user_id ` -- an integer that uniquely identifies this user. This will be unique to all users using PayByGroup.
  - `user_email` -- the current email address for this user.
  - `role` -- the current role of this invitee. 'ORGANIZER' or 'INVITEE'.
  - `status` -- the current status of this invitee. One of the following: 'INVITED', 'ACCEPTED', 'WITHDRAWN'.
  - `opt_in` -- if `true` then this user has agreed to receive marketing emails from the merchant, but if `false` no marketing emails may be sent, only transactional emails.

Each user info hash contains one of the following depending on how the cost was split:

  - `number_of_spots` -- if the total cost was split evenly or the cost is a fixed amount per person, then this value indicates how many spots this user claimed.
  - `amount_committed` -- if each user was able to enter the amount they are willing to contribute to the total cost, then this value is the amount to which they committed.

Each user info hash may contain the following values if they are available:

  - `age` -- the user's age in years at the time they committed to the purchase.
  - `location` -- the geographic location of the user, typically returned as `city, state`.
  - `gender` -- the gender of the user returned as either `male` or `female`.

Example results:

    { "invitees":
      [
        { "id":          192433,
          "user_id":     9331,
          "user_email":  "user.email@address.com",
          "role":        "ORGANIZER",
          "status":      "ACCEPTED",
          "opt_in":     "true",
          "age":         "34",
          "location":  "New York, New York",
          "gender":   "male",
          "number_of_spots":    "1"
        },
        {

        }
      ]
    }



<br><br>
<p id="transaction_index"></p>
## Group Purchase Transactions
Call for querying the payment transactions associated with a specified group purchase.

**RESPONSE**
  Returns a hash with `transactions` array containig an info hash for each transaction.

  Each transaction contains:

  - `id` -- an integer that uniquely identifies this invitee 'slot'.  This id will be unique across all invitees across all group purchases.
  - `user_id ` -- an integer that uniquely identifies this user. This will be unique to all users using PayByGroup.
  - `amount` -- total amount of money involved in the transaction.
  - `convenience_fee` -- portion of the `amount` that is charged to consumers above the base amount of their share and due to PayByGroup. It is retained by PayByGroup (if using PayByGroup's processor) or direct debited from the merchant on a bi-weekly basis (if using a third-party gateway).
  - `merchant_fee` -- portion of the `amount` that is charged to the merchant and due to PayByGroup. It is deducted from the base amount of the user's share (if using PayByGroup's processor) or direct debited from the merchant on a bi-weekly basis (if using a third-party gateway).
  - `nett_amount` -- amount of money that is ultimately received by the merchant, net of the `convenience_fee` and `merchant_fee`.
  - `created_at` -- time when the transaction was created.
<!-- `action` -- name of the action recorded in a given transaction. One of the following: "CAPTURE", "REVERSE", "PAY_OUT" -->
Example results:

    { "transactions":
      [
        { "id": 165412358,
          "user_id": 9331,
          "amount": "123.45",
          "nett_amount": "120.00",
          "convenience_fee": "2.00",
          "merchant_fee": "1.45",
          "created_at": "2013-01-11T19:20:30-08:00"
        },
        {

        }
      ]
    }

<!-- 
<br><br>
---------------
# MERCHANT PROVIDED API HOOKS
### PayByGroup Initiated APIs
Action    | Resources                                                                | Description
----------| -------------------------------------------------------------------------|-------------------------------------------------------------------------------------------
GET       | [/group_purchases/:id/pull](#purchase_pull_info)          | PBG requests details from merchant regarding a specific purchase
POST      | [/group_purchases/:id/push](#pbg_push_purch_info)         | PBG pushes requested purchase updates to merchant
GET       | [/group_purchases/:id/availability](#pbg_get_availablity) | PBG requests details from merchant regarding inventory availablity for a specific purchase







<br><br><br><br>
<p id="purchase_pull_info"></p>
## **Purchase Pull**

FUNCTION
Allows PayByGroup to query the merchant for additional parameters about a purchase.


Gather information about a potential purchase from the merchant using the 'purchase_id' passed from the merchant to PBG when the user chooses to create a PayByGroup. Any optional variables may be set universally and will apply to all purchases unless overridden in a response parameter here.

URL:
`https://{merchant_purchase_url}/:purchase_id/pull`

METHOD:
`GET`


#### REQUEST PARAMETERS
- **:api\_key**       _(string)_   --  [REQUIRED]  The Merchant's API key.
- **:purchase\_id**   _(string)_   –-  [REQUIRED]  The id of the purchase to be manipulated.

#### RESPONSE FORM
- **:group_purchase** _(hash)_     --  [REQUIRED]  Hash of values to be merged into the parameters of
  the PayByGroup.
- Standard response parameters as listed in the conventions section may be employed by the merchant as 
  appropriate.

  - purchase_cost currency [merchant] -- Idealized total cost of the purchase (including deposits, taxes, and fees). This is the amount PBG sends to the merchant when the PayByGroup completes, unless merchant collected an organizer deposit.
  OR
  - cost_per_person currency [merchant] -- Total cost of one spot (including deposits, taxes, and fees). This amount, multiplied by the total number of people in the group, is sent to the merchant when the PayByGroup completes.
  - purchase_image_url url [merchant] -- URL of the .png or .jpg image that best represents what is being purchased. It is scaled to be the main image on the dashboard. Image is downloaded from URL at the time of the call and proportionately resized so it is 270 pixels high. If its width is greater than 400 pixels, the left and right edges are proportionately clipped to reduce the height to 270 pixels.
  - purchase_name string [merchant] -- Name for this particular purchase.
  - purchase_description text [merchant] -- Detailed information about this purchase.
  - purchase_link_url url [merchant] -- URL link back to this specific purchase on the merchant site.


<br><br><br><br> -->
<br><br>
<p id="pbg_push_purch_info"></p>
## **Group Purchase Updated**
When a Group Purchase gets updated we will `POST` to the `Merchant API URL` the group purchase record with all of the updated details. The attributes that, when updated, will trigger this action are:

- `status`
- `commit_deadline`



Example format:

    { "api_key":  "XXXXXXXXXX",
      "purchase_id":  "123",
      "group_purchase": {
        "id":                 "123",
        "status":             "ACTIVE",
        "name":               "Lorem ipsum",
        "commit_deadline":    "2013-06-19",
        "min_people":         "5",
        "max_people":         "10",
        "splitting_type":     "even_split",
        "purchase_cost":      "1000.00",
        "purchase_id":        "98765",
        "merchant_id":        "EXMR",
        "merchant_name":      "Example Merchant"
      }
    }

