##
jq is useful to filter out the json files

jq ".results[].name" #this is how you use to filter the list results which containts object will have key's name 

# curl -sL https://pokeapi.co/api/v2/pokemon | jq ".results[].name"
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

curl -sL https://pokeapi.co/api/v2/pokemon | jq ".results[].name" -r
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

# curl -sL https://pokeapi.co/api/v2/pokemon?limit=1400 | jq ".results[].name" -r | wc -l
1350
root@ip-172-31-12-16:~/DevSecOps-Bash#

![alt text](image.png)


#USE Export command to assign any environment variables

export AWS_ACCESS_KEY="sdfjldsjfdlsfjoasld"
export AWS_SECRET_KEY= "fdlajfdslfjldsfjlasd"

env variables willbe store in ~/.bashrc file


sudo apt-get install direnv
#direnv

nano .bashrc and the following line
eval "$(direnv hook bash)"

source ~/.bashrc

you can define your env variables as required for your project
1) create a project: mkdir project-1
2) go to that project: cd project-1
3) create a file for env variables: .envrc
4) inside that file: nano .envrc
5) write your environement variables.
export AWS_REGION = ap-south-1
export AWS_ACCESS_KEY = "kjdflsdjfoa"
export AWS_SECRET_ACCESS_KEY = "LJDLFJOSADFODSNFAFOA"
by this way you can you the file as you want

once after configuring it you have to allow them
direnv allow project1/.envrc

for overall env variables set this at .bashrc
for project level variables set this at .evnrc