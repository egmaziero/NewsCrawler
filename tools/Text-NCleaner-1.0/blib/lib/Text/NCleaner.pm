# -*-cperl-*-
package Text::NCleaner;

use warnings;
use strict;

=head1 NAME

Text::NCleaner - A simple n-gram approach to boilerplate removal

=head1 VERSION

Version 1.0

=cut

our $VERSION = '1.0';

use Carp;
use Data::Dumper;
use Text::NCleaner::NGram;
use Text::NCleaner::Segmenter;

=head1 SYNOPSIS

The B<ncleaner> is a simple approach to boilerplate removal from Web pages
using character-level n-gram models trained on manually cleaned data.  This
module provides a programmer API, while end-users will find it easier to 
work with the command-line front-ends B<ncleaner> and B<train-ncleaner>.

    use Text::NCleaner;

B<TODO: add short usage example here>

=head1 METHODS

=over 4

=item I<$untrained_cleaner> = B<new> Text::NCleaner;

Initialise B<ncleaner> model for training on manually annotated data.  Returns
object of class B<Text::NCleaner>.

=item I<$cleaner> = B<new> Text::NCleaner I<$filename>;

Load B<ncleaner> model from file I<$filename> (which must be a
B<Text::NCleaner> object serialised with the B<save> method),
returning an object of class B<Text::NCleaner>.

=cut

sub new ( $;$ ) {
  croak "Usage: \$cleaner = new Text::NCleaner [ \$filename ];"
    unless @_ == 1 or @_ == 2;
  my $class = shift;
  my $filename = shift;

  if (not $filename) {
    my $self = bless {}, $class;
    $self->{DEBUG} = 0;
    $self->{BIAS} = 0;		# bias (in bits) for cross-entropy of clean model (positive = lower recall, negative = higher recall)
    $self->{CLEAN} = undef;       # n-gram models for clean and dirty text (need to be trained first)
    $self->{DIRTY} = undef;
    return $self;
  }
  else {
    my $self = do $filename;
    croak "Format error in ncleaner model file '$filename': $@" if $@;
    croak "I/O error while loading ncleaner model from file '$filename': $!" unless defined $self;
    croak "File '$filename' is not an ncleaner model."
      unless ref($self) and ref($self) eq "Text::NCleaner";
    my $clean = $self->{CLEAN};
    croak "Parameters for clean text not found in ncleaner model '$filename'."
      unless $clean and ref($clean) and ref($clean) eq "Text::NCleaner::NGram";
    my $dirty = $self->{DIRTY};
    croak "Parameters for dirty text not found in ncleaner model '$filename'."
      unless $dirty and ref($dirty) and ref($dirty) eq "Text::NCleaner::NGram";
    return $self;
  }
}

=item I<$model>->B<train>(I<$clean_text>, I<$dirty_text>, I<$n> [, I<$mode>, I<$q>]);

=item I<$model>->B<diff_train>(I<$clean_text>, I<$raw_text>, I<$n> [, I<$mode>, I<$q>]);

Train B<ncleaner> model either on separate samples of clean and dirty text
(B<train>), or on raw and cleaned versions of the same text (B<diff_train>,
for "differential training").

The remaining parameters specify the order I<$n> of the n-gram models, the
normalisation mode I<$mode> and the interpolation factor I<$q>.  The latter two
are optional and assume default values if they are not specified.

The interpolation factor I<$q> can be changed after training and is described
under B<set_q> below.  For I<$mode>, the following values can be selected with
increasingly heavy normalisation. The default mode is 1.

    0 = minimal normalisation (only whitespace and control characters)
    1 = map all high-bit characters (outside ASCII range) to "~"
    2 = map ASCII letters to "a" for vowels and "t" for consonants, digits to "0"
    3 = non-lexical model, maps all ASCII letters to "a" and all digits to "0"

=cut

sub train ($$$$;$$) {
  croak "Usage: \$cleaner->train(\$clean_text, \$dirty_text, \$n [, \$mode, \$q]);"
    unless @_ >= 4 and @_ <= 6;
  my $self = shift;
  $self->_train(0, @_);
}

