#!/usr/bin/env bash
set -e

# Don't pass --file or -f parameter to get binaries manually if `.binaries` file isn't present
# You can still pass remaining parameters described in README.md
. ../../get-binaries.sh $@

# Get binaries using gb_fetch command, .`binaries.lock` will be automatically created
gb_fetch --name=terragrunt --version=v0.21.6 --url="https://github.com/gruntwork-io/terragrunt/releases/download/{version}/terragrunt_{platform}_amd64"
gb_fetch --name=terraform --version=0.12.16 --url="https://releases.hashicorp.com/terraform/{version}/terraform_{version}_{platform}_amd64.zip"

# Display summary message
gb_summary
