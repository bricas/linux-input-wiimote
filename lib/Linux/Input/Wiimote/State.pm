package Linux::Input::Wiimote::State;

use Moose;
use namespace::autoclean;

with 'Linux::Input::Wiimote::Role::Buttons' => {
    constants => {
        2     => 0x0001,
        1     => 0x0002,
        b     => 0x0004,
        a     => 0x0008,
        minus => 0x0010,
        home  => 0x0080,
        left  => 0x0100,
        right => 0x0200,
        down  => 0x0400,
        up    => 0x0800,
        plus  => 0x1000,
    }
};

has [ qw(rumble battery report_mode led acc ) ] => ( is => 'ro', init_arg => undef );

has 'extension' => ( is => 'ro', init_arg => undef, predicate => 'has_extension' );

for my $l ( 0..3 ) {
    __PACKAGE__->meta->add_method( 'led_' . ( $l + 1 ) => sub { shift->led & ( 2 ** $l ) ? 1 : 0 } );
}

__PACKAGE__->meta->make_immutable;

sub battery_level {
    return 100 * shift->battery / 0xd0;
}

1;

__END__

=head1 NAME

Linux::Input::Wiimote::State - Wiimote state information

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009-2010 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
