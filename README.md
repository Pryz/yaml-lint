[![GemVersion](https://badge.fury.io/rb/yaml-lint.svg)](http://badge.fury.io/rb/yaml-lint)
[![TravisBuild](https://travis-ci.org/Pryz/yaml-lint.svg?branch=master)](https://travis-ci.org/Pryz/yaml-lint.svg?branch=master)
[![Coverage Status](https://coveralls.io/repos/Pryz/yaml-lint/badge.svg?branch=master)](https://coveralls.io/r/Pryz/yaml-lint?branch=master)

yaml-lint
=========

Simple yaml check tool. yaml-lint will simply try to load the YAML file with the
built-in Ruby yaml library.

Install
-------

```shell
gem install yaml-lint
```

Usage
-----

Check a file

```shell
yaml-lint filename.yaml
```

Check a complete folder

```shell
yaml-lint hiera/
```

Check a complete folder, ignoring any non-YAML files

```shell
yaml-lint -i hiera/
```

Supported options:

```
$ yaml-lint --help

yaml-lint is a tool to check the syntax of your YAML files
Usage: yaml-lint [options] <file(s) or folder(s)>
    -q, --quiet                      Run quiet. Only log failing files.
    -Q, --very-quiet                 Run more quiet. Return code is the number of failed files.
    -n, --no-check-file-ext          Do not check the file extension to match known yaml files.
    -i, --ignore-non-yaml-files      Ignoring non-yaml files.
    -e, --exclude x,y,z              Coma-separated list of files or folders to exclude.
    -c, --no-color                   Disables the colors in the output.
    -h, --help
```
