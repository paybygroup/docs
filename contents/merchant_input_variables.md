# PayByGroup Merchant Input Variables
<div class="alert tip">
  <p><strong>Tip</strong>: When using these attributes on [JS Snippet] (/js_integration), turn <code>_</code> in to <code>-</code><br>For example : <code>merchant_api_url => merchant-api-url</code> .</p>
</div>

## Merchant Configuration
<dl>
  <dt>api_key <code><i>string</i></code></dt>
  <dd>A 32-character sequence of printable ASCII characters.</dd>
 <!-- <dt>merchant_api_url <code><i>url</i></code></dt>
  <dd>Used to display on credit card statements and cannot be greater than 11 characters.</dd> -->
  <dt>merchant_agent_email <code><i>string</i></code></dt>
  <dd>Email address(es) where email notifications are sent with updates on the purchase and requests for actions, such as confirming a purchase when it completes.</dd>
</dl>

## Skinning
Typically set globally per merchant and occasionally overridden on an individual purchase basis.
<dl>
  <dt>merchant_display_name <code><i>string</i></code> </dt>
  <dd>Phrase used to refer to the merchant in all user-facing situations.</dd>
  <dt>merchant_short_name <code><i>string</i></code> </dt>
  <dd>Used to display on credit card statements and CANNOT be greater than 11 characters.</dd>
  <dt>merchant_phone <code><i>string</i></code> </dt>
  <dd>Support contact phone number for the merchant displayed to users.</dd>
  <dt>merchant_terms_of_service_title <code><i>string</i></code> </dt>
  <dd>Text used to reference the merchant’s terms of service or equivalent on the credit card submission page for all members of the PayByGroup to agree to.</dd>
  <dt>merchant_terms_of_service_link <code><i>url</i></code> </dt>
  <dd>URL hyperlinked from the merchant_terms_of_service_title to the full copy of the terms of service or its equivalent hosted on the merchant's website.</dd>
  <dt>merchant_terms_of_service_copy <code><i>text</i></code> </dt>
  <dd>HTML markup of the actual text of the
terms of service document that will be displayed on PayByGroup’s site and linked from the merchant_terms_of_service_title (typically used if it is not possible to provide a merchant_terms_of_service_link or the merchant wants the full copy to be embedded when the user accepts the terms).</dd>
</dl>

## Inventory
These variables are set when the PayByGroup is created using the [JS Snippet] (/js_integration). <!--, and certain ones are editable later via the Purchase Update API -->
<dl>
  <dt>purchase_id <code><i>string</i></code></dt>
  <dl>Unique ID for this purchase supplied by the merchant. Retained by PBG and merchant for at least one calendar year and required to use most [API capabilities] (/pbgapis).</dl>
  <dt>purchase_image_url <code><i>url</i></code></dt>
  <dl>URL of the .png or .jpg image that best represents what is being purchased. It is scaled to be the main image on the dashboard at 400 pixels high and 270 pixels wide. Image is downloaded from URL at the time of the call.</dl>
  <dt>purchase_name <code><i>text</i></code></dt>
  <dl>Name of what is being purchased as provided by the merchant.</dl>
  <dt>purchase_description <code><i>text</i></code></dt>
  <dl>Explanatory text supplied by the merchant and describing all additional details of what is being purchased. Basic HTML elements are allowed for formatting.</dl>
  <dt>purchase_link_url  <code><i>url</i></code></dt>
  <dl>URL linking back to the merchant’s site for the item being purchased or a shopping cart listing all the items being purchased as part of this PayByGroup.</dl>
  <dt>purchase_inventory_id  <code><i>string</i></code></dt>
  <dl>An ID provided by the merchant that represents a piece of inventory that may be involved in multiple purchases, e.g. a house that is booked for different times in separate PayByGroups, each with a unique `purchase_id`.</dl>
  <dt>hold_type  <code><i>string</i></code></dt>
  <dl>Must be one of:
    <ul>
      <li><strong>"no_hold"</strong>Purchase is subject to availability of the inventory at time of completion.</li>
      <li><strong>"free_hold"</strong>The inventory is reserved for a specified period of time without any initial payment or deposit, usually 1-3 days, after which it is subject to availability.</li>
      <li><strong>"deposit_hold"</strong>An initial payment or deposit is made by the organizer, either on the merchant’s site or as part of their creating a PayByGroup, in order to reserve the inventory for a specified period or time or until the PayByGroup completes.</li>
    </ul>
  </dl>
  <dt>hold_deadline  <code><i>date</i></code></dt>
  <dl>If <strong>hold_type</strong> is either <strong>“free_hold”</strong> or <strong>“deposit_hold”</strong>, this is the date on which the hold expires and the inventory becomes subject to availability. This date is displayed on the organizer’s dashboard.</dl>
  <dt>purchase_deadline  <code><i>date</i></code></dt>
  <dl>Date at which this PayByGroup becomes invalid at 11:59 PM PST. The PayByGroup is frozen and cannot be updated or completed after this date unless the `purchase_deadline` is edited by the merchant to be at a later date. If it is not extended, the inventory should be released.</dl>
  <dt>inventory_state  <code><i>string</i></code></dt>
