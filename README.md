##
jq is useful to filter out the json files

jq ".results[].name" #this is how you use to filter the list results which containts object will have key's name 

root@ip-172-31-12-16:~/DevSecOps-Bash# curl -sL https://pokeapi.co/api/v2/pokemon | jq ".results[].name"
"bulbasaur"
"ivysaur"
"venusaur"
"charmander"
"charmeleon"
"charizard"
"squirtle"
"wartortle"
"blastoise"
"caterpie"
"metapod"
"butterfree"
"weedle"
"kakuna"
"beedrill"
"pidgey"
"pidgeotto"
"pidgeot"
"rattata"
"raticate"



use -r to remove double quotes

root@ip-172-31-12-16:~/DevSecOps-Bash# curl -sL https://pokeapi.co/api/v2/pokemon | jq ".results[].name" -r
bulbasaur
ivysaur
venusaur
charmander
charmeleon
charizard
squirtle
wartortle
blastoise
caterpie
metapod
butterfree
weedle
kakuna
beedrill
pidgey
pidgeotto
pidgeot
rattata
raticate

wc -l #to count the number of lines

root@ip-172-31-12-16:~/DevSecOps-Bash# curl -sL https://pokeapi.co/api/v2/pokemon?limit=1400 | jq ".results[].name" -r | wc -l
1350
root@ip-172-31-12-16:~/DevSecOps-Bash#
