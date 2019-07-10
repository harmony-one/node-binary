#!/bin/bash

KEY=ledgerkey
SYMBOL=ONE-5F9
QUOTE=USDSB-1AC
CHAIN=Binance-Chain-Tigris
PRICE=1489600
PROPOSAL=108
NODE=https://dataseed5.defibit.io:443

./bnbcli dex list --from $KEY --proposal-id $PROPOSAL --node $NODE --chain-id $CHAIN --init-price $PRICE -s $SYMBOL --quote-asset-symbol $QUOTE --json --memo "list $SYMBOL/$QUOTE on BNC"
