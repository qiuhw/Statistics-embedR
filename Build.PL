use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Statistics::embedR',
    license             => 'perl',
    dist_author         => q{Hongwen Qiu <qiuhongwen@gmail.com>},
    dist_version_from   => 'lib/Statistics/embedR.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Statistics-embedR-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
