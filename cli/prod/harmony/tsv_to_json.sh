#!/bin/bash

printf "[\n" > rewards.json

firsttime=true

while IFS=$'\t' read -r -a line; do
    if [[ $firsttime = true ]]; then
        firsttime=false
    else
        printf "   },\n" >> rewards.json
    fi
    printf "   {\n" >> rewards.json
    printf "      \"to\":\"${line[0]}\",\n" >> rewards.json
    printf "      \"amount\":\"${line[1]}:ONE-5F9\"\n" >> rewards.json
done < $1

printf "   }\n" >> rewards.json
printf "]" >> rewards.json
