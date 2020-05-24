#!/usr/bin/perl

# "sdc" [label="%{id: :sdc, label: \"Node\", name: \"SDC\", type: \"IMP\"}"]
# "sdc_h1" [label="%{id: :sdc_h1, label: \"Host\", name: \"DDP-516\", user: \"360/67\"}"]

# $IMPC = "#87CEEB";
$IMPC = "#A6E1FC";
$TIPC = "#ADFAE7";

while (<>) {
  if (/\\\"Host\\\"/) {
    s/\[.*name: \\\"([^\"]+)\\\".*\]/\[label="$1"]/;
  }
  if (/\\\"Node\\\"/) {
    s/\[label=".*name: \\\"([^\"]+)\\\".*\]/\[color=black, fillcolor="$IMPC", label="$1"]/;
  }
  print;
}
