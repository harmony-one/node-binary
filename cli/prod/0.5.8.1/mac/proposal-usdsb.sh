#!/bin/bash

KEY=ledgerkey
SYMBOL=ONE-5F9
QUOTE=USDSB-1AC
EXPIRE=1560265944
VOTE=86400
CHAIN=Binance-Chain-Tigris
PRICE=1489600
NODE=https://dataseed5.defibit.io:443
ACCOUNT=bnb1a03uvqmnqzl85csnxnsx2xy28m76gkkht46f2l

echo "checking current balance of account: $ACCOUNT"
./bnbcli account $ACCOUNT --chain-id $CHAIN --node=$NODE --indent

read -p "doing listing proposal of $SYMBOL/$QUOTE (y/n)?" yn

if [[ "$yn" == "y" || "$yn" == "Y" ]]; then
   ./bnbcli gov submit-list-proposal --from $KEY --deposit 100000000000:BNB --base-asset-symbol $SYMBOL --quote-asset-symbol $QUOTE --init-price $PRICE --title "list $SYMBOL/$QUOTE" --description "list $SYMBOL/$QUOTE" --expire-time $EXPIRE --voting-period $VOTE --chain-id=$CHAIN --trust-node --node $NODE --json
fi
