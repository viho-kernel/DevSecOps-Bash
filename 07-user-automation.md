#check if user exist
#create if user doesn't exit
#generate random password and assign it to an user
#expire password forcing user to reset it

* make sure user has Sudo permission.

commands to use
1) To create use (useradd -m nobel1)
2) cat /etc/passwd --> to check users in system
3) to check a user cat /etc/passwd | grep -i nobel1 --> this will only search for a user and give all matching patterns.
4) cat /etc/passwd | grep -i -w nobel1 (this will give us exact word)
4) cat /etc/passwd | grep -i -w nobel1 | cut -d ':' -f 1,2,3,4,5 (this will give us the user nobel1 in the field1,2,3,4,5 (i.e as you want.))
5)  cat /etc/passwd | grep -i -w nobel1 | awk -F ':' '{print $1}' with use of awk you can interchange the positions like you want $3, $2, $1 and $1, $3, $2
6) Taking username dynamically and passing it to $1
7) Get existing username using above methods in line {4,5,6}
8) compare both the existing user and the taken user compare both of them and check if user is already present or not
9) before anything chceck the parameters passing if there are no parameters passed then return null as no users passed.
10) adding user (useradd -m $USERNAME) add this user to /bin/bash path.
eg: sudo useradd -m $USERNAME --shell /bin/bash -d /home/$USERNAME
WITH This we are adding a user to the path /bin/bash and creating a path for that user
-m tell useradd to create a home directory for the new user.
--shell /bin/bash
this will set the user default login shell to bash
-d "/home/${USERNAME}"
Explicitly sets the home directory path for the user.
By default, useradd would also create /home/username, but here it’s specified to be sure.
11) Creating a random password for that user using a building function called $RANDOM
12) Use functions like fold -w1 to make a horizontal line to veritcal also shuf to shuffle them and take the first variable head
eg: echo '!@#$%^&*()_' | fold -w1
output:

!
@
#
$
%
^
&
*
(
)
_

root@ip-172-31-12-16:~/DevSecOps-Bash# echo '!@#$%^&*()_' | fold -w1 | shuf
^
(
_
%
!
#
*
$
)
&
@
root@ip-172-31-12-16:~/DevSecOps-Bash# echo '!@#$%^&*()_' | fold -w1 | shuf | head -1
#
root@ip-172-31-12-16:~/DevSecOps-Bash#

13) Create a random password and assign that password.
PASSWORD="India@${RANDOM}${SPEC}"
echo "${USERNAME}:${PASSWORD}" | sudo chpasswd
#sudo privileges are needed to change the password using command called chpasswd

14) now expire password for that specific user
passwd -e ${USERNAME}
15) send this notifications to your slack channel