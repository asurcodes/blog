for file in $(find public -name "*.html"); do
    [ -f "$file" ] || break
    echo "Optimizing $file" 
    ! $GOPATH/bin/transform $file > /tmp/optimized.txt
    [ -s /tmp/optimized.txt ] && cat /tmp/optimized.txt > $file || echo "Not a valid AMP page. Omitting..."
done