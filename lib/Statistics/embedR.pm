package Statistics::embedR;

use warnings;
use strict;
use Moose;
use MooseX::Method::Signatures;
use Statistics::useR;

=head1 NAME

Statistics::embedR - Object-oriented interface for Statistics::useR.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use Statistics::embedR;

    my $r = Statistics::embedR->new();
    $r->eval($cmd);            # execute $cmd

    $r->R("1")->{real}[0];     # 1
    $r->R("'1'")->{str}[0];    # '1'

    my $ary = [3,5,7];
    $r->arry2R($ary, "array"); # array == c(3,5,7)

    $r->sum("c(2,3)")->getvalue->{real}[0]; # 5, almost all R functions are available automatically

=head1 DESCRIPTION

This module provides an object-oriented interface for Statistics::useR.
And provides some additional useful methods for invoking R.

=cut

sub AUTOLOAD {
    my ($name) = our $AUTOLOAD =~ /::(\w+)$/;

    my $method = sub {
        my $self = shift;
        $name =~ s/_/./g;
        $self->eval("$name(@_)");
    };

    no strict 'refs';
    *{ $AUTOLOAD } = $method;
    goto &$method;
}

sub BUILD {
    init_R;
}

method DEMOLISH {
    $self->quit("save='no'");
    end_R;
}

=head1 METHODS

=head2 eval(Str $cmd)

Execute R cmd given by the $cmd.

=cut

method eval(Str $cmd) {
    eval_R($cmd);
}

=head2 R(Str $cmd)

Execute R cmd given by the $cmd, and returns result as a HashRef.

=cut

method R(Str $cmd) {
    $self->eval($cmd)->getvalue;
}

=head2 arry2R(ArrayRef $data, Str $RData)

Convert ArrayRef specified by $data to a R list structure with the name $RData.

=cut

method arry2R(ArrayRef $data, Str $RData) {
    Statistics::RData->new(
        data => {val => $data},
        'varname' => $RData
    );
    $self->eval("$RData <- $RData\$val");
}

=head1 AUTHOR

Hongwen Qiu, C<< <qiuhongwen at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-statistics-embedr at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Statistics-embedR>.
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Statistics::embedR

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Statistics-embedR>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Statistics-embedR>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Statistics-embedR>

=item * Search CPAN

L<http://search.cpan.org/dist/Statistics-embedR/>

=back

=head1 ACKNOWLEDGEMENTS

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Hongwen Qiu.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

no Moose;
__PACKAGE__->meta->make_immutable;

1; # End of Statistics::embedR

# vim: sw=4 ts=4 expandtab ft=perl