<!--  <dl>Specifies the current state of the inventory underlying a
purchase. Possible values are:
    <ul>
      <li><strong>"available"</strong>The inventory is still available.</li>
      <li><strong>"unavailable"</strong>The inventory is no longer available.</li>
      <li><strong>"unknown"</strong>The status of the inventory cannot be instantly determined.</li>
    </ul>
  </dl> -->
  <dt>merchant_org_email <code><i>string</i></code></dt>
  <dl>Default email for the organizer used to reference the organizer in the merchant’s system and to streamline their experience setting up their PayByGroup.</dl>
  <dt>merchant_org_first_name <code><i>string</i></code></dt>
  <dl>Default first name for the organizer.</dl>
  <dt>merchant_org_last_name <code><i>string</i></code></dt>
  <dl>Default last name for the organizer.</dl>
</dl>

## Payments and Splitting
<dl>
  <dt>purchase_cost <code><i>currency</i></code></dt>
  <dl>Idealized total cost of the purchase (including deposits, taxes, and fees). This is the amount PayByGroup sends to the merchant when the PayByGroup completes, unless the merchant collected an organizer deposit as a portion of the total cost<sup>1</sup>.</dl>
  <dt>pp_cost <code><i>currency</i></code></dt>
  <dl>Total cost of one spot (including deposits, taxes, and fees). This amount, multiplied by the total number of people in the group, is sent to the merchant when the PayByGroup completes<sup>1</sup>.</dl>
  <dt>min_min_people <code><i>integer</i></code></dt>
  <dl>Minimum users who must be part of the purchase in order for it to complete.</dl>
  <dt>max_max_people <code><i>integer</i></code></dt>
  <dl>Maximum users who are allowed to be part of the purchase.</dl>
  <dt>organizer_deposit <code><i>currency</i></code></dt>
  <dl>Amount of the deposit required from the organizer in order to allow for a `deposit_hold`. This amount is paid by the organizer at the time the purchase is created if `pbg_collects_org_deposit` is `true`.</dl>
  <dt>pbg_collects_org_deposit <code><i>object</i></code></dt>
  <dl>Specifies whether PayByGroup collects the deposit when the organizer creates their PayByGroup. If not specified and `organizer_deposit` is greater than zero, it is assumed the deposit has been collected directly by the merchant.</dl>
  <dt>allow_even_split <code><i>object</i></code></dt>
  <dl>Allow organizer to select the even splitting method, which will automatically divide the total cost by the number of people that commit. <strong>purchase_cost</strong> must be specified.</dl>
  <dt>allow_fixed_per_person <code><i>object</i></code></dt>
  <dl>Allow organizer to select the fixed per person splitting method, which sets the cost of each spot as a fixed amount. `cost_per_person` must be specified to enable this option.</dl>
  <dt>allow_specified_per_person <code><i>object</i></code></dt>
  <dl>Allow organizer to select the specified per person splitting method, which means each member of the group will specify the amount they are contributing. The tipping point is reached once the total dollar amount needed is committed.</dl>
</dl>
<br>
<hr>
<br>
<sup>1</sup> Only one of either `purchase_cost` or `cost_per_person` should be provided for any given purchase
