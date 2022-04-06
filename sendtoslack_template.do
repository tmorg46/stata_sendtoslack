/*
Written by:
jared wright
jaredwright217@gmail.com
This file runs another code file, and notifies you on slack when the code breaks or finishes running successfully

Tommy's note:
Modify this with your personal url in the sendtoslack_url global
You can create that by running these two commands and following the instructions

ssc install sendtoslack
help sendtoslack

*/

*change these lines to point to the file you want to be notified about
cd // the folder of the do-file you want to run
local file_to_run // the name of the do-file you want to run

*change this line to your path to the .ado file
local ado // "path\sendtoslack.ado"

*change this line to your custom name or url
local sendtoslack_url // "custom.url"


*** don't modify unless you want to add other error code messages ****************************************
capture program drop sendtoslack
capture program drop sts_Send
capture program drop sts_Saveurl
run `ado'
sendtoslack, url("`sendtoslack_url'") message("It's time to go! `file_to_run' is off to the races!")
capture noisily do "`file_to_run'"
local return_code = _rc
capture program drop sendtoslack
capture program drop sts_Send
capture program drop sts_Saveurl
run `ado'
if `return_code'==0 {
    sendtoslack, url("`sendtoslack_url'") message("Fantastic news!! `file_to_run' finished running successfully!")
}

if `return_code'==604 {
	sendtoslack, url("`sendtoslack_url'") message("Oops! `file_to_run' failed because you left a log file open!")
}

if `return_code'==198 {
	sendtoslack, url("`sendtoslack_url'") message("Oh no! `file_to_run' broke because of a syntax error in your code!")
}

if `return_code'==1 {
	sendtoslack, url("`sendtoslack_url'") message("Well, you already know that `file_to_run' didn't run: you clicked break!'")
}

if `return_code'==111 {
	sendtoslack, url("`sendtoslack_url'") message("Shucks! `file_to_run' couldn't finish because it couldn't find a variable that's supposed to be in the code!'")
}

if `return_code'==601 {
	sendtoslack, url("`sendtoslack_url'") message("Oh, rats! `file_to_run' couldn't find a file you told it to use, so it failed!")
}

if `return_code'==693 {
	sendtoslack, url("`sendtoslack_url'") message("Of course... `file_to_run' was running flawlessly, but the computer it was running on was too full for it to continue...")
}

if `return_code'!=0 & !=1 & !=111 & !=198 & !=601 & !=604 & !=693 {
    sendtoslack, url("`sendtoslack_url'") message("I have something horrible to tell you... `file_to_run' broke in a new, weird way... it gave you the error code `return_code'.")
}
