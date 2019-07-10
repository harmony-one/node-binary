#!/bin/bash

KEY=ledgerkey
SYMBOL=ONE-5F9
QUOTE=USDSB-1AC
EXPIRE=1563926400
VOTE=604800
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

# {"Height":"19245362","TxHash":"12F1D4DD9BB79145DCFD83B9D0074969C41072DDDFE2ABAA5520DF7B728A2F3F","Response":{"data":"MTA4","log":"Msg 0: ","tags":[{"key":"YWN0aW9u","value":"c3VibWl0LXByb3Bvc2Fs"},{"key":"cHJvcG9zZXI=","value":"Ym5iMWEwM3V2cW1ucXpsODVjc254bnN4Mnh5MjhtNzZna2todDQ2ZjJs"},{"key":"cHJvcG9zYWwtaWQ=","value":"MTA4"},{"key":"YWN0aW9u","value":"c3VibWl0X3Byb3Bvc2Fs"}]}}
