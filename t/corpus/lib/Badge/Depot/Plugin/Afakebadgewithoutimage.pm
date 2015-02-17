use Badge::Depot::Standard;

class Badge::Depot::Plugin::Afakebadgewithoutimage using Moose with Badge::Depot {

    has username => (
        is => 'ro',
        isa => Str,
    );

    method BUILD {
        $self->link_url(sprintf q{https://travis-ci.org/%s}, $self->username);
    }
}
