package Mail::SendGrid::Bounce;
{
  $Mail::SendGrid::Bounce::VERSION = '0.03';
}
# ABSTRACT: data object that holds information about a SendGrid bounce
use strict;
use warnings;

use Mouse 0.94;

has 'email'     => (is => 'ro', isa => 'Str', required => 1);
has 'created'   => (is => 'ro', isa => 'Str', required => 1);
has 'status'    => (is => 'ro', isa => 'Str', required => 1);
has 'reason'    => (is => 'ro', isa => 'Str', required => 1);

1;


__END__
=pod

=head1 NAME

Mail::SendGrid::Bounce - data object that holds information about a SendGrid bounce

=head1 VERSION

version 0.03

=head1 SYNOPSIS

    use Mail::SendGrid::Bounce;

    $bounce = Mail::SendGrid::Bounce->new(
                        email   => '...',
                        created => '...',
                        status  => '...',
                        reason  => '...',
                       );

=head1 DESCRIPTION

This class defines a data object which is returned by the C<bounces()>
method in L<Mail::SendGrid>. Generally you won't instantiate this
module yourself.

=head1 METHODS

=head2 email

The email address you tried sending to, which resulted in a bounce
back to SendGrid.

=head2 created

Date and time in ISO date format. I'm assuming this is the timestamp
for when the bounce was received back at SendGrid.

=head2 status

Not sure.

=head2 reason

The reason why the message bounced; typically this is the reason returned
by the remote MTA.

=head1 SEE ALSO

=over 4

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