sub diff_train ($$$$;$$) {
  croak "Usage: \$cleaner->diff_train(\$clean_text, \$raw_text, \$n [, \$mode, \$q]);"
    unless @_ >= 4 and @_ <= 6;
  my $self = shift;
  $self->_train(1, @_);
}

=begin comment

Internal method used both for standard and for differential training.

=end comment

=cut

sub _train ($$$$;$$) {
  my ($self, $differential, $clean_text, $dirty_or_raw_text, $n, $mode, $q) = @_;
  my $debug = $self->{DEBUG};
  
  if ($debug > 0) {
    my $clean_l = length($clean_text);
    my $dirty_l = length($dirty_or_raw_text);
    $dirty_l -= $clean_l 
      if $differential;
    printf " - training on %.1fk (dirty) vs. %.1fk (clean) characters\n", $dirty_l / 1000, $clean_l / 1000;
  }

  my $clean = new Text::NCleaner::NGram $n;
  $clean->normalize($mode) if defined $mode;
  $clean->set_q($q) if defined $q;
  $clean->debug($self->{DEBUG});
  $clean->train($clean_text);

  if ($debug > 0) {
    my $ce = $clean->cross_entropy($clean_text);
    printf " - 'clean' n-gram model trained, cross-entropy is %.2f bits\n", $ce;
  }

  my $dirty = new Text::NCleaner::NGram $n;
  $dirty->normalize($mode) if defined $mode;
  $dirty->set_q($q) if defined $q;
  $dirty->debug($self->{DEBUG});
  if ($differential) {
    $dirty->train($dirty_or_raw_text, $clean_text);
  }
  else {
    $dirty->train($dirty_or_raw_text);
  }

  if ($debug > 0) {
    if ($differential) {
      print " - 'dirty' n-gram model trained (cannot calculate cross-entropy)\n";
    }
    else {
      my $ce = $dirty->cross_entropy($dirty_or_raw_text);
      printf " - 'dirty' n-gram model trained, cross-entropy is %.2f bits\n", $ce;
    }
  }

  $self->{CLEAN} = $clean;
  $self->{DIRTY} = $dirty;
}

=item I<$cleaner>->B<debug>(I<$level>);

Enable / disable debugging messages.  Debugging level 1 performs additional
consistency checks and prints some diagnostic messages.  Debugging level 2
prints detailed information.

=item I<$cleaner>->B<set_q>(I<$q>);

Set interpolation factor I<$q> of the n-gram models, which must be in the range
I<(0,1)>.  Values close to 1 correspond to strong smoothing (all history sizes
have equal weight) while values very close to 0 disable smoothing.

=item I<$cleaner>->B<set_n>(I<$n>);

Set order of n-gram model to use, corresponding to a history size of I<$n>-1 characters.
I<$n> may not be larger than the order used in training.

=item I<$cleaner>->B<set_bias>(I<$b>);

Apply bias of I<$b> bits to n-gram model for clean text. A positive value
increases precision by sacrificing recall, whereas a negative value increases
recall with lower precision.  Absolute values larger than 1 bit are rarely
useful.

=cut

sub debug ( $$ ) {
  croak "Usage: \$cleaner->debug(\$level);"
    unless @_ == 2;
  my $self = shift;
  my $status = shift;
  $self->{DEBUG} = $status;
}

sub set_q ( $$ ) {
  croak "Usage: \$cleaner->set_q(\$q)l"
    unless @_ == 2;
  my $self = shift;
  my $q = shift;
  croak "q-factor for n-gram models must be in range (0,1), q=$q is not allowed."
    unless 0 < $q and $q < 1;
  croak "q-factor cannot be set before models have been trained."
    unless $self->{CLEAN} and $self->{DIRTY};
  $self->{CLEAN}->set_q($q);
  $self->{DIRTY}->set_q($q);
}

