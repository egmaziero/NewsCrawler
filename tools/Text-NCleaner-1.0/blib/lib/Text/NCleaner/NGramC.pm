# -*-c-*-
package Text::NCleaner::NGramC;

use warnings;
use strict;

=head1 NAME

Text::NCleaner::NGramC - Fast Inline::C implementation of n-gram models

=cut

use Inline "C" => "DATA";

=head1 SYNOPSIS

This module provides a fast C implementation of time-critical loops for n-gram
models.  It has no user-visible methods and will automatically be called
internally by B<Text::NCleaner::NGram> if B<Inline::C> is available.


=head1 AUTHOR

Stefan Evert C<< <stefan.evert@uos.de> >>

=head1 COPYRIGHT & LICENSE

Copyright (C) 2008 by Stefan Evert, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Text::NCleaner::NGramC (Perl stub)

__DATA__
__C__
/**  conditional_probability() ... calculate smoothed conditional n-gram probability
 * ARGUMENTS
 *   ngram_hash_table_ref ... reference to data structure holding conditional n-gram probabilities (see NGram.pm)
 *   ngram      ... n-gram (string)
 *   len        ... length of n-gram (i.e. n); if 0, ngram has to be NUL-terminated and length is automatically calculated
 *   q          ... smoothing factor for geometric interpolation (0 < q < 1, larger values give stronger smoothing)
 *   return_log ... if TRUE, return log2 of conditional probability
 * VALUE
 *   double: conditional probability of specified n-gram (or its base-2 logarithm)
 */
double conditional_probability(SV *ngram_hash_table_ref, char *ngram, int len, double q, int return_log) {
  AV* ngram_hash_table;
  HV* ngram_hash;
  SV** ngram_hash_ref;
  SV** ngram_cp;
  double total_cp, norm, factor, cp;
  int i, n;

  if (! SvROK(ngram_hash_table_ref))
    croak("NGramC: Internal error (ngram_hash_table_ref is not a reference)");
  ngram_hash_table = (AV*) SvRV(ngram_hash_table_ref);
  if (q <= 0 || q >= 1) 
    croak("NGramC: Internal error (interpolation factor q = %f must be in range (0,1))", q);

  if (len <= 0) 
    n = strlen(ngram);
  else
    n = len;
  norm = (1 - pow(q, n)) / (1 - q);
  total_cp = 0;
  factor = 1 / norm;

  for (i = 0; i < n; i++) {
    ngram_hash_ref = av_fetch(ngram_hash_table, n - i, 0);
    if (! (ngram_hash_ref && SvROK(*ngram_hash_ref)))
      croak("NGramC: Internal error (no n-gram counts found for n = %d)", n - i);
    ngram_hash = (HV*) SvRV(*ngram_hash_ref);

    ngram_cp = hv_fetch(ngram_hash, ngram + i, n - i, 0);
    if (ngram_cp)
      cp = SvNV(*ngram_cp);
    else
      cp = 0;
    total_cp += cp * factor;
    factor *= q;
  }
  
  if (total_cp <= 0) 
    croak("NGramC: Internal error (conditional probability = %f <= 0 for ngram '%s')", total_cp, ngram);
  return((return_log) ? log2(total_cp) : total_cp);
}

/**  log_string_probability() ... estimate log2 of string probability with n-gram model
 * ARGUMENTS
 *   ngram_hash_table_ref ... reference to data structure holding conditional n-gram probabilities (see NGram.pm)
 *   string     ... NUL-terminated byte string whose probability will be computed
 *   n          ... order of n-gram model (i.e., n)
 *   q          ... smoothing factor for geometric interpolation (0 < q < 1, larger values give stronger smoothing)
 *   debug      ... if TRUE, print verbose debugging information while calculating probability
 */
double log_string_probability(SV* ngram_hash_table_ref, char *string, int n, double q, int debug) {
/*   SV* ngram_buffer; */
/*   char* ngram; */
  int len, i, real_n, offset;
  double log_p, log_cp;

  /*  ngram_buffer = sv_2mortal(newSV(n + 1)); /* allocate temporary string as buffer for ngrams */
  /* ngram = (char *) SvPVC(ngram_buffer); /* this should give us a pointer to the allocated buffer with at least n+1 bytes */

  len = strlen(string);
  log_p = 0;

  for (i = 0; i < len; i++) {
    if (i < n) {
      real_n = i + 1; /* n-gram length actually used in this iteration (shorter at start of string) */
      offset = 0;     /* start offset of ngram for this iteration */
    }
    else {
      real_n = n;
      offset = i - n + 1;
    }
    /* conditional_probability() doesn't require NUL-terminated string if n-gram length is explicitly specified => apply to substring */
    log_cp = conditional_probability(ngram_hash_table_ref, string + offset, real_n, q, 1);
    log_p += log_cp;
    if (debug)
      printf("\n + pC(%.*s) = %.2f bits   total = %.2f bits", real_n, string+offset, log_cp, log_p);
  }

  return(log_p);
}

/**  count_ngrams() ... update n-gram counts in hash table
 * ARGUMENTS
 *   n          ... order of n-gram model (i.e., n)
 *   string     ... NUL-terminated byte string from which n-gram counts are obtained (already padded as necessary)
 *   weight     ... integer weight for n-gram counts (e.g. -1 to subtract counts in differential training)
 *   ngram_hash_table_ref ... reference to hash table with n-gram counts to be updated
 * VALUE
 *   count      ... total number of n-grams in string
 */
int count_ngrams(int n, char *string, int weight, SV* ngram_hash_ref) {
  HV* ngram_hash;
  int len, i, count;

  if (! SvROK(ngram_hash_ref))
    croak("NGramC: Internal error (ngram_hash_ref is not a reference)");
  ngram_hash = (HV*) SvRV(ngram_hash_ref);
      
  len = strlen(string);

  for (i = 0; i <= len - n; i++) {
    char *ngram = string + i;
    SV** ngram_count = hv_fetch(ngram_hash, ngram, n, 0);
   
    if (ngram_count)
      sv_setiv(*ngram_count, SvIV(*ngram_count) + weight); /* increment existing n-gram count */
    else
      hv_store(ngram_hash, ngram, n, newSViv(weight), 0); /* add new n-gram entry to hash */
    
    count++;
  }

  return(count);
}


