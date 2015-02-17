use 5.14.0;
use strict;
use warnings;

package Stenciller::Standard {

    # VERSION:
    # ABSTRACT: Import to all

    use base 'Moops';
    use List::AllUtils();
    use MooseX::AttributeDocumented();
    use Path::Tiny();
    use Types::Path::Tiny();
    use Types::URI();

    sub import {
        my $class = shift;
        my %opts = @_;

        push @{ $opts{'imports'} ||= [] } => (
            'List::AllUtils'    => [qw/any none sum uniq first_index/],
            'feature'           => [qw/:5.14/],
            'Types::Path::Tiny' => [{ replace => 1 }, '-types'],
            'Types::URI'        => [{ replace => 1 }, '-types'],
            'Types::Standard'   => [{ replace => 1 }, '-types'],
            'Path::Tiny'        => ['path'],
            'MooseX::AttributeDocumented' => [],
            'PerlX::Maybe'      => [qw/maybe provided/],
            'Carp'              => [qw/carp/],
        );

        $class->SUPER::import(%opts);
    }
}

1;
