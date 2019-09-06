#!/bin/bash

# this script is used to do time lock/unlock on binance chain

function lock_leo_ledger
{
   ./bnbcli token time-lock --amount "5000000000:ONE-5F9" --from leoledger --description "Harmony TimeLock 50 ONE-5F9" --lock-time 1567809600 --chain-id Binance-Chain-Tigris --trust-node --node http://dataseed1.binance.org:80 --broadcast
}

function lock_harmony_ledger
{
   # lock till Saturday, 05-Oct-19 00:00:00 UTC in RFC 2822
   ./bnbcli token time-lock --amount "10000000000000000:ONE-5F9" --from ledgerkey --description "Harmony TimeLock 100,000,000 ONE-5F9" --lock-time 1570233600 --chain-id Binance-Chain-Tigris --trust-node --node http://dataseed1.binance.org:80 --broadcast
}


function unlock_leo_ledger
{
   ./bnbcli token time-unlock --from leoledger --time-lock-id 1 --chain-id Binance-Chain-Tigris --trust-node --node http://dataseed1.binance.org:80
}

# lock_leo_ledger
# unlock_leo_ledger
lock_harmony_ledger
