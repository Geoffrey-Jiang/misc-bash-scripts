#!/bin/dash

# Simple script to email an attachment from current directory

if test $# -ge 1
then
    for item in "$@"
    do
        display "$item"
        echo -n "Address to e-mail this image to?" 
        read email

        echo -n "Message to accompany image?"
        read message

        if echo $message | mutt -s "Image Email" -e 'set copy=no' -a "$item" -- "$email"
        then
            echo "$item sent to $email"
        else
            echo "No email sent" 1>&2
        fi
    done

else
    echo "Usage: $0 <image attachments>" 1>&2
fi
