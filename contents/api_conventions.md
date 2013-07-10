# API Conventions
The following describes the approach used by PayByGroup APIs unless explicitly stated otherwise.

#### FORMAT
  - Data is transferred as URL encoded parameters.
  - Responses are encoded as a single JSON encoded hash in the HTTP response body.
  - The HTTP response mimetype is `application/json`.
  - The calling parameters for all API calls must contain the `api_key` parameter containing the merchant-specific
    authorization token obtained from the merchant account's PayByGroup dashboard.
  - All requests must be `HTTPS`

#### ADDRESSING
  - All API calls must originate from one of the `PBG_ADDRESSES` below or from the supplied `MERCHANT_API_URL`s.
  - In production all calls to PBG must be to the `production` API endpoint below.
  - Staging/testing of new API interactions will typically be done using the `test` or `dev2` addresses below.
  - API calls that originate from PBG to the merchant follow the same format above, and will
    provide the same `merchant_auth` and `action` keys.

#### DATATYPES
  - Datetime format used is `ISO 8601`
    - Date: `YYYY-MM-DD`
    - Datetime: `YYYY-MM-DDTHH:MM:SS-0800`
    (For simplicity, midnight PST time is the expiration time for all PayByGroups. That way no group is surprised
    to have theirs expire before midnight in their local time, and the expiration does not need to be conditioned
    on the location of one or more users.)
  - CURRENCY: "#####.##" -- The current format is a simple decimal encoded as a string representing US dollars.
    - Our future format will include currency indicators:  "###.## USD"
      A string containing a decimal followed by a space and a currency indicator
      (e.g. "USD" for US dollars)

#### API ENDPOINTS
 - `production` - https://lets.paybygroup.com/api/v1/
 - `test` - https://lets2.paybygroup.com/api/v1/
 - 50.57.115.142 (dev2)
 - 50.57.106.140 (dev1)

#### MERCHANT\_API\_URL
- IP address supplied by the merchant

#### MERCHANT\_AUTH
- 32-character sequence of printable ASCII characters

#### RESPONSE FORMAT
- All client error (4xx) API calls return a hash with the following parameters along with parameters specific
   to each API call.

    - `user_message`: An optional English language message suitable for display to the end user.
    - `developer_message`: A more detailed message affording the developer greater insight into the error.
    - `more_info`: Additional information, e.g. a link to documentation


#### HTTP STATUS CODES

- `200 OK` - returned after successful GET request
- `201 Created` - returned after successful POST request
- `400 Bad Request` - malformed API request
- `401 Unauthorized` - you are not authorized to perform this action
- `403 Forbidden` - you do not have permission for this action
- `404 Not Found` - requested API endpoint doesn't exist
- `405 Method Not Allowed` - requested action is not allowed in current state
- `500 Internal Server Error` - error on server