property lastTrackID : ""
property lastTrackFinished : false

on idle
	tell application "Music"
		if player state is playing then
			set currentTrack to current track
			set currentTrackID to persistent ID of currentTrack
			set totalDuration to duration of currentTrack
			set currentPos to player position
			
			if lastTrackID is "" then
				set lastTrackID to currentTrackID
				return 2
			end if
			
			if (totalDuration - currentPos) ≤ 3 then
				set lastTrackFinished to true
			end if
			
			if currentTrackID is not lastTrackID then
				if lastTrackFinished is true then
					try
						set finishedTrack to (some track of library playlist 1 whose persistent ID is lastTrackID)
						
						-- Only prompt if it has 0 stars
						if rating of finishedTrack is 0 then
							set trackName to name of finishedTrack
							set artistName to artist of finishedTrack
							
							-- Get the primary screen size using a more robust method
							set screenWidth to word 1 of (do shell script "system_profiler SPDisplaysDataType | awk '/Resolution/ {print $2; exit}'") as integer
							set screenHeight to word 1 of (do shell script "system_profiler SPDisplaysDataType | awk '/Resolution/ {print $4; exit}'") as integer
							
							-- Calculate Coordinates
							set preferredX to (screenWidth - 470)
							set preferredY to (screenHeight - 250)
							
							activate
							
							-- TRIGGER THE MOVE: We repeat the check for 1 second to ensure we catch the window
							do shell script "osascript -e 'repeat 20 times
								tell application \"System Events\"
									if exists (window 1 of process \"Music\" whose title is \"Rate Finished Song\") then
										set position of window 1 of process \"Music\" to {" & preferredX & ", " & preferredY & "}
										exit repeat
									end if
								end tell
								delay 0.05
							end repeat' &> /dev/null &"
							
							set ratingChoices to {"0 Stars", "1 Star", "2 Stars", "3 Stars", "4 Stars", "5 Stars"}
							set userChoice to (choose from list ratingChoices with title "Rate Finished Song" with prompt "You finished '" & trackName & "'. Rate it:" default items {"3 Stars"})
							
							if userChoice is not false then
								set ratingValue to (first character of (item 1 of userChoice)) as integer
								set rating of finishedTrack to (ratingValue * 20)
							end if
						end if
					end try
				end if
				
				set lastTrackID to currentTrackID
				set lastTrackFinished to false
			end if
		end if
	end tell
	return 2
end idle
