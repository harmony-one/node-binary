#!/bin/bash

KEY=ledgerkey
SYMBOL=ONE-5F9
QUOTE=USDSB-1AC
CHAIN=Binance-Chain-Tigris
PRICE=1489600
PROPOSAL=108
NODE=https://dataseed5.defibit.io:443

./bnbcli dex list --from $KEY --proposal-id $PROPOSAL --node $NODE --chain-id $CHAIN --init-price $PRICE -s $SYMBOL --quote-asset-symbol $QUOTE --json --memo "list $SYMBOL/$QUOTE on BNC"


# {"Height":"22060640","TxHash":"0608E76BA837B8EAB7CA13C23340E4643EFD504313D811B82A6A1504D5036B4C","Response":{"log":"Msg 0: ","tags":[{"key":"YWN0aW9u","value":"ZGV4TGlzdA=="}]}}
