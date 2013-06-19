# Group Purchase Output Variables

## Purchase Status
<dl>
  <dt>status <code><i>string</i></code></dt>
  <dd>
    <ul>
      <li><strong>"incomplete"</strong>The PayByGroup was initiated by the merchant but never completed by the organizer.</li>
      <li><strong>"active"</strong>The PayByGroup was successfully created but has not yet tipped. The organizer can send payment to the merchant at any point prior to the tipping point being reached by making up the shortfall on their own.</li>
      <li><strong>"tipped"</strong>PayByGroup has reached its tipping point, and the organizer is able to send payment to the merchant.</li>
      <li><strong>"pending"</strong>Organizer has submitted payment to merchant and is awaiting confirmation.</li>
      <li><strong>"collected"</strong>Full payment for the PayByGroup has been collected and is in the process of being paid out to the merchant.</li>
      <li><strong>"payment_completed"</strong>The PayByGroup tipped, organizer authorized payment, and funds were deposited to the merchant’s bank account.</li>
      <li><strong>"expired"</strong>The purchase_deadline passed without payment being submitted.</li>
      <li><strong>"canceled"</strong>The organizer or merchant canceled the PayByGroup.</li>
      <li><strong>"failed"</strong>Payment was submitted, but full funds could not be collected and paid to the merchant.</li>
    </ul>
  </dd>
</dl>

## Purchase Details
<dl>
  <dt>name <code><i>string</i></code></dt>
  <dl>Name for this particular Group Purchase assigned by the organizer when it was created.</dl>
  <dt>details_text <code><i>text</i></code></dt>
  <dl>Extra explanation provided by the organizer and displayed on the dashboard for this PayByGroup.</dl>
  <dt>min_people <code><i>integer</i></code></dt>
  <dl>Minimum number of people required by the organizer for the PayByGroup to tip.</dl>
  <dt>max_people <code><i>integer</i></code></dt>
  <dl>Maximum number of people allowed by the organizer to join the PayByGroup.</dl>
  <dt>commit_deadline <code><i>date</i></code></dt>
  <dl>Date set by organizer by which invitees must respond. It cannot be set later than the purchase_deadline as set by the merchant.</dl>
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