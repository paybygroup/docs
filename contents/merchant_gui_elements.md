# PayByGroup Merchant GUI Elements Documentation

This document covers the configuration and usage of the GUI elements PayByGroup provides for adding functionality to merchant interfaces.


### PayByGroup Light box

The PBG Light box provides the end user with information about the PayByGroup services
and optionally provides them with the ability to initiate a new PayByGroup.  The light box is designed to provide
merchants with considerable flexibility in configuring how PayByGroup is presented to their customers.
Below we list the parameters that control this informational Light box.


#### Adding PayByGroup on a merchant site

1. Copy and place the code snippet just before the closing `</body>`.

        <script src="https://lets.paybygroup.com/api/v1/loader.js"
                data-merchant-id="XXXXXXXX"></script>

2. Any HTML element can be used to trigger a PayByGoup information light box by adding a **'pbg_info'** value to its class attribute.  Here is an example of a Light box that uses the default behavior.

        <div class="pbg_info"></div>

    Here is an example of a Light box that overrides the window where the PayByGroup is loaded and the price:
        <div class="pbg_info" data-popup-target="_blank" data-purchase-cost="1337"></div>


#### Light box data attributes
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




#### Example HTML Snipits invoking the PBG Light box


