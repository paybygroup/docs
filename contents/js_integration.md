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

2. Any HTML element can be used to trigger a PayByGoup information light box by adding a **pbg_info** value to its class attribute.  For example.

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
  <dt>purchase-description</dt>
  <dd>Description of the purchase.</dd>
</dl>
An example of all attributes would be:
    <div class="pbg_info" data-purchase-image-url="http://example.com/picture.png" data-purchase-name="Awesome Escape" data-purchase-id="ESCAPE-23" data-purchase-cost="500.45" data-purchase-description="Great rental for 3 people with lake view." ></div>
<br>
<hr>
<br>
## Advanced Light Box Data Attributes
<dl>
  <dt>step1</dt>
  <dd>Text content for step 1.</dd>
  <dt>step2</dt>
  <dd>Text content for step 2.</dd>
  <dt>step3</dt>
  <dd>Text content for step 3.</dd>
  <dt>button-prefix</dt>
  <dd>Text to the left of the Light box's primary call to action.</dd>
  <dt>button-action</dt>
  <dd>Action taken by the Light box's primary call to action button.
  By default the action is `close`, the other legal value is 'to_pbg' which causes
  the informational Light box to progress to the create PayByGroup page.</dd>
  <dt>footer</dt>
  <dd>"Details" text shown in the footer of the Light box.</dd>
  <dt>footer-link</dt>
  <dd>The textual content of the optional 'more info' link in the footer.</dd>
  <dt>footer-link-url</dt>
  <dd>The absolute or relative URL target for the optional footer link.</dd>
  <dt>popup-target</dt>
  <dd>This parameter will indicate the target window that will load the create PayByGroup page. It follows the same convention as a regular target <a href="http://www.w3schools.com/tags/att_link_target.asp">link attribute</a>. Defaults to <code>self</code>.</dd>
  <dt>partial-name</dt>
  <dd>This parameter can be used (in conjunction with design work at PayByGroup) to provide a completely different skin for the look and feel for the informational Light box. By default this paramter maps to the <code>default</code> skin.</dd>
</dl>

## Group Purchase Attributes

The PBG Light box also takes parameters to modify the contents for the **group purchase**. These parameters can be found in [Merchant Input Variables](/merchant_input_variables)
