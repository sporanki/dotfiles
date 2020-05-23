-- ResetTrackAutoRating - V1.0 - © Steve MacGuire - 2019-11-29
tell application "Music"
  if selection is not {} then
    set mySelection to selection
    repeat with aTrack in mySelection
      if rating of aTrack is 1 then set rating of aTrack to 0
    end repeat
  end if
end tell