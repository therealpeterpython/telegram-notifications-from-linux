#!/bin/bash
#
# Takes two filenames as arguments, reads them and sends a telegram message.
# The first file contains the sending information in the format
#   send = (true | false)
#   message = <message text in one line>
#   options = <options handed to telegram-notify.sh script>
#
# The second file contains the bot token and the user chat id in the format
#   token = <telegram-bot-token>
#   chat_id = <chat-id-of-user>
#
# Uses the fantastic https://github.com/NicolasBernaerts/debian-scripts/blob/master/telegram/telegram-notify
# You can find this script here: https://github.com/therealpeterpython/telegram-notifications-from-linux
# Created by therealpeterpython (2025)

if [ -z "$1" ]; then
    echo "Please enter a info file path!" 1>&2
    exit 1
fi

if [ -z "$2" ]; then
    echo "Please enter a token file path!" 1>&2
    exit 1
fi

cd "${0%/*}"  # move to the current script dir

info_file="$1"  # first arg is the name of the info file
token_file="$2"  # second arg is the name of the token file

send=$(cat "$info_file" | grep -i "^send" | cut -d= -f2 | tr '[:upper:]' '[:lower:]')
send=$(echo "${send// /}")  # remove spaces

message=$(cat "$info_file" | grep -i "^message" | cut -d= -f2)

options=$(cat "$info_file" | grep -i "^options" | cut -d= -f2)

chat_id=$(cat "$token_file" | grep -i "^chat_id" | cut -d= -f2)
chat_id=$(echo "${chat_id// /}")  # remove spaces

token=$(cat "$token_file" | grep -i "^token" | cut -d= -f2)
token=$(echo "${token// /}")  # remove spaces

echo send=$send
echo message=$message
echo options=$options
echo chat_id=$chat_id
echo token=$token
if [ "$send" == "1" ] || [ "$send" == "true" ]; then
    ./telegram-notify.sh $options --text "$message" --user "$chat_id" --key "$token" --html
fi
#echo ./telegram-notify.sh "$options" --text \"'$message'\" --user "$chat_id" --key "$token"
echo "------------------------------"

# Clear the info file (activate if needed)
#> "$info_file"
