package Regexp::Any;

use strict;
use warnings;

use Carp qw(confess);

require Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

$Regexp::Any::VERSION    = 0.6;
@ISA                            = qw(Exporter);
@EXPORT                         = qw(&match_any &match_any_and_capture);
@EXPORT_OK                      = qw(&match_any);

sub match_any {
  my $ref = shift;
  my $opt = shift || '';
  my $regex = join('|', @{$ref});
  return qq{(?$opt:$regex)};
}

sub match_any_and_capture {
  my $ref = shift;
  my $opt = shift;
  my $regex = join('|', @{$ref});
  return qq{((?$opt)$regex)};
}

__END__

=head1 NAME

  Regexp::Any - Match many regexes against a variable

 
=head1 SYNOPSIS

  use Regexp::Any;
  my @array = qw(Foo Bar Wibble);
  my $opt = 'i'; #ignore case
  my $var = "foo";
  if($var =~ match_any(\@array,$opt)){
    print "It matched\n";
  }else{
    print "It didn't match\n";
  }

 sub profane {

    my $word = shift or die 'must supply word to match';

    my $re   = match_any_and_capture(\@profanity, $re_opt);

    if ($word =~ /($re)/) {
	return (1, $1);
    }  else {
	return (0);
    }
 }


=head1 DESCRIPTION

This module allows you to pass the match_any() function a reference to an
array of regexes which will
then return a full regex for the the variable to be matched
against. Optionally, you can pass it matching arguements such as 'g'
or 'i'. Pass these in one variable with no spaces.  Note: I from
personal experience have found this module to be very handy for use
with Mail::Audit.

An second function C<match_any_and_capture>, will supply capturing
parentheses to the generated regular expression, which can prove useful 
if you want to know which part of your regexp matched.

=head1 AUTHOR


  
  Terrence Brannon <tbone@cpan.org> supplied C<match_any_and_capture>

  Scott McWhirter <scott@kungfuftr.com> wrote Regexp::Match::Any but
  did not uploaded the patches to it which I needed for my module 
  Regexp::US::Profanity to piggyback on his module.

  So I was forced to release similar functionality under a different name;

