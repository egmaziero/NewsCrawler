#!perl

use Test::More tests => 5;

BEGIN {
	use_ok( 'Text::NCleaner' );
	use_ok( 'Text::NCleaner::NGram' );
	use_ok( 'Text::NCleaner::Segmenter' );
}

diag( "NCleaner version $Text::NCleaner::VERSION, Perl $], $^X" );

require_ok( 'Text::NCleaner::Models::EnglishStandard' );
require_ok( 'Text::NCleaner::Models::EnglishNonlex' );

if ($Text::NCleaner::NGram::HAVE_NGRAMC) {
    diag( "using fast Inline::C implementation of n-gram models" );
}
