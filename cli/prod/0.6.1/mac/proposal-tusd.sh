#!/bin/bash

# the expire date for the proposal, you need at least 1 week from now on
# default is 7 days
VOTE_DAYS=${1:-7}
QUOTE=TUSDB-888

# proposed listing price
PRICE=1313000

export BNBCLI=./bnbcli
# ../../harmony/bc.sh balance
../../harmony/bc.sh -d $VOTE_DAYS -q $QUOTE -p $PRICE proposal

unset BNBCLI
