# Group Purchase Output Variables

## Group Purchase Status
<dl>
  <dt>status <code><i>string</i></code></dt>
  <dd>
    <ul>
      <li><strong>"GP_NOT_CLAIMED"</strong>The PayByGroup was initiated by the merchant, but the organizer never completed setting it up.</li>
      <li><strong>"GP_NEW"</strong>The Organizer reached the page to set the details of their PayByGroup.</li>
      <li><strong>"GP_INPUT_COMPLETE"</strong>The Organizer has set all the details of their PayByGroup but not completed signup to complete creation of the purchase.</li>
      <li><strong>"GP_DEPOSIT_REQUIRED"</strong>Organizer must insert payment info and make deposit to hold the purchase.</li>
      <li><strong>"GP_ACTIVE"</strong>The PayByGroup was successfully created but has not yet tipped. The organizer can send payment to the merchant at any point prior to the tipping point being reached by making up the shortfall on their own.</li>
      <li><strong>"GP_HAS_INVITEES"</strong>Active, and initial invitations sent.</li>
      <li><strong>"GP_ORG_COMMIT"</strong>Organizer has approved the purchase, and payments are in the process of being authorized.</li>
      <li><strong>"GP_AUTHORIZED"</strong>Payments have all been authorized, and the purchase is awaiting final merchant approval.</li>
      <li><strong>"GP_MERCH_COMMIT"</strong>Payment has been approved by the merchant.</li>
      <li><strong>"GP_COLLECTED"</strong>All payments have been captured from users.</li>
      <li><strong>"GP_MERCHANT_PAID"</strong>Payment has been successfully completed to the merchant.</li>
      <li><strong>"GP_CANCELED"</strong>PayByGroup canceled by organizer or merchant.</li>
      <li><strong>"GP_FAILED"</strong>Payments failed to complete.</li>
      <li><strong>"GP_PAYOUT_FAILED"</strong>Payment was collected successfully, but the payout to the merchant failed.</li>
      <li><strong>"GP_REFUND_REQUESTED"</strong>The merchant has initiated a full or partial refund.</li>
      <li><strong>"GP_REFUNDED"</strong>The requested refund has successfully completed.</li>
    </ul>
  </dd>
</dl>

## Group Purchase Details
<dl>
  <dt>id <code><i>integer</i></code></dt>
  <dl>System ID of this particular group purchase, which is used to query [the API](/pbgapis) for details on a particular group purchase.</dl>
  <dt>name <code><i>string</i></code></dt>
  <dl>Name for this particular Group Purchase assigned by the organizer when it was created.</dl>
  <dt>details_text <code><i>text</i></code></dt>
  <dl>Extra explanation provided by the organizer and displayed on the dashboard for this PayByGroup.</dl>
  <dt>min_people <code><i>integer</i></code></dt>
  <dl>Minimum number of people required by the organizer for the PayByGroup to tip. Must be greater than or equal to `min_min_people` if that constraint is set by the merchant.</dl>
  <dt>max_people <code><i>integer</i></code></dt>
  <dl>Maximum number of people allowed by the organizer to join the PayByGroup. Must be less than or equal to `max_max_people` if that constraint is set by the merchant.</dl>
  <dt>commit_deadline <code><i>date</i></code></dt>
  <dl>Date set by organizer by which invitees must respond. It cannot be set later than the `purchase_deadline` as set by the merchant.</dl>
  <dt>invite_subject <code><i>string</i></code></dt>
  <dl>Text of the email subject line used by the organizer when sending invitations.</dl>
  <dt>invite_message <code><i>string</i></code></dt>
  <dl>Message sent by the organizer to the invitees to invite them to participate in the PayByGroup.</dl>
  <dt>created_at <code><i>date</i></code></dt>
  <dl>The date/timestamp of when a PayByGroup was created.</dl>
  <dt>updated_at <code><i>date</i></code></dt>
  <dl>The date/timestamp of when a PayByGroup last had any values change.</dl>
  <dt>num_people <code><i>integer</i></code></dt>
  <dl>Number of people currently committed to a given PayByGroup.</dl>
  <dt>pp_cost <code><i>currency</i></code></dt>
  <dl>The current cost per person based on the number of people committed.</dl>
</dl>
