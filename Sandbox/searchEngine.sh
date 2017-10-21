echo "Searching for : $@"
for term in $@ ; do
    echo "$term"
    search="$search%20$term"
    app="--app=http://www.google.com/search?q=$search"
done
    open "http://www.google.com/search?q=$search"
