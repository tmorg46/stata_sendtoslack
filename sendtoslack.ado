* Command to send messages to slack
*! Version 1.3.4  22may2020
* Contact jesse.wursten@kuleuven.be for bug reports/inquiries.

* To add your url, copy and paste the code under the comment in line 50, and change the url and name.

program define sendtoslack
	version 8.0
	syntax, [Url(string) Message(string) method(string) saveurlas(string) col(integer 0)]
	
	* Save Url (default or named)
	if "`saveurlas'" != "" 	{
		sts_Saveurl, urltosave(`url') name(`saveurlas')
		if `"`message'"' == "" local message "Testing whether saveurlas worked correctly."
		di "We will now send a text message to the saved url."
		local url "`saveurlas'"
	}
	
	* Send message
	sts_Send, url(`url') message(`message') method(`method') col(`col')

end
	

program define sts_Send
	syntax, [url(string) message(string) method(string) col(integer 0)]
	** Parse col (mainly used for integration with other commands that use sendtoslack)
	if `col' == 0 	local preCol ""
	if `col' != 0 	local preCol "_col(`col')"
	
	** Parse url
	*** (saved) Name
	if "${sts_`url'}" != "" & "sts_`url'" != "sts_default" {
		di `preCol' as text "Sending message to url saved as `url': " as result "${sts_`url'}"
		local url "${sts_`url'}"
	}
	
	*** Empty
	**** Default specified
	if ("`url'" == "" | "`url'" == "default") & "$sts_default" != "" {
		di `preCol' as text "Sending message to " as result "default" as text " url: " as result "$sts_default"
		local url "${sts_default}"
	}
	
	*** Jared Wright's url
	if ("`url'" == "jared") {
	    local url "https://hooks.slack.com/services/T6XRDG38E/B02BCAKAXDW/hidden"
	}
	
	*** insert your url here
	if ("`url'" == "your custom name") {
	    local url "your custom url"
	}
	
	*** Default not specified
	if "`url'" == "" & "$sts_default" == "" {
		di as text "No url provided and no url saved. Sending test message to the stataMessage workspace."
		di as text "Accessible at: " as result "https://statamessage.slack.com/messages/C6WSHNXM1/"
		local url = "http" + "s://hooks" + ".slack.c" + "om/ser" + "vices/T6X" + "RDG38E/B" + "DRK490Q7/b4" + "FiICy1qG46NdC" + "y26K4DQnw"		// Chopped up in the hopes that Slack won't recognise it
	}
	
	** Fill in empty message
	if `"`message'"' == "" {
		local message "`c(hostname)': Stata has done something you wanted to know about!"
	}
	
	** Filter out apostrophes and quotes
	local message = subinstr(`"`message'"', `"""', "", .)
	local message = subinstr(`"`message'"', `"'"', "", .)
	
	** Curl
	if "`method'" == "curl" {
		! curl -X POST --data-urlencode "payload={'username': 'statamessage', 'text': '`message'', 'icon_emoji': ':bell:'}" `url'
	}

	** Powershell
	else {
		! powershell -Command "Invoke-WebRequest -Body(ConvertTo-Json -Compress -InputObject @{'username'='statamessage'; 'text'='`message''; 'icon_emoji' = ':bell:'}) -Method Post -Uri `url'"
	}
	
	di `preCol' as text "Message sent: " as result `"`message'"'
end

program define sts_Saveurl
	syntax, name(string) urltosave(string)

	* Determine whether profile.do exists
	cap findfile profile.do

	** If profile.do does not exist yet
	** Create profile.do (asking permission)
	if _rc == 601 {
		di "Profile.do does not exist yet."
		di "Do you want to allow this program to create one for you? y: yes, n: no" _newline "(enter below)" _request(_createPermission)
		
		if "`createPermission'" == "y" {
			di "Creating profile.do as `c(sysdir_oldplace)'profile.do"
			tempname createdProfileDo
			
			file open `createdProfileDo' using `"`c(sysdir_oldplace)'profile.do"', write
			file close `createdProfileDo'
		}
		
		if "`createPermission'" != "y" {
			di "User did not give permission to create profile.do, aborting program."
			exit
		}
	}

	* Write in global for url
	** Verify if global is already defined (if so, give warning)
	*** Find location of profile.do
	qui findfile profile.do
	local profileDofilePath "`r(fn)'"

	*** Open
	tempname profileDofile
	file open `profileDofile' using "`profileDofilePath'", read text
	file read `profileDofile' line

	*** Loop over profile.do until ...
	***		you reached the end
	***		found the global we want to define
	local keepGoing = 1
	while `keepGoing' == 1 {
		if strpos(`"`macval(line)'"', "sts_`name'") > 0 {
			di as error "Global was already defined in profile.do"
			di as result"The program will add the new definition at the bottom."
			di "You might want to open profile.do and remove the old entry."
			di "This is not required, but prevents clogging your profile.do."
			di "To do so, type: " as txt "doed `profileDofilePath'" _newline
			
			local keepGoing = 0
		}
		
		file read `profileDofile' line
		if r(eof) == 1 local keepGoing = 0
	}
	file close `profileDofile'

	** Write in the global
	file open `profileDofile' using "`profileDofilePath'", write text append
	file write `profileDofile' _newline `"global sts_`name' "`urltosave'""'
	file close `profileDofile'
	
	** Define it now too, as profile.do changes only take place once it has ran
	global sts_`name' "`urltosave'"

	* Report back to user
	di as result "Added a url entitled, (sts_)`name' to " as txt "`profileDofilePath'"
	if "`name'" == "default" di as result "On this PC, this url will be used if no url option was specified." _newline
	if "`name'" != "default" di as result "On this PC, you can now specify url(name) to use this link." _newline
end