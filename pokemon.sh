#!/bin/bash

ALL_POKEMONS=$(curl -sL https://pokeapi.co/api/v2/pokemon?limit=10000 | jq '.results[].name' -r)    
for pokemon in $ALL_POKEMONS;
do
  echo "Name of the Pokemon is: $pokemon"
done