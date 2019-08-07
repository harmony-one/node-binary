#!/bin/bash

# the expire date for the proposal, you need at least 1 week from now on
# default is 7 days
VOTE_DAYS=${1:-7}
QUOTE=BTCB-1DE

# proposed listing price
PRICE=111

export BNBCLI=./bnbcli
# ../../harmony/bc.sh balance
../../harmony/bc.sh -d $VOTE_DAYS -q $QUOTE -p $PRICE proposal

unset BNBCLI
