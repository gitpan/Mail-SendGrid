
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "interface to SendGrid.com mail gateway APIs",
  "AUTHOR" => "Neil Bowers <neilb\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Test::More" => "0.88"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Mail-SendGrid",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Mail::SendGrid",
  "PREREQ_PM" => {
    "Carp" => "1.20",
    "HTTP::Tiny" => "0.013",
    "IO::Socket::SSL" => "1.44",
    "JSON" => "2.53",
    "Mouse" => "0.94",
    "URI::Escape" => "3.30",
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.06",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



