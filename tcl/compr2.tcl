set str1 "apple"
set str2 "banana"

if {$str1 lt $str2} {
    puts "$str1 comes before $str2 in dictionary order"
} else {
    puts "$str1 does not come before $str2"
}
