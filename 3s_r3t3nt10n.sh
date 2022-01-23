#!/bin/bash
# @mitzex01 20211228
# delete old indice pattern in elasticsearch
# cron job: 10 0 * * 1 /opt/retention/3s_r3t3nt10n.sh

# creds elasticsearch ==========
if [ -f /opt/retention/.env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# patterns ==========
# +%Y.%V -->  2020.52
# +%Y.%m.%d --> 2020.12.24
index="*-$(date -d "-395 days" +%Y.%V)*"
# echo "debug -> $index" >> /opt/retention/retention-plain.log

# detlete index pattern ==========
req=$(curl -XDELETE -u$ES_USER:$ES_PASS "http://$ES_HOST:9200/$index")

# logging ==========
echo "date: $(date), command: \"DELETE $index\", result: $req" >> /opt/retention/retention-plain.log