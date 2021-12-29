#!/bin/bash
# @mitzex01 20211228
# delete data indice in es
if [ -f /opt/retention/.env ]; then
    export $(grep -v '^#' .env | xargs)
fi
index="*-$(date -d "-395 days" +%Y.%V)*"
req=$(curl -XDELETE -u$ES_USER:$ES_PASS "http://$ES_HOST:9200/$index")
echo "date: $(date), command: \"DELETE $index\", result: $req" >> /opt/retention/retention-plain.log

#echo "debug -> $index" >> /opt/retention/retention-plain.log
# cron: 10 0 * * 1 /opt/retention/3s_r3t3nt10n.sh