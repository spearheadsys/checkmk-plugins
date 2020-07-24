#!/bin/bash
# Notify via Microsoft Teams

# Has not been tested with bulking!
# - copy this script into ~/local/share/check_mk/notificaions
# - make sure it is executable
# - create a microsoft teams incoming webhook (https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook)
# - use the Notify via Microsoft Teams Notification Method in your notification rule

# Microsoft webhook:

1. Open the Channel and click the More Options button which appears as three dots at the top right of the window.
2. Select Connectors.
3. Scroll down to Incoming Webhook and click the Add button.
4. Choose a name you like for the connector as well as an image and finally click Create.
5. A new unique URI is automatically generated. Copy this URI string below in the URL variable.
<insert-your-webhook-url>.

TEXT="$NOTIFY_HOSTNAME: $NOTIFY_SERVICEDESC: $NOTIFY_SERVICESTATE $NOTIFY_SERVICEOUTPUT"
URL=""

curl -H "Content-Type: application/json" -d "{\"text\": \"$TEXT\"}" $URL -4
