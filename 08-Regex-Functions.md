Regular Expessions (RegEx)

Find the phone number which is starting with 1 and next second digit will be between 2,3,4.

Metacharacters:

. (dot)--> any one character except newline. Same as [^\n]
\d, \D: Any one digit/non-digit character. Digits are [0-9] d will identify digits D non numbers
\w, \W: Any one word/non-word character. word chracters are [a-z A-Z,0-9] w: will identify words W: will identify non-words
\s, \S: Any one space/non-space chracter. FOR ASCII, whitespace chracters are [\n \r \t\f] s: will identify spaces, S: 

\d-[2-7]\d\d-\d\d\d-\d\d\d\d

Here in first character it will check NUMBER next '-' next numbers between 2 to 7

egrep -i -w 'rebel1|superstar1'
grep -iE -w 'rebel1|superstar1'

egrep will search multiple things at a time.

egrep -i ^reb

will give us the results of the words starting with reb if we give '^'

star$ -> this will give us results of words ending with star

^ --> words beginning with.
$ --> words ending with.
=~ --> we are using regular expression this means