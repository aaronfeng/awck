#!/usr/bin/awk -f

function usage() {
  print "usage: ack.awk search_pattern [files...]|*" > "/dev/stderr"
  exit 1
}

BEGIN {
  if (ARGC < 3) usage()
  pattern = ARGV[1]
  ARGV[1] = ""
}

{
  if (current_file == "" || current_file != FILENAME) {
    current_file = FILENAME;
    NR=1;
  }
}

match($0, pattern) {
  matched_text = substr($0, RSTART, RLENGTH)
  gsub(matched_text, "\033[1;31m" matched_text "\033[0m", $0);
  printf "%s", FILENAME ":"  NR ":  " $0 "\n";
}
#$0 ~ pattern {
#  #print "0 " $0;
#  #print "1 " $1;
#  #print "pattern " pattern;
#  # when pattern is regex, the gsub doesn't work correctly
#  gsub(pattern, "\033[1;31m" pattern "\033[0m", $0);
#  printf "%s", FILENAME ":"  NR ":  " $0 "\n";
#}
