use strict;
use warnings;
package Mail::SendGrid;
{
  $Mail::SendGrid::VERSION = '0.01';
}
# ABSTRACT: interface to SendGrid.com mail gateway APIs

use Mouse 0.94;
use HTTP::Tiny 0.013;
use XML::Simple 2.18;
use Mail::SendGrid::Bounce;

has 'api_user'     => (is => 'ro', isa => 'Str', required => 1);
has 'api_key'      => (is => 'ro', isa => 'Str', required => 1);

sub bounces
{
    my $self     = shift;
    my $uri      = 'https://sendgrid.com/api/bounces.get.xml?api_user='.$self->api_user.'&api_key='.$self->api_key.'&date=1';
    my $response = HTTP::Tiny->new->get($uri);
    my $data;
    my (@bounces, $bounce);

    if ($response->{success})
    {
        $data = XMLin($response->{content});
        foreach my $hashref (@{ $data->{'bounce'} })
        {
            $bounce = Mail::SendGrid::Bounce->new($hashref);
            push(@bounces, $bounce) if defined($bounce);
        }
    }
    else
    {
        print STDERR "Failed to make bounces request\n";
    }
    return @bounces;
}

1;


__END__
=pod

=head1 NAME

Mail::SendGrid - interface to SendGrid.com mail gateway APIs

=head1 VERSION

version 0.01

=head1 SYNOPSIS

 use Mail::SendGrid;
 
 $sendgrid = Mail::SendGrid->new('api_user' => '...', 'api_key' => '...');
 print "Email to the following addresses bounced:\n";
 foreach my $bounce ($sendgrid->bounces)
 {
     print "\t", $bounce->email, "\n";
 }

=head1 DESCRIPTION

This module provides easy access to the APIs provided by sendgrid.com, a service for sending emails.
At the moment the module just provides the C<bounces()> method. Over time I'll add more of the
SendGrid API.

=head1 METHODS

=head2 new

Takes two parameters, api_user and api_key, which were specified when you registered your account
with SendGrid. These are required.

=head2 bounces

This requests all outstanding bounces from SendGrid, and returns a list of Mail::SendGrid::Bounce objects.

=head1 SEE ALSO

=over 4

=item L<Mail::SendGrid::Bounce>

The class which defines the data objects returned by the bounces method.

=item SendGrid API documentation

L<http://docs.sendgrid.com/documentation/api/web-api/webapibounces/>

=back

=head1 AUTHOR

Neil Bowers <neilb@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Neil Bowers <neilb@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

