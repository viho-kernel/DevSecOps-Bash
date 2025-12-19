#!/bin/bash

for pokemon in $(curl -sL https://pokeapi.co/api/v2/pokemon?limit=10000 | jq '.results[].name' -r)
do
  echo "Name of the Pokemon is: $pokemon"
done