use strict;
use warnings;

package Badge::Depot;

# ABSTRACT: A framework for badges
# AUTHORITY
our $VERSION = '0.0105';

use Moose::Role;
use Types::URI qw/Uri/;
use Types::Standard qw/Str InstanceOf/;
use MooseX::AttributeShortcuts;
use namespace::autoclean;

has image_url => (
    is => 'rw',
    isa => Uri,
    init_arg => undef,
    coerce => 1,
    predicate => 1,
);
has image_alt => (
    is => 'rw',
    isa => Str,
    init_arg => undef,
    predicate => 1,
);
has link_url => (
    is => 'rw',
    isa => Uri,
    init_arg => undef,
    coerce => 1,
    predicate => 1,
);
has zilla => (
    is => 'ro',
    isa => InstanceOf['Dist::Zilla'],
    predicate => 1,
);


around qw/to_html to_markdown/ => sub {
    my $next = shift;
    my $self = shift;

    return '' if !$self->has_image_url;
    $self->$next;
};

sub to_html {
    my $self = shift;

    my $image_text = $self->has_image_alt ? sprintf ' alt="%s"', $self->image_alt : '';

    if($self->has_link_url) {
        return sprintf q{<a href="%s"><img src="%s"%s /></a>}, $self->link_url, $self->image_url, $image_text;
    }
    else {
        return sprintf q{<img src="%s"%s />}, $self->image_url, $image_text;
    }
}
sub to_markdown {
    my $self = shift;

    if($self->has_link_url) {
        return sprintf q<[![%s](%s)](%s)>, $self->image_alt // '', $self->image_url, $self->link_url;
    }
    else {
        return sprintf q<![%s](%s)>, $self->image_alt // '', $self->image_url;
    }
}

1;

__END__

=pod

=head1 SYNOPSIS

    # Define a badge class
    package Badge::Depot::Plugin::Example;

    use Moose;
    with 'Badge::Depot';

    has user => (
        is => 'ro',
        isa => 'Str',
        required => 1,
    );

    sub BUILD {
        my $self = shift;
        $self->link_url(sprintf 'https://example.com/users/%s', $self->user);
        $self->image_url(sprintf 'https://example.com/users/%s.svg', $self->user);
        $self->image_alt('Example text');
    }

    # Somewhere else
    my $badge = Badge::Depot::Plugin::Example->new(user => 'my_username');

    print $badge->to_html;
    # prints '<a href="https://example.com/users/my_username"><img src="https://example.com/users/my_username.svg" alt="Example text" /></a>'


=head1 DESCRIPTION

C<Badge::Depot> is a framework for documentation badges. Using badges in your documentation can give
end users of your distribution dynamic information without you having to update the documentation.

You only need use this distribution directly if you want to create a new badge in the C<Badge::Depot::Plugin> namespace. See L<Task::Badge::Depot> for
a list of existing badges.

For use together with L<Pod::Weaver>, see L<Pod::Weaver::Section::Badges>.

=head1 OVERVIEW

C<Badge::Depot> is a L<Moose> role that adds a few attributes and methods.


=head1 ATTRIBUTES

These attributes are expected to be set when the badge class returns from C<new>. See L<synopsis|/SYNOPSIS>.


=head2 image_url

Required. L<Uri|Types::URI>.

The url to the actual badge. The src attribute for the img tag when rendered to html.


=head2 image_alt

Optional. L<Str|Types::Standard>.

The alternative text of the badge. The alt attribute for the img tag when rendered to html. No alternative text is created if this isn't set.


=head2 link_url

Optional (but recommended). L<Uri|Types::URI>.

The url to link the badge to. The href attribute for the a tag when rendered to html. No link is created if this isn't set.


=head2 zilla

This is not a user setable attribute, but rather can be used by plugins that might need to look at distribution meta data. This is only usable when using L<Pod::Weaver::Section::Badges> together with L<Dist::Zilla>.

=head1 METHODS

These methods are used when rendering the badge, and are not useful inside badge classes.

=head2 to_html

Returns a string with the badge rendered as html.

=head2 to_markdown

Returns a string with the badge rendered as markdown.


=head1 SEE ALSO

=for :list
* L<Task::Badge::Depot> - List of available badges
* L<Pod::Weaver::Section::Badges> - Weave the badges
* L<WWW::StatusBadge> - An alternative badge framework

=cut
