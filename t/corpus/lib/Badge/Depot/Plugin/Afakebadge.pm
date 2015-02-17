use Badge::Depot::Standard;

class Badge::Depot::Plugin::Afakebadge using Moose with Badge::Depot {

    has username => (
        is => 'ro',
        isa => Str,
    );
    has repo => (
        is => 'ro',
        isa => Str,
    );
    has alt_text => (
        is => 'ro',
        isa => Str,
        predicate => 1,
    );
    has dont_link => (
        is => 'ro',
        isa => Bool,
        default => 0,
    );

    method BUILD {
        $self->link_url(sprintf q{https://travis-ci.org/%s/%s}, $self->username, $self->repo) if !$self->dont_link;
        $self->image_url(sprintf q{https://travis-ci.org/%s/%s.svg?branch=master}, $self->username, $self->repo);
        $self->image_alt($self->alt_text) if $self->has_alt_text;
    }
}

1;
