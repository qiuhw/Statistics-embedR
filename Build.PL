use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Statistics::embedR',
    license             => 'perl',
    dist_author         => q{Hongwen Qiu <qiuhongwen@gmail.com>},
    dist_version_from   => 'lib/Statistics/embedR.pm',
    build_requires => {
        'perl'                       => 5.010,
        'Test::More'                 => 0,
        'Moose'                      => 0,
        'MooseX::Method::Signatures' => 0,
        'Statistics::useR'           => 0.01
    },
    add_to_cleanup     => [ 'Statistics-embedR-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();

# vim: sw=4 ts=4 ft=perl expandtab
