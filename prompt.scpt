on run argv
tell application "Terminal"
      set input to display dialog "" & item 1 of argv & ":" default answer ""
      if button returned of input is equal to "OK" then
          try
              return (text returned of input)
          end try
      end if
end tell
end run