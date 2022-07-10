#!/usr/bin/perl

use File::Basename;

# for localfiles.lst:
# find . -type f -printf "%P ;; %s ;; " -exec md5sum "{}" \;

open FILE, "localfiles.lst" or die $!;
while (<FILE>) {
    chomp;
    @f = split(" ;; ");

    $bname = basename($f[0]);
    $size = $f[1];
    ($cksum, $lixo) = split(' ', $f[2]);

    if($size>0){
        $D{$size,$cksum} = 1;
        $FNAME{$size,$cksum} = $f[0];
    }

#       print "READING: $f[0], $bname, $size, $cksum\n";
}

#print "Starting...\n";

while(<>){
    chomp;
    @f = split(" ;; ");

    
    $bname = basename($f[0]);
    $size = $f[1];
    ($cksum, $lixo) = split(' ', $f[2]);


    if ($D{$size,$cksum} != 1){
        print "ERROR $f[0] ;; $size ;; $cksum $FNAME{$size, $cksum}";
    }else{
        print "CHECK $f[0] ;; $size ;; $cksum $FNAME{$size, $cksum}";
    }

    print "\n";
}
