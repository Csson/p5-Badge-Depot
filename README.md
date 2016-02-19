# NAME

Badge::Depot - A framework for badges

<div>
    <p>
    <img src="https://img.shields.io/badge/perl-5.10+-blue.svg" alt="Requires Perl 5.10+" />
    <a href="https://travis-ci.org/Csson/p5-Badge-Depot"><img src="https://api.travis-ci.org/Csson/p5-Badge-Depot.svg?branch=master" alt="Travis status" /></a>
    <a href="http://cpants.cpanauthors.org/dist/Badge-Depot-0.0104"><img src="https://badgedepot.code301.com/badge/kwalitee/Badge-Depot/0.0104" alt="Distribution kwalitee" /></a>
    <a href="http://matrix.cpantesters.org/?dist=Badge-Depot%200.0104"><img src="https://badgedepot.code301.com/badge/cpantesters/Badge-Depot/0.0104" alt="CPAN Testers result" /></a>
    <img src="https://img.shields.io/badge/coverage-100.0%-brightgreen.svg" alt="coverage 100.0%" />
    </p>
</div>

# VERSION

Version 0.0104, released 2016-02-19.

# SYNOPSIS

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

# DESCRIPTION

`Badge::Depot` is a framework for documentation badges. Using badges in your documentation can give
end users of your distribution dynamic information without you having to update the documentation.

You only need use this distribution directly if you want to create a new badge in the `Badge::Depot::Plugin` namespace. See [Task::Badge::Depot](https://metacpan.org/pod/Task::Badge::Depot) for
a list of existing badges.

For use together with [Pod::Weaver](https://metacpan.org/pod/Pod::Weaver), see [Pod::Weaver::Section::Badges](https://metacpan.org/pod/Pod::Weaver::Section::Badges).

# OVERVIEW

`Badge::Depot` is a [Moose](https://metacpan.org/pod/Moose) role that adds a few attributes and methods.

# ATTRIBUTES

These attributes are expected to be set when the badge class returns from `new`. See [synopsis](#synopsis).

## image\_url

Required. [Uri](https://metacpan.org/pod/Types::URI).

The url to the actual badge. The src attribute for the img tag when rendered to html.

## image\_alt

Optional. [Str](https://metacpan.org/pod/Types::Standard).

The alternative text of the badge. The alt attribute for the img tag when rendered to html. No alternative text is created if this isn't set.

## link\_url

Optional (but recommended). [Uri](https://metacpan.org/pod/Types::URI).

The url to link the badge to. The href attribute for the a tag when rendered to html. No link is created if this isn't set.

## zilla

This is not a user setable attribute, but rather can be used by plugins that might need to look at distribution meta data. This is only usable when using [Pod::Weaver::Section::Badges](https://metacpan.org/pod/Pod::Weaver::Section::Badges) together with [Dist::Zilla](https://metacpan.org/pod/Dist::Zilla).

# METHODS

These methods are used when rendering the badge, and are not useful inside badge classes.

## to\_html

Returns a string with the badge rendered as html.

## to\_markdown

Returns a string with the badge rendered as markdown.

# SEE ALSO

- [Task::Badge::Depot](https://metacpan.org/pod/Task::Badge::Depot) - List of available badges
- [Pod::Weaver::Section::Badges](https://metacpan.org/pod/Pod::Weaver::Section::Badges) - Weave the badges
- [WWW::StatusBadge](https://metacpan.org/pod/WWW::StatusBadge) - An alternative badge framework

# SOURCE

[https://github.com/Csson/p5-Badge-Depot](https://github.com/Csson/p5-Badge-Depot)

# HOMEPAGE

[https://metacpan.org/release/Badge-Depot](https://metacpan.org/release/Badge-Depot)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
