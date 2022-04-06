# stata_sendtoslack
code written by others that I use and others might find useful

from the original readme.do file, written by Jared:

/*
Jared Wright
jaredwright217@gmail.com
16 September 2021
sendtoslack is a program that allows you to send notifications to your phone via slack
I use it to notify me when a long do file has finished running or breaks as well as to notify me in the middle of do files.
To receive notifications on your phone, you will need to have slack installed on your phone. You will also need a private url. 
Feel free to email with any questions
*/

* For more information on creating a url, run the following commands:
ssc install sendtoslack
help sendtoslack

* This is an example of how to use sendtoslack in a do file
capture program drop sendtoslack sts_Send sts_Saveurl
run "V:\FHSS-JoePriceResearch\RA_work_folders\master\sendtoslack\sendtoslack.ado"

sleep 3000
sendtoslack, url(jared) message("Someone ran the readme.do file in the sendtoslack folder")

* After creating your custom url, you can add a custom name to the sendtoslack.ado file. You can add a custom name in at around line 50 in this ado file
doedit "V:\FHSS-JoePriceResearch\RA_work_folders\master\sendtoslack\sendtoslack.ado"

* After you've added a custom name, you have to redefine the sendtoslack program, or the sendtoslack command won't recognize your custom name. Redefine the program by running the following lines. To enable notifications within a do file, just add the following two lines at the top of the do file.
capture program drop sendtoslack sts_Send sts_Saveurl
run "V:\FHSS-JoePriceResearch\RA_work_folders\master\sendtoslack\sendtoslack.ado"

* Now you can send yourself notifications while a do file is running.

* To receive a notification when the do file finishes or breaks, use the following file. Just change the macro sendtoslack_url to your custom name and the macro file_to_run the the directory of the file for which you want to receive notifications. Then instead of running your do file, run the following file.
doedit "V:\FHSS-JoePriceResearch\RA_work_folders\master\sendtoslack\run_code_file.do"
