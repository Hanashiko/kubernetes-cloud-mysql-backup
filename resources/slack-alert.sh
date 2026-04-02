#!/bin/sh


# Check if there is any value in $2. If so, post an entry to the Slack channel with log information. If not, send a general message that all databases successfully completed
if [ "$(printf '%s' "$2")" == '' ]; then
    MESSAGE="$1"
# PAYLOAD="payload={\"channel\": \"$SLACK_CHANNEL\", \"username\": \"$SLACK_USERNAME\", \"text\": \"$1\", \"icon_emoji\": \":slack:\"}"
else
    MESSAGE="$1\n\`\`\`$(echo "$2" | sed "s/\"/'/g")\`\`\`"
# PAYLOAD="payload={\"channel\": \"$SLACK_CHANNEL\", \"username\": \"$SLACK_USERNAME\", \"text\": \"$1\`\`\`$(echo $2 | sed "s/\"/'/g")\`\`\`\", \"icon_emoji\": \":slack:\"}"
fi

PAYLOAD="payload={\"channel\": \"$SLACK_CHANNEL\", \"username\": \"$SLACK_USERNAME\", \"text\": \"$MESSAGE\", \"icon_emoji\": \":slack:\"}"

# Send Slack message
if [ -n "$SLACK_PROXY" ]; then
    curl -s --proxy $SLACK_PROXY -X POST --data-urlencode "$PAYLOAD" "$SLACK_WEBHOOK_URL" > /dev/null
else
    curl -s -X POST --data-urlencode "$PAYLOAD" "$SLACK_WEBHOOK_URL" > /dev/null
fi