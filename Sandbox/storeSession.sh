osascript -e'set text item delimiters to linefeed' -e'tell app "google chrome" to url of tabs of window 1 as text' > session.json

echo 'Session stored'
