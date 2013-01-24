# Popup Docs



### PayByGroup Popup

The PBG Popup is designed to provide merchants with considerable
flexibilty in configuring how paybygroup is presented to their customers.
Below we list the parameters that control this informational popup.  

These parameters are typically supplied directly to PayByGroup as a simple JSON hash
of values, but each parameter may also be directly encoded (or overridden) by supplying
an attribute on the HTML DIV used to launch the popup.  So for example, data-popup-button-action='to_pbg'
is often used to convert the default informational popup, into a second popup whose call to action will 
go to PayByGroup purchase creation page, rather than the default button-action which simply closes the
informational popup.

#### Popup Parameters

- **step1** -- Text content for step 1.
- **step2** -- Text content for step 2.
- **step3** -- Text content for step 3.
- **button_prefix** -- Text to the left of the popup's primary call to action.
- **button_action** -- Action taken by the popup's primary call to action button.
  By default the action is `close`, the other legal value is 'to_pbg' which causes
  the informational popup to progress to the create PayByGroup page.
- **footer** -- "Details" text shown in the footer of the popup.
- **footer_link** -- The textual content of the optional 'more info' link in the footer.
- **footer_link_url** -- The absolute or relative URL target for the optional footer link
- **partial_name** -- This parameter can be used (in conjunction with design work at PayByGroup) to 
  provide a completely different skin for the look and feel for the informational popup.  
  By default this paramter maps to the `'default'` skin.
  
  

#### Example HTML Snipits invoking the PBG Popup

The HTML must contain the PBG bootstrap.js:
    <script src="/merch/integrated/bootstrap.js"></script>


The popup itself is triggered by any HTML element (e.g. a `DIV`) with a `pbg_info` class.
Here is an example of a popup that uses default parameters for the popup.
    <div class="pbg_info" data-button-icon="pbg_transparent_logo_small" 
	     data-merchant-id="cabo" data-button-width="200"></div>


Here is an example of a popup that overrides the call to action to goto create a PayByGroup:
    <div class="pbg_info" data-button-icon="horizontal" 
	     data-merchant-id="cabo" data-purchase-id="1234" 
		 data-popup-button-action="to_pbg"></div>