sub set_n ( $$ ) {
  croak "Usage: \$cleaner->set_n(\$n);"
    unless @_ == 2;
  my $self = shift;
  my $n = int(shift);
  croak "q-factor cannot be set before models have been trained."
    unless $self->{CLEAN} and $self->{DIRTY};
  my $max_n = $self->{CLEAN}->{N}; # should be same N for both models
  croak "Invalid n-gram size n=$n (must be in range 1 .. $max_n)."
    unless 1 <= $n and $n <= $max_n;
  $self->{CLEAN}->set_n($n);
  $self->{DIRTY}->set_n($n);
}

sub set_bias ( $$ ) {
  croak "Usage: \$cleaner->set_bias(\$bits);"
    unless @_ == 2;
  my $self = shift;
  my $bits = shift;
  $self->{BIAS} = $bits;
}

=item I<$cleaner>->B<save>(I<$filename>);

Save trained B<ncleaner> model to portable disk file. The serialised file is
Perl code (generated by B<Data::Dumper>) which is later simply executed to
recreate the B<Text::NCleaner> object.  This approach allows the standard
parameter files to be included in the distribution as Perl modules.

=cut

sub save ( $$ ) {
  croak "Usage: \$cleaner->save(\$filename);"
    unless @_ == 2;
  my $self = shift;
  my $filename = shift;
  croak "This ncleaner model hasn't been trained yet, no point in saving to file '$filename'."
    unless $self->{CLEAN} and $self->{DIRTY};
  $self->debug(0);     # don't save model with debugging activated by default!
  my $serializer = new Data::Dumper [$self], ["NCLEANER_MODEL"];
  $serializer->Indent(1);
  my $fh = new FileHandle "> $filename"
    or croak "Can't write file '$filename': $!";
  print $fh $serializer->Dump
    or croak "I/O error while saving ncleaner model to file '$filename': $!";
   $fh->close
     or croak "I/O error while saving ncleaner model to file '$filename': $!";
}

=item if (I<$cleaner>->B<check>(I<$text>)) { ... }

=item (I<$is_clean>, I<$diff_bits>) = I<$cleaner>->B<check>(I<$text>);

Evaluates paragraph of text against the trained n-gram models.  In scalar
context, returns B<True> if the text is considered clean, B<False> otherwise.
In list context, returns both the decision and the difference in cross-entropy
(taking the user-specified bias value into account).  A positive difference
indicates that the text is more likely to be clean.

=cut

sub check ($$) {
  croak "Usage: \cleaner->check(\$text);"
    unless @_ == 2;
  my $self = shift;
  my $text = shift;

  croak "The ncleaner model has to be trained before it can be used!"
    unless $self->{CLEAN} and $self->{DIRTY};

  my $ce_dirty = $self->{DIRTY}->cross_entropy($text);
  my $ce_clean = $self->{CLEAN}->cross_entropy($text);

  my $adjusted_diff = $ce_dirty - ($ce_clean + $self->{BIAS});
  my $accept = ($adjusted_diff >= 0) ? 1 : 0;

  return (wantarray) ? ($accept, $adjusted_diff) : $accept;
}

=item I<@paragraphs> = I<$cleaner>->B<process>(I<$filename>);

Clean HTML or text file I<$filename> using trained ncleaner model, returning a
list of clean text segments marked as C<< <h> >> (header), C<< <l> >> (list
item) or C<< <p> >> (normal text paragraph).  See L<Text::NCleaner::Segmenter>
for details on the HTML-to-text conversion, the segmentation procedure, and
the autodetection of HTML files (extensions C<.html>, C<.xhtml> and C<.htm>).

=cut

sub process ($$) {
  croak "Usage: \$cleaner->process(\$filename);"
    unless @_ == 2;
  my $self = shift;
  my $filename = shift;

  my $text = new Text::NCleaner::Segmenter $filename;
  return grep {
    $self->check($_)
  } $text->get_segments;
}

=back

=head1 AUTHOR

Stefan Evert, C<< <stefan.evert@uos.de> >>

=head1 COPYRIGHT & LICENSE

Copyright 2008 Stefan Evert, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Text::NCleaner
