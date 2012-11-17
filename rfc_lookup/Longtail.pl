#!/usr/bin/env perl

use strict;
use warnings;

use XML::SAX::ParserFactory;
use XML::Validator::Schema;

my $validator = XML::Validator::Schema->new(file => 'longtail.xsd');
my $parser = XML::SAX::ParserFactory->parser(Handler => $validator);

$parser->parse_uri('output.xml')
  or die "Longtail failed to validate: $@" if $@; 