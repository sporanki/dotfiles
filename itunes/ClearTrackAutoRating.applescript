-- ClearTrackAutoRating - V1.0 - © Steve MacGuire - 2019-11-29
tell application "Music"
  if selection is not {} then
    set mySelection to selection
    repeat with aTrack in mySelection
      if rating kind of aTrack is computed then set rating of aTrack to 1
    end repeat
  end if
end tell