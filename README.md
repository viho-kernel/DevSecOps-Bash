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

sh hello.sh vihari mumbai ganesh
    $0        $1   $2       $3
$0 == Will alway be script itself
$1 == first argument
$2 == second argument
$3 == third argument
$@ == will print all arguments except the script file 
$* == 

yum update -y
yum install cowsay -y


==================================================================

Day-2

to see Disk Utiliation 'df -h'
'|' (pipe = will run seperate two commands)
grep == granular regular expression
(grep will select a particularly select a thing from the output)
df -h | grep -i '/dev/root'

eg:
#df -h
root@ip-172-31-12-16:~/DevSecOps-Bash# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        14G  3.6G   10G  27% /
tmpfs           479M     0  479M   0% /dev/shm
tmpfs           192M  884K  191M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/xvda16     881M  155M  665M  19% /boot
/dev/xvda15     105M  6.2M   99M   6% /boot/efi
tmpfs            96M   12K   96M   1% /run/user/1000

eg:


root@ip-172-31-12-16:~/DevSecOps-Bash# df -h | grep /dev/root
/dev/root        14G  3.6G   10G  27% /
root@ip-172-31-12-16:~/DevSecOps-Bash#

root@ip-172-31-12-16:~/DevSecOps-Bash# free -m | grep -i mem
Mem:             957         378         274           0         488         579

free -m: Executes the free command and uses the -m flag to display values in megabytes (MB).

root@ip-172-31-12-16:~/DevSecOps-Bash# echo "Welcome-To-DevSecOps-Class" | cut -d "-" -f 1,2,3,4
Welcome-To-DevSecOps-Class
root@ip-172-31-12-16:~/DevSecOps-Bash#

f= field

# echo "Welcome,to,DevSecOps,Course" | cut -d "," -f 1,2,3
Welcome,to,DevSecOps

cut command will give the thing but -d will not work.

# echo "Welcome,to,DevSecOps,Course" | awk -F "," '{print $1,$2,$3,$4}'
Welcome to DevSecOps Course

here awk command will give the required output by eliminating the ','

awk is more effective than cut.

Variable Pesedence
10 - 5 * 4 + 7 / 2
'-' = subtraction
'*' = mulitiplication
'+' = addition
'/' = divide

presedence value
() >> * >> / >> % >> + >> - >> << >> >> >> < >> <= >> > >> >= >> == >> != >> & >> ^ >> | >> && >> || >> ?: >> = >> , 

Direct usage script
root@ip-172-31-12-16:~/DevSecOps-Bash# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        14G  3.6G   10G  27% /
tmpfs           479M     0  479M   0% /dev/shm
tmpfs           192M  884K  191M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/xvda16     881M  155M  665M  19% /boot
/dev/xvda15     105M  6.2M   99M   6% /boot/efi
tmpfs            96M   12K   96M   1% /run/user/1000

To get the used percentage.
# df -h | grep -i '/dev/root' | awk -F " " '{print $5}'

root@ip-172-31-12-16:~/DevSecOps-Bash# df -h | grep -i '/dev/root' | awk -F " " '{print $5}'
27%
root@ip-172-31-12-16:~/DevSecOps-Bash#

