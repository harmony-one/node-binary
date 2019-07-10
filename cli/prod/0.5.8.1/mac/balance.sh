#!/bin/bash

CHAIN=Binance-Chain-Tigris
NODE=https://dataseed5.defibit.io:443
ACCOUNT=bnb1a03uvqmnqzl85csnxnsx2xy28m76gkkht46f2l

echo "checking current balance of account: $ACCOUNT"
./bnbcli account $ACCOUNT --chain-id $CHAIN --node=$NODE --indent
