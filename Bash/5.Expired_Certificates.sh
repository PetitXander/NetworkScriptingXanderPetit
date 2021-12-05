#!/bin/bash

if [ "$(id -u)" -ne 0 ]
then
        # Stopping the script
        echo "This script must be run as root"
        exit 1
fi

#alle .crt bestandsnamen in een file plaatsen
find / -type f -name '*.crt' >> /home/user/NetworkScripting/crts.txt

FILE="/home/user/NetworkScripting/crts.txt"
LINES=$(cat $FILE)

for LINE in $LINES
do
    DATE=$(openssl x509 -enddate -noout -in $LINE)

    MONTH="$(echo "$DATE" | cut -b 10,11,12)"
    DAY="$(echo "$DATE" | cut -b 14,15)"
    YEAR="$(echo "$DATE" | cut -b 26,27,28,29)"

    DAYCORRECTION="$(echo "$DAY" | cut -b 1)"
    if [[ "$DAYCORRECTION" == " " ]]; then
        DAY="$(echo "$DAY" | cut -b 2)"
    fi

    NEWDATE="$DAY-${MONTH^^}-$YEAR"

    CERTIFICATEDATE=$(date -d "$NEWDATE" +"%s")
    OUTDATEDDATE=$(date -d "$dt +14 day" +"%s")
    CURRENTDATE=$(date +%s)

    if [ $CURRENTDATE -gt $CERTIFICATEDATE ] && [ $CERTIFICATEDATE -le $OUTDATEDDATE ]; then
> /home/user/NetworkScripting/almostinvalidcertificates.txt
        echo "$LINE" >> /home/user/NetworkScripting/almostinvalidcertificates.txt
    fi
done

# File leegmaken
> $FILE
root@win07-linux:/home/user/NetworkScripting# vim CheckCerts2.sh
root@win07-linux:/home/user/NetworkScripting# cat CheckCerts2.sh
#!/bin/bash

#alle .crt bestandsnamen in een file plaatsen
find / -type f -name '*.crt' >> /home/user/NetworkScripting/crts.txt

FILE="/home/user/NetworkScripting/crts.txt"
LINES=$(cat $FILE)

for LINE in $LINES
do
    DATE=$(openssl x509 -enddate -noout -in $LINE)

    MONTH="$(echo "$DATE" | cut -b 10,11,12)"
    DAY="$(echo "$DATE" | cut -b 14,15)"
    YEAR="$(echo "$DATE" | cut -b 26,27,28,29)"

    DAYCORRECTION="$(echo "$DAY" | cut -b 1)"
    if [[ "$DAYCORRECTION" == " " ]]; then
        DAY="$(echo "$DAY" | cut -b 2)"
    fi

    NEWDATE="$DAY-${MONTH^^}-$YEAR"

    CERTIFICATEDATE=$(date -d "$NEWDATE" +"%s")
    OUTDATEDDATE=$(date -d "$dt +14 day" +"%s")
    CURRENTDATE=$(date +%s)

    if [ $CURRENTDATE -gt $CERTIFICATEDATE ] && [ $CERTIFICATEDATE -le $OUTDATEDDATE ]; then
> /home/user/NetworkScripting/almostinvalidcertificates.txt
        echo "$LINE" >> /home/user/NetworkScripting/almostinvalidcertificates.txt
    fi
done

# File leegmaken
> $FILE