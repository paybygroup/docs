# PayByGroup Merchant GUI Elements Documentation

This document covers the configuration and usage of the GUI elements PayByGroup provides for adding functionality to merchant interfaces.


### PayByGroup Light box

The PBG Light box provides the end user with information about the PayByGroup services
and optionally provides them with the ability to initiate a new PayByGroup.  The light box is designed to provide
merchants with considerable flexibility in configuring how PayByGroup is presented to their customers.
Below we list the parameters that control this informational Light box.


#### Adding PayByGroup Components on a merchant site

Copy and place the code snippet just before the closing `</head>`.

    <script src="https://lets.paybygroup.com/api/v1/loader.js"
            data-merchant-id="XXXXXXXX"></script>

Any HTML element can be used to trigger a PayByGoup information light box by adding a **'pbg_info'** value to its class attribute.  Here is an example of a Light box that uses the default behavior.

    <div class="pbg_info"></div>

Here is an example of a Light box that overrides the call to action to goto create a PayByGroup:
    <div class="pbg_info" data-button-icon="horizontal"
         data-purchase-id="1234"
         data-Light box-button-action="to_pbg"></div>


These parameters are typically supplied directly to PayByGroup as a simple JSON hash
of values, but each parameter may also be directly encoded (or overridden) by supplying
an attribute on the HTML DIV used to launch the Light box.  So for example, data-Light box-button-action='to_pbg'
is often used to convert the default informational Light box, into a second Light box whose call to action will
go to PayByGroup purchase creation page, rather than the default button-action which simply closes the
informational Light box.

#### Light box Parameters

- **step1** -- Text content for step 1.
- **step2** -- Text content for step 2.
- **step3** -- Text content for step 3.
- **button-prefix** -- Text to the left of the Light box's primary call to action.
- **button-action** -- Action taken by the Light box's primary call to action button.
  By default the action is `close`, the other legal value is 'to_pbg' which causes
  the informational Light box to progress to the create PayByGroup page.
- **footer** -- "Details" text shown in the footer of the Light box.
- **footer-link** -- The textual content of the optional 'more info' link in the footer.
- **footer-link-url** -- The absolute or relative URL target for the optional footer link
- **popup-target** -- This parameter will indicate the target window that will load the create PayByGroup page. It follows the same convention as a regular target link attribute. Defaults to `self`.
- **partial-name** -- This parameter can be used (in conjunction with design work at PayByGroup) to
  provide a completely different skin for the look and feel for the informational Light box
  By default this paramter maps to the `'default'` skin.



#### Example HTML Snipits invoking the PBG Light box


