#!/usr/bin/perl

if ($#ARGV < 0) {
    $UNIX_PATH = $ENV{PWD};
}elsif (! -e $ARGV[0]) {
    print "No such file or directory: $ARGV[0]\n";
    print "Usage:\n";
    print "     $0 <unix_path>\n";
    my $pwd = readpipe "pwd";
    print "E.g. $0 $pwd\n";
    exit;
}else {
    $UNIX_PATH = @ARGV[0];
}
@PATH = split /\//, $UNIX_PATH;
$length_unix = $#PATH;
for ($temp=1;$temp<=$length_unix;$temp++) {
  $print_line =  "\\".$PATH[$temp+1];
  if ($PATH[2] eq "PnR") {
     $print_line =~ s/RCARM3N/RCARM3~1/;
  }
  push (@line_print, $print_line);
}
@ARR_LINE = `df | grep '/vol/' -A2 | grep -v '/tool/EDA' | awk '{print \$NF}'`;
foreach $line (@ARR_LINE) {
   chomp $line;
   @UNIX = split /\s+/, $line;
   if (grep /^rvc-nas/, @UNIX) {
      @UNIX_LINE =split /\//, $UNIX[0];
      @WIN_NAS = split /\:/, $UNIX_LINE[0];
      if (grep  /$PATH[2]/, @UNIX_LINE) {
         print "UNIX:      $UNIX_PATH\n\n";
         print "WIND:      ";
         print "\\\\".$WIN_NAS[0];
         print @line_print;
         print "\n";
      }
   }
}
