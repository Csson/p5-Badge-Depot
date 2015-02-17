use 5.14.0;
use strict;
use warnings;
use Badge::Depot::Standard;

# PODCLASSNAME

role Badge::Depot using Moose {

    # VERSION
    # ABSTRACT: Short intro

    has link_url => (
        is => 'ro',
        isa => Uri,
        init_arg => undef,
        predicate => 1,
    );
    has image_url => (
        is => 'ro',
        isa => Uri,
        init_arg => undef,
        predicate => 1,
    );
    has image_alt => (
        is => 'ro',
        isa => Str,
        init_arg => undef,
        predicate => 1,
    );

    around to_html, to_markdown($next: $self) {
        return '' if !$self->has_image_url;
        $self->$next;
    }

    method to_html {

        my $image_text = $self->has_image_alt ? sprintf ' alt="%s"', $self->image_alt : '';

        if($self->has_link_url) {
            return sprintf q{<a href="%s"><img src="%s"%s /></a>}, $self->link_url, $self->image_url, $image_text;
        }
        else {
            return sprintf q{<img src="%s"%s />}, $self->link_url, $self->image_url, $image_text;
        }
    }
    method to_markdown {

        if($self->has_link_url) {
            return sprintf q<[![%s](%s)](%s)>, $self->image_alt // '', $self->image_url, $self->link_url;
        }
        else {
            return sprintf q<![%s](%s)]>, $self->image_alt // '', $self->image_url;
        }
    }
}

1;


__END__

=pod

=head1 SYNOPSIS

    use Badge::Depot;

=head1 DESCRIPTION

Badge::Depot is ...

=head1 SEE ALSO

=cut
