#!/bin/bash

set -x

NODE=dataseed1.binance.org:80 
TOTAL=1260000000000000000
SYMBOL=ONE
KEY=ledgerkey
CHAIN=Binance-Chain-Tigris

./bnbcli token issue --token-name "Harmony.One" --total-supply $TOTAL --symbol $SYMBOL --mintable --from $KEY --chain-id=$CHAIN --node=$NODE --trust-node 
