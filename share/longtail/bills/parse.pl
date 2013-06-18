#!/usr/bin/env perl

use strict;
use warnings;

use File::Slurp;
use JSON;

my $file = $ARGV[0];

my $govtrack_ref = my $text_path = $file;

$text_path =~ s:^\./::;
$text_path =~ s:data\.json$:text-versions/enr/document.txt:;

my ($congress, $resolution) = $file =~ m:congress/(\d+)/bills/hconres/hconres(\d+)/:;

my $base = 'http://www.govtrack.us';

my $link = "$base/congress/bills/$congress/hconres$resolution";
my $full_text = "$base/$text_path";

my $text = read_file($file);
my $json = JSON->new->allow_nonref->decode($text);

print "<doc>\n";
print '<field name="l2_sec"><![CDATA['
    . $json->{official_title}
    . "]]></field>\n";
print '<field name="l3_sec"><![CDATA['
    . ($json->{actions}[scalar @{ $json->{actions} } - 1]{in_committee} ? $json->{actions}[scalar @{ $json->{actions} } - 1]{in_committee} : "")
    . "]]></field>\n";
print '<field name="l4_sec"><![CDATA['
    . (join ", ", @{ $json->{subjects} })
    . "]]></field>\n";
print '<field name="paragraph"><![CDATA['
    . $json->{summary}{text} . '<br>'
    . "]]></field>\n";
print '<field name="source"><![CDATA['
    . "$link"
    . "]]></field>\n";
print '<field name="title"><![CDATA['
    . "U.S. House Bill #" . $json->{number}
    . ($json->{short_title} ? $json->{short_title} : "")
    . "]]></field>\n";
