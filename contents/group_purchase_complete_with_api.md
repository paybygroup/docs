# How to complete a Group Purchase with API
<div class="alert tip">
  <p><strong>Before you continue</strong>: For this flow to work, you need to setup your <code>Merchant API URL</code> so we can know to which URL we need to post messages about the group purchases. <a href="mailto:merchants@paybygroup.com?subject=Merchant API URL Setup">Contact Us</a> .</p>
</div>


## 1. PayByGroup Sends Availability Request
Once all the users that are part of the group purchase have commited to pay for the group purchase, we will send the following JSON to the `Merchant API URL` using a `POST` request.
The callback should return a status of `200` if true and a `204` if false.
#### Request
     {
      "action": "availability",
      "date": "2013-07-16T15:55Z",
      "purchase_id": "XXX",
      "group_purchase": {
        "id":                 "123",
        "status":             "ACTIVE",
        "name":               "Lorem ipsum",
        "commit_deadline":    "2013-06-19",
        "min_people":         "1",
        "max_people":         "10",
        "splitting_type":     "even_split",
        "purchase_cost":      "1000.00",
        "purchase_id":        "98765",
        "merchant_id":        "EXMR",
        "merchant_name":      "Example Merchant",
        "purchase_users":     "5"
        }
     }

<br>

#### Callback
    Status: 200 OK


## 2. PayByGroup Authorizes Captures Payment
We will go through the credit cards and capture payments. If the purchase is successful we send a `POST` request indicating so.
#### Request
     {
      "action": "purchase_complete",
      "date": "2013-07-16T15:55Z",
      "purchase_id": "XXX",
      "group_purchase": {
        "id":                 "123",
        "status":             "ACTIVE",
        "name":               "Lorem ipsum",
        "commit_deadline":    "2013-06-19",
        "min_people":         "1",
        "max_people":         "10",
        "splitting_type":     "even_split",
        "purchase_cost":      "1000.00",
        "purchase_id":        "98765",
        "merchant_id":        "EXMR",
        "merchant_name":      "Example Merchant",
        "purchase_users":     "5"
        }
     }
<br>
#### Callback
      Status: 200 OK

If one or more of the cards **FAIL** we `POST` a message (`availability_release`) to the `Merchant API URL` in order to release availability. After the `availability_release` has been sent the members of the group will fix the problems with their cards and try again to send the `availability`.
#### Request
     {
      "action": "availability_release",
      "date": "2013-07-16T15:55Z",
      "purchase_id": "XXX",
      "group_purchase": {
        "id":                 "123",
        "status":             "ACTIVE",
        "name":               "Lorem ipsum",
        "commit_deadline":    "2013-06-19",
        "min_people":         "1",
        "max_people":         "10",
        "splitting_type":     "even_split",
        "purchase_cost":      "1000.00",
        "purchase_id":        "98765",
        "merchant_id":        "EXMR",
        "merchant_name":      "Example Merchant",
        "purchase_users":     "5"
        }
     }
<br>
#### Callback
      Status: 200 OK
