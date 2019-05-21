# README

`issue.sh` and `propose.sh` scripts in this folder will help you with commands for issuing tokens on Binance Chain and listing trading pairs on Binance Dex.

## Run Script

1. First you have to copy the binaries： `bnbcli`(for mainnet) and `tbnbcli`(for testnet) under this directory.

Then you can execute the specific script you want.

*  `issue.sh` will instruct you to issue token on `testnet` or `mainnet`.
*  `propose.sh` will instruct you to create a listing proposal on `testnet` or `mainnet`.

2. Run `issue.sh`

* On Linux:
```
bash issue.sh
```
* On Mac:
```
bash issue.sh
```

3. Run `propose.sh`

* On Linux:
```
bash propose.sh
```
* On Mac:
```
bash propose.sh
```


## Run Script Offline

1. Please use the script to get the command you want to execute from above. For example on testnet: 
```
./tbnbcli token issue -s TEST --token-name "TEST" --total-supply 10000000000000000 --from <address>  --chain-id Binance-Chain-Nile --node=http://data-seed-pre-0-s3.binance.org:80 
```

2.  Download binaries from branch `add-offline`

3. Generate your unsigned transction
```
./tbnbcli token issue -s TEST --token-name "TEST" --total-supply 10000000000000000 --from <put-your-offline-address>  --chain-id Binance-Chain-Nile --node=http://data-seed-pre-0-s3.binance.org:80 --generate-only --offline >> unsigned.json
```
Then, you can see that the `signature` of `unsigned.json` is  longer empty. 

4. Sign Transaction
You can view the `unsigned.json` to verify that all the info about this transaction is correct.
You need to get the `account-number` and `sequence` about your address here: https://docs.binance.org/api-reference/dex-api/paths.html#apiv1accountaddress 
```
./tbnbcli sign unsigned.json --account-number <address-account-number> --sequence <address-sequence> --chain-id Binance-Chain-Nile --offline  --name offline >> signed.json
```
> You need to type in your password in this step

Then, you can see that the `signature` of `signed.json` is no longer empty. 

5. Broadcast Your Transaction
Please then copy your  `signed.json` to a different server and broadcast this transaction.
```
./tbnbcli broadcast signed.json --node=http://data-seed-pre-0-s3.binance.org:80
```

You can find the list of node here: https://docs.binance.org/api-reference/cli.html#where-to-connect

If the broadast is successful, you will see the transaction hash in returned info. Please go and verify it in Explorer.
