#!/bin/bash

# the expire date for the proposal, you need at least 1 week from now on
# default is 7 days
VOTE_DAYS=${1:-7}

# vote period in seconds
VOTE_SECONDS=$(( $VOTE_DAYS * 86400 ))

# expire day is vote days + 1
EXPIRE_DAYS=$(( $VOTE_DAYS + 1 ))

# use dadd to calculate the real expire date
EXPIRE_DATE=$(dadd $(date +%Y-%m-%d) +${EXPIRE_DAYS}d)

# calculate the unix epoch time of the expire date, using UTC 00:00:00 as the time
EXPIRE_EPOCH=$(date -j -f "%Y-%m-%d %H:%M:%S" "$EXPIRE_DATE 00:00:00" +%s)

# readable date/time of the expire date
EXPIRE_READABLE=$(date -r $EXPIRE_EPOCH)

# key and symbol configuraion
KEY=ledgerkey
SYMBOL=ONE-5F9
QUOTE=BTCB-1DE

# binance chain configuration and harmony account in binance chain
CHAIN=Binance-Chain-Tigris
NODE=https://dataseed5.defibit.io:443
ACCOUNT=bnb1a03uvqmnqzl85csnxnsx2xy28m76gkkht46f2l

# proposed listing price
PRICE=111

# list deposit
DEPOSIT_BNB=1000
# command line unit * 10^8
DEPOSIT_BNB_UNIT=$(( $DEPOSIT_BNB * 100000000 ))


echo "checking current balance of account: $ACCOUNT"
./bnbcli account $ACCOUNT --chain-id $CHAIN --node=$NODE --indent

cat<<EOT

================= ================= ================= ================= 
                            LISTING PROPOSAL
================= ================= ================= ================= 

LIST PAIR:    $SYMBOL/$QUOTE
https://explorer.binance.org/asset/$SYMBOL
https://explorer.binance.org/asset/$QUOTE

LIST PRICE:   $PRICE
VOTE DAYS:    $VOTE_DAYS
LIST EXPIRE:  $EXPIRE_READABLE
LIST DEPOSIT: $DEPOSIT_BNB BNB

EOT

read -p "DO IT (y/n)?" yn

if [[ "$yn" == "y" || "$yn" == "Y" ]]; then
   ./bnbcli gov submit-list-proposal --from $KEY --deposit $DEPOSIT_BNB_UNIT:BNB --base-asset-symbol $SYMBOL --quote-asset-symbol $QUOTE --init-price $PRICE --title "list proposal $SYMBOL/$QUOTE" --description "list proposal $SYMBOL/$QUOTE" --expire-time $EXPIRE --voting-period $VOTE --chain-id=$CHAIN --trust-node --node $NODE --json
fi
