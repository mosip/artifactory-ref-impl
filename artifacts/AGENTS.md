# artifacts/ — artifactory-server image

This directory builds the `artifactory-server` Docker image: an nginx-based
static file server that bundles MOSIP SDK jars, zips, i18n bundles, themes,
templates, and other release artifacts consumed by other MOSIP services
during deployment.

## How it's built

`Dockerfile` does roughly:
1. Installs `unzip`/`wget`/`zip`, plus Maven 3.9.16 and a Temurin JDK 11
   tarball (both downloaded directly, not via apt — see note below).
2. `COPY`s source zips/jars/i18n content from `src/` into
   `/usr/share/nginx/html/artifactory/libs-release-local/...`.
3. Runs `mvn dependency:resolve && mvn clean install`, which resolves a set
   of Maven artifacts declared in `pom.xml` and copies them into that same
   tree (see the `maven-dependency-plugin` config in `pom.xml` for the
   authoritative list of what gets pulled in).
4. Runs `configure.sh`, which zips up several of those directories
   (biosdk-client, biosdk-lib, demosdk, esignet-wrapper, certify-plugin,
   i18n bundles, theme, image, master-templates, pdf-generator,
   registration-api-impl) and removes the loose directories.
5. Rewrites nginx to listen on 8080 and switches to a non-root `mosip` user.

## Base image note (2026-09)

The image was moved from a pinned Debian **bullseye**-based `nginx` digest to
a **bookworm**-based one (`nginx@sha256:552e7481...`, i.e. `nginx:1.28.0-bookworm`)
because bullseye's `bullseye-security` `InRelease` file was expiring, causing
`apt-get update` to fail with exit code 100 in CI. Debian bookworm does not
carry `openjdk-11-jdk` in its repos ("Package not available in this suite"),
so JDK 11 is installed from an Adoptium Temurin tarball the same way Maven
already was — see the `RUN` block in `Dockerfile` for both downloads. If you
ever need to update the base image again, re-check whether the target
Debian release still ships `openjdk-11-jdk`; if not, keep using the Temurin
tarball path rather than switching Java versions.

## Testing a local build

Build and run the image:

```
docker build -t artifactory-server-test:local .
docker run -d --name artifactory-test -p 8080:8080 artifactory-server-test:local
```

Then verify **every** file nginx is serving is actually downloadable and
byte-correct — not just a handful of spot checks — with `verify-artifacts.sh`:

```
./verify-artifacts.sh --start artifactory-server-test:local
```

This enumerates files from inside the running container (ground truth,
not a hardcoded list) so it can't drift out of date as `pom.xml` or
`configure.sh` change, downloads each one into a fresh
`/tmp/artifactory-verify-<container>-<timestamp>/` directory, and compares
size + sha256 against the copy inside the container. It exits non-zero and
lists every failing path if anything is missing, truncated, or mismatched.

Run `./verify-artifacts.sh --help`-equivalent by reading the header comment
in the script for the plain (no `--start`) invocation against an
already-running container.
