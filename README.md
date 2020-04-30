# get-binaries

Small, cross-platform (macOS/Linux) binary downloader script, which can be included in projects to speed-up dev 
environment preparation. Obviously, all developers in your project can manually manage it's dependencies, but if one's
working on multiple projects it's good to have a quick way of setting up environment. This script automatically extracts
files from `tar.gz` and `zip` archives. It accepts the following arguments:

| Argument | Default | Description |
| --- | --- | --- |
| `--copy` | - | Copies downloaded binaries to global location |
| `-g` or `--global-bin-dir` | `/usr/local/bin` | Sets global binary location |
| `-f` or `--file` | `.binaries` | Sets a file with binary definitions |
| `--upgrade` | - | Upgrades `get-binaries.sh` script to a new version |

Check [.binaries](examples/usage-with-file/.binaries) file for syntax sample. Use `{version}` and `{platform}` variables in URL.

Platform variable replacement can be done by:
- passing additional parameters like `--linux=lin` or `--darwin=osx` to `gb_fetch` (when you specify it manually)
- passing additional part in `.binaries` file like `linux=lin` or `darwin=osx` (when you specify binaries in file)

## Setup

`get-binaries.sh` depends on the following binaries, which should be present by default on most systems:
- `bash`
- `curl`,
- `shasum` or `sha256sum` (if using lockfile)
- `tar` or `unzip` (if you're downloading archives)

```sh
curl https://raw.githubusercontent.com/krzysztof-miemiec/get-binaries/latest/get-binaries.sh -o get-binaries.sh
chmod +x get-binaries.sh
. get-binaries.sh
```

Then define `.binaries` file. Yes, you have to define download URLs yourself like that:
```
kubectl     1.17.3  https://storage.googleapis.com/kubernetes-release/release/v{version}/bin/{platform}/amd64/kubectl
kustomize   3.5.4   https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv{version}/kustomize_v{version}_{platform}_amd64.tar.gz
vault       1.3.0   https://releases.hashicorp.com/vault/{version}/vault_{version}_{platform}_amd64.zip
jq          1.6     https://github.com/stedolan/jq/releases/download/jq-{version}/jq-{platform}64 darwin=osx-amd
yq          2.4.0   https://github.com/mikefarah/yq/releases/download/{version}/yq_{platform}_amd64
skaffold    1.2.0   https://storage.googleapis.com/skaffold/releases/v{version}/skaffold-{platform}-amd64
kubedb      0.12.0  https://github.com/kubedb/cli/releases/download/{version}/kubedb-{platform}-amd64
helm        3.2.0   https://get.helm.sh/helm-v{version}-{platform}-amd64.tar.gz|{platform}-amd64/helm

```

### Breakdown of `.binaries` file structure:

* Specify your binaries in `name version url <optional platform name reassignments>` format
* Separate values by tabs or spaces
* Don't use any quotation marks
* Use `{version}` to replace version in url
* Use `{platform}` to replace platform in url; by default it's `darwin` for macOS and `linux` for Linux
* Specify platform reassignments as last arguments (see *jq* line in example above)
* Use `|` character as a separator if you want to specify a path *inside* archive (see `helm` line in example above)

## Why it's good?

I'm not sure if it's the best approach (probably not), but it:
- is simple (can be stored in repository, less than 200 loc, can be upgraded with `--upgrade` command)
- is transparent (you can see the script in your repo prior to running it, so you can make sure it won't cause harm to your machine)
- does the job (if you're a dev opening a repo for the first time, you just run `./get-binaries.sh` and it's done)
- is located in your repo - you don't have to additionally download anything
- initially it was just a script located in single repository, but since it works well (at least for me & my CI/CD process) I decided to open-source it

## Why it sucks?

Couple of questions raised in my head before publishing:
- Yet another tool to manage other tools? Meh
- So I keep it in my repo, together with 2 other files (`.binaries` & lockfile)? Looks messy
