#!/bin/bash

if [ -z $BNBCLI ]; then
   BNBCLI=../0.6.1/linux/bnbcli
fi

# key and symbol configuraion
KEY=[Enter key name here]

# symbol of Harmony $ONE
SYMBOL=ONE-5F9

# quote symbol
QUOTE=

# proposed listing price
PRICE=

# binance chain configuration and harmony account in binance chain
CHAIN=Binance-Chain-Tigris
NODE=https://dataseed5.defibit.io:443
ACCOUNT=[Enter bnb address here]

# list deposit
DEPOSIT_BNB=1000
# command line unit * 10^8
DEPOSIT_BNB_UNIT=$(( $DEPOSIT_BNB * 100000000 ))

function usage
{
   ME=$(basename $0)
   cat<<EOT

$ME [OPTIONS] ACTION 

This script is used by Harmony team to interact with Binance Chain.

OPTIONS:
   -h                   print this message
   -d days              voting days (default: $VOTE_DAYS)
   -q quote             quote symbols     
   -p price             list/proposal price

ACTION:
   proposal             list proposal
   list                 do real list
   balance              check Harmony balance on Binance Chain (default action)
   send                 send individual transactions
   multi-send           send multiple transactions using supported json format

EOT
   exit
}

# calculate the vote_seconds, expire_epoch, readable_expire_time
function _calculate_expire
{
# vote period in seconds
   VOTE_SECONDS=$(( $VOTE_DAYS * 86400 ))

# expire day is vote days + 1
   EXPIRE_DAYS=$(( $VOTE_DAYS + 1 ))

# use dadd to calculate the real expire date
   EXPIRE_DATE=$(dadd $(date +%Y-%m-%d) +${EXPIRE_DAYS}d)

# calculate the unix epoch time of the expire date, using UTC 00:00:00 as the time
   EXPIRE_EPOCH=$(date -j -f "%Y-%m-%d %H:%M:%S" "$EXPIRE_DATE 00:00:00" +%s)

# readable date/time of the expire date
   EXPIRE_READABLE=$(date -r $EXPIRE_EPOCH)
}

function check_balance
{
   echo "checking current balance of account: $ACCOUNT"
   $BNBCLI account $ACCOUNT --chain-id $CHAIN --node=$NODE --indent
}

function do_list
{
   echo upcoming ...
}

function do_proposal
{
   _calculate_expire

   cat<<EOT

================= ================= ================= ================= 
                            LISTING PROPOSAL
================= ================= ================= ================= 

LIST PAIR:    $SYMBOL/$QUOTE
https://explorer.binance.org/asset/$SYMBOL
https://explorer.binance.org/asset/$QUOTE

LIST PRICE:   $PRICE
VOTE DAYS:    $VOTE_DAYS
LIST EXPIRE:  $EXPIRE_READABLE
LIST DEPOSIT: $DEPOSIT_BNB BNB

EOT

   read -p "DO IT (y/n)? " yn

   if [[ "$yn" == "y" || "$yn" == "Y" ]]; then
      $BNBCLI gov submit-list-proposal --from $KEY --deposit $DEPOSIT_BNB_UNIT:BNB --base-asset-symbol $SYMBOL --quote-asset-symbol $QUOTE --init-price $PRICE --title "list proposal $SYMBOL/$QUOTE" --description "list proposal $SYMBOL/$QUOTE" --expire-time $EXPIRE --voting-period $VOTE --chain-id=$CHAIN --trust-node --node $NODE --json
   fi
}

function make_transaction
{
   DRY_RUN=--dry-run
   read -p "Is this a dryrun (y/n)? " yn
   if [[ "$yn" != "y" && "$yn" != "Y" ]]; then
      DRY_RUN=
   fi

   loop=true
   while [ "$loop" = "true" ]; do
      read -p "Enter receiver: " receiver
      read -p "Enter amount: " amount
      scaled_amt=$(echo "scale=8; $amount / 100000000" | bc)
      echo "Sending $scaled_amt $SYMBOL"s" to $receiver."
      read -p "Confirm (y/n)? " yn
      
      if [[ "$yn" == "y" || "$yn" == "Y" ]]; then
         read -p "Enter memo: " memo
         $BNBCLI send --from $KEY --to $receiver --amount $amount:$SYMBOL --memo="$memo" --chain-id $CHAIN --trust-node --node $NODE --json $DRY_RUN
      else
         echo "Canceling."
         exit
      fi

      read -p "Send another transaction (y/n)? " yn
      if [[ "$yn" != "y" && "$yn" != "Y" ]]; then
         loop=false
      fi
   done
}

function make_transactions
{
   read -p "What file would you like to use? " file
   if [[ ! -f $file ]]; then
      echo "File \"$file\" not found."
      exit
   fi

   DRY_RUN=--dry-run
   read -p "Is this a dryrun (y/n)? " yn
   if [[ "$yn" != "y" && "$yn" != "Y" ]]; then
      DRY_RUN=
   fi

   echo -e "Printing transaction file \"$file\" contents:\n$(cat $file)"
   read -p "Use file (y/n)? " yn

   if [[ "$yn" == "y" || "$yn" == "Y" ]]; then
      read -p "Enter memo: " memo
      $BNBCLI token multi-send --from $KEY --transfers-file $file --memo="$memo" --chain-id $CHAIN --trust-node --node $NODE --json $DRY_RUN
   else
      echo "Canceling."
      exit
   fi
}

unset VOTE_DAYS QUOTE PRICE
while getopts "hd:q:p:" opt; do
   case $opt in
      h) usage ;;
      d) VOTE_DAYS=$OPTARG ;;
      q) QUOTE=$OPTARG ;;
      p) PRICE=$OPTARG ;;
      *) usage ;;
   esac
done

shift $(( $OPTIND - 1 ))

ACTION=${1:-balance}

case $ACTION in
   list) do_list ;;
   proposal) do_proposal ;;
   balance) check_balance ;;
   send) make_transaction ;;
   multi-send) make_transactions;;
   *) usage ;;
esac
