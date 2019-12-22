# get-dependencies

Small, cross-platform (macOS/Linux) binary downloader script, which can be included in projects to speed-up dev 
environment preparation. Obviously, all developers in your project can manually manage it's dependencies, but if one's
working on multiple projects it's good to have a quick way of setting up environment. This script automatically extracts
files from `tar.gz` and `zip` archives. It accepts the following arguments:

| Argument | Default | Description |
| --- | --- | --- |
| `--copy` | - | Copies downloaded binaries to global location |
| `-g` or `--global-bin-dir` | `/usr/local/bin` | Sets global binary location |
| `-f` or `--file` | `.binaries` | Sets a file with binary definitions |
| `--upgrade` | - | Upgrades `get-binaries.sh` script to a new version

Check [.binaries](examples/.binaries) file for syntax sample. Use `{version}` and `{platform}` variables in URL.

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

Then define `.binaries` file (check the example in `examples/.binaries`). Yes, you have to define download URLs yourself.

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
