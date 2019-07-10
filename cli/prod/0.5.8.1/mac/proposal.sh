#!/bin/bash

KEY=ledgerkey
SYMBOL=ONE-5F9
EXPIRE=1560265944
VOTE=86400
CHAIN=Binance-Chain-Tigris
PRICE=20000

./bnbcli gov submit-list-proposal --from $KEY --deposit 100000000000:BNB --base-asset-symbol $SYMBOL --quote-asset-symbol BNB --init-price $PRICE --title "list ONE-5F9/BNB" --description "list ONE-5F9/BNB" --expire-time $EXPIRE --voting-period $VOTE --chain-id=$CHAIN --trust-node --node http://dataseed1.binance.org:80 --json
