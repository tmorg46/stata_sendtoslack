# stata_sendtoslack

send yourself a direct message on Slack when a Stata do file starts, fails, and/or finishes
code written by others as credited in each file

from the original readme.do file, written by Jared and modified for this repository:

/*
Jared Wright
jaredwright217@gmail.com
16 September 2021
sendtoslack is a program that allows you to send notifications to your phone via slack
I use it to notify me when a long do file has finished running or breaks as well as to notify me in the middle of do files.
To receive notifications on your phone, you will need to have slack installed on your phone. You will also need a private url. 
Feel free to email with any questions
*/

For more information on creating a url, run the following commands:
```
ssc install sendtoslack
help sendtoslack
```
This is an example of how to use sendtoslack in a do file
```
capture program drop sendtoslack sts_Send sts_Saveurl
run "the path to the .ado file"
sleep 3000
sendtoslack, url("your url") message("Someone ran the readme.do file in the sendtoslack folder")
```
After creating your custom url, you can add a custom name to the sendtoslack.ado file. You can add a custom name in at around line 50 in the .ado file

Now you can send yourself notifications while a do file is running.

To receive a notification when the do file finishes or breaks, use the sendtoslack file. Just change the macros. Then instead of running your do file, run that file.
