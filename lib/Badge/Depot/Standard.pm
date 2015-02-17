use 5.14.0;
use strict;
use warnings;

package Badge::Depot::Standard {

    # VERSION:
    # ABSTRACT: Import to all

    use base 'Moops';
    use MooseX::AttributeDocumented();
    use Types::Standard();
    use Types::URI();

    sub import {
        my $class = shift;
        my %opts = @_;

        push @{ $opts{'imports'} ||= [] } => (
            'feature'           => [qw/:5.14/],
            'MooseX::AttributeDocumented' => [],
            'Types::Standard'   => [{ replace => 1 }, '-types'],
            'Types::URI'        => [{ replace => 1 }, '-types'],
        );

        $class->SUPER::import(%opts);
    }
}

1;
