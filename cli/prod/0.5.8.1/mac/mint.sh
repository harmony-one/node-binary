#!/bin/bash

set -x

NODE=dataseed1.binance.org:80 
TOTAL=1260000000000000000
SYMBOL=ONE-5F9
KEY=ledgerkey
CHAIN=Binance-Chain-Tigris

./bnbcli token mint --amount $TOTAL --symbol $SYMBOL --from $KEY --chain-id=$CHAIN --node=$NODE --trust-node 
