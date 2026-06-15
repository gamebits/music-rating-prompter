property lastTrackID : ""
property lastTrackFinished : false

on idle
	tell application "Music"
		if player state is playing then
			my updateWhilePlaying()
		else if lastTrackFinished is true and lastTrackID is not "" then
			my promptForFinishedTrack(lastTrackID)
			set lastTrackFinished to false
		end if
	end tell
	return 2
end idle

on updateWhilePlaying()
	tell application "Music"
		set currentTrackID to persistent ID of current track
		set totalDuration to duration of current track
		set currentPos to player position
		
		if lastTrackID is "" then
			set lastTrackID to currentTrackID
			return
		end if
		
		if currentTrackID is lastTrackID then
			if (totalDuration - currentPos) ≤ 3 then
				set lastTrackFinished to true
			else
				set lastTrackFinished to false
			end if
		else
			if lastTrackFinished is true then
				my promptForFinishedTrack(lastTrackID)
			end if
			set lastTrackID to currentTrackID
			if (totalDuration - currentPos) ≤ 3 then
				set lastTrackFinished to true
			else
				set lastTrackFinished to false
			end if
		end if
	end tell
end updateWhilePlaying

on promptForFinishedTrack(trackID)
	try
		set finishedTrack to my findTrackByPersistentID(trackID)
		
		if rating of finishedTrack is 0 then
			set trackName to my sanitizeForDisplay(name of finishedTrack, 80)
			set artistName to my sanitizeForDisplay(artist of finishedTrack, 60)
			
			if trackName is "" then set trackName to "Unknown Track"
			if artistName is "" then set artistName to "Unknown Artist"
			
			set promptText to "Track: " & trackName & return & "Artist: " & artistName & return & return & "Choose a rating:"
			
			set ratingChoices to {"0 Stars", "1 Star", "2 Stars", "3 Stars", "4 Stars", "5 Stars"}
			set userChoice to choose from list ratingChoices with title "Rate Finished Song" with prompt promptText default items {"3 Stars"}
			
			if userChoice is not false then
				set ratingValue to (first character of (item 1 of userChoice)) as integer
				set rating of finishedTrack to (ratingValue * 20)
			end if
		end if
	on error errMsg number errNum
		log "Music Rating Prompter: " & errMsg & " (" & errNum & ")"
	end try
end promptForFinishedTrack

on findTrackByPersistentID(trackID)
	tell application "Music"
		repeat with libPlaylist in library playlists
			try
				return (first track of libPlaylist whose persistent ID is trackID)
			end try
		end repeat
	end tell
	error "Track not found in library: " & trackID
end findTrackByPersistentID

on sanitizeForDisplay(theText, maxLength)
	if theText is missing value then return ""
	
	set cleanText to theText as text
	
	set AppleScript's text item delimiters to {return, linefeed}
	set textParts to text items of cleanText
	set AppleScript's text item delimiters to " "
	set cleanText to textParts as text
	set AppleScript's text item delimiters to ""
	
	if (count of characters of cleanText) > maxLength then
		set cleanText to (characters 1 thru maxLength of cleanText as text) & "…"
	end if
	
	return cleanText
end sanitizeForDisplay
