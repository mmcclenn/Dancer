package Dancer::Serializer::YAML;
BEGIN {
  $Dancer::Serializer::YAML::AUTHORITY = 'cpan:SUKRIA';
}
#ABSTRACT: serializer for handling YAML data
$Dancer::Serializer::YAML::VERSION = '1.3129';
use strict;
use warnings;
use Carp;
use Dancer::ModuleLoader;
use Dancer::Exception qw(:all);
use base 'Dancer::Serializer::Abstract';

# helpers

sub from_yaml {
    my ($yaml) = @_;
    my $s = Dancer::Serializer::YAML->new;
    $s->deserialize($yaml);
}

sub to_yaml {
    my ($data) = @_;
    my $s = Dancer::Serializer::YAML->new;
    $s->serialize($data);
}

# class definition

sub loaded { Dancer::ModuleLoader->load('YAML') }

sub init {
    my ($self) = @_;
    raise core_serializer => 'YAML is needed and is not installed'
      unless $self->loaded;
}

sub serialize {
    my ($self, $entity) = @_;
    YAML::Dump($entity);
}

sub deserialize {
    my ($self, $content) = @_;
    YAML::Load($content);
}

sub content_type {'text/x-yaml'}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dancer::Serializer::YAML - serializer for handling YAML data

=head1 VERSION

version 1.3129

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 serialize

Serialize a data structure to a YAML structure.

=head2 deserialize

Deserialize a YAML structure to a data structure

=head2 content_type

Return 'text/x-yaml'

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
