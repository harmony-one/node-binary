#!/bin/bash

set -x

NODE=https://dataseed5.defibit.io:443
AMOUNT=500000000:BNB
KEY=ledgerkey
TO=
CHAIN=Binance-Chain-Tigris
ACCOUNT=

echo "checking current balance of account: $ACCOUNT"
./bnbcli account $ACCOUNT --chain-id $CHAIN --node=$NODE --indent

read -p "doing transfer of $AMOUNT to $TO (y/n)?" yn

if [[ "$yn" == "y" || "$yn" == "Y" ]]; then
   ./bnbcli send --from $KEY --to $TO --amount $AMOUNT --ledger --chain-id $CHAIN --node $NODE --json --memo "transfer 5bnb for "
fi
