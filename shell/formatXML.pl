#!/usr/bin/perl

while(<>) 
{
	$xml = $_;
	$indent = 0;
	$xml =~ s/(?<=>)\s+(?=<)//g;
	$xml =~ s(<(/?)([^>]+)(/?)>\s*(?=(</?))?)($indent+=$3?0:$1?-1:1;"<$1$2$3>".($1&&($4 eq"</")?"\n".("  "x($indent-1)):$4?"\n".("  "x$indent):""))ge;

	print $xml."\n";
}
