#!/usr/bin/env bash
set -e

# Don't pass --file or -f parameter to get binaries manually
# You can still pass remaining parameters described in README.md
. ../get-binaries.sh $@

# Get binaries using gb_fetch command
gb_fetch terragrunt v0.21.6 'https://github.com/gruntwork-io/terragrunt/releases/download/{version}/terragrunt_{platform}_amd64'
gb_fetch terraform 0.12.16 'https://releases.hashicorp.com/terraform/{version}/terraform_{version}_{platform}_amd64.zip'

# Display summary message
gb_summary
