# PayByGroup JS Integration

![PayByGroup Light box](/images/popup.png)


<!-- ### PayByGroup Light box

The PBG Light box provides the end user with information about the PayByGroup services
and optionally provides them with the ability to initiate a new PayByGroup.  The light box is designed to provide
merchants with considerable flexibility in configuring how PayByGroup is presented to their customers.
Below we list the parameters that control this informational Light box. -->


## Adding PayByGroup in < 5 minutes

1. Copy and place the code snippet just before the closing `</body>`.

        <script src="https://lets.paybygroup.com/snippet/v1/loader.js"
                data-merchant-id="XXXXXXXX"></script>

2. Any HTML element can be used to trigger a PayByGoup information light box by adding a **pbg_info** value to its class attribute. If the HTML element is empty we will populate it with the PayByGroup button. For example.

        <div class="pbg_info"></div>

    This will generate the following button.
    ![PayByGroup Button](/images/pbg_orange.png)

3. Make it rain! ![Show me the kwan](/images/dollar.png)

## Data Attributes
In order to customize your PayByGroup you need to add the following data attributes to your **pbg_info** element.

<div class="alert tip">
  <p><strong>Tip</strong>: Remember to add data attributes in the element in the following way <code>data-purchase-name="Hello world"</code> .</p>
</div>
<dl>
  <dt>purchase-image-url</dt>
  <dd>URL for the PayByGroup image.</dd>
  <dt>purchase-name</dt>
  <dd>Name of the product/service for the PayByGroup.</dd>
  <dt>purchase-id</dt>
  <dd>Your ID used to identify the purchase for your records.</dd>
  <dt>purchase-cost</dt>
  <dd>Total cost of the purchase in dollars. i.e. 45.80</dd>
  <dt>purchase-link-url</dt>
  <dd>URL for the page of the product/service.</dd>
  <dt>purchase-description</dt>
  <dd>Description of the purchase.</dd>
</dl>
An example of all attributes would be:
    <div class="pbg_info"
      data-purchase-image-url="http://example.com/picture.png"
      data-purchase-name="Awesome Escape"
      data-purchase-id="ESCAPE-23"
      data-purchase-cost="500.45"
      data-purchase-link-url="http://example.com/property"
      data-purchase-description="Great rental for 3 people with lake view." >
    </div>
<br>
<hr>
<br>
## Other Commonly Used Data Attributes
These attributes are used on a need basis depending on your product/service.
<dl>
  <dt>purchase-start-date</dt>
  <dd>If your service needs to store a start date. i.e. Reservation start date.</dd>
  <dt>purchase-start-date</dt>
  <dd>If your service needs to store an end date. i.e. Reservation end date.</dd>
  <dt>hold-deadline</dt>
  <dd>Date on which the hold expires and the inventory becomes subject to availability.</dd>
</dl>
<br>
<hr>
<br>
## Sample Implementation
<br>
#### Part 1 - Informational Unit(s)
<br>
Add an informational unit using any of the copy and design examples listed in the [Design Guidelines](/design_guidelines)
 on one or more of the following pages:

•   Homepage <br>
•   Search results page <br>
•   Product listing page

You may customize the look and feel to match your site as long as the IMAGELINKPayByGroup LogoIMAGELINK is included whenever the term "PayByGroup" is used.

When clicked, the informational unit displays the lightbox explaining how PayByGroup works, and the only option on the lightbox is to close it and keep browsing.

<div class="alert tip">
  <p>The key parameter that defines these divs as informational units is <code>data-button-action="close"</code> .</p>
</div>

No other data attributes need to be defined for the informational units, though you can customize them if you like.

Here is an example of an informational unit:


![Info Unit](/images/info_unit.png)

<br>
<br>
#### Part 2 - Use PayByGroup Option

Place the option to use PayByGroup at the earliest point on your site where the total cost is available - including all taxes, fees, and options. This will typically be on the first page of your checkout process.

<div class="alert tip">
  <p><strong>Tip</strong>: This is where you should be sure to set the data attributes listed above and any additional ones you want to include</code> .</p>
</div>

Here is an example of the option to use PayByGroup where the div and button have been styled to match the merchant's existing site:

![Use PayByGroup](/images/use_paybygroup.png)
<br>
<br>
<br>
## Advanced Light Box Data Attributes
![PayByGroup Demo Light Box](/images/demo_light_box.png)
<dl>
  <dt>button-action</dt>
  <dd>Action taken by the Light box's primary call to action button.
  By default the action is <code>to_pbg</code> which sends the user to create a PayByGroup using the parameters specified for the group purchase.The other legal value is <code>close</code> which causes
  the informational Light box to close.</dd>
  <dt>popup-target</dt>
  <dd>This parameter will indicate the target window that will load the create PayByGroup page. It follows the same convention as a regular target <a href="http://www.w3schools.com/tags/att_link_target.asp">link attribute</a>. Defaults to <code>self</code>.</dd>
  <dt>popup-button</dt>
  <dd>Text for the action button on the Light box.</dd>
  <dt>step1</dt>
  <dd>Text content for step 1.</dd>
  <dt>step2</dt>
  <dd>Text content for step 2.</dd>
  <dt>step3</dt>
  <dd>Text content for step 3.</dd>
  <dt>footer</dt>
  <dd>"Details" text shown in the footer of the Light box.</dd>
  <dt>footer-link</dt>
  <dd>The textual content of the optional 'more info' link in the footer.</dd>
  <dt>footer-link-url</dt>
  <dd>The absolute or relative URL target for the optional footer link.</dd>
</dl>

## Group Purchase Attributes

The PBG Light box also takes parameters to modify the contents for the **group purchase**. These parameters can be found in [Merchant Input Variables](/merchant_input_variables)
