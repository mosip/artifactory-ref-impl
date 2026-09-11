# artifactory-server

* This is a reference implementation of artifactory service used within MOSIP.
* The artifactory service contains the dynamically loaded libraries and services.
* The current repository is a reference implementation of the artifactory service and it packages the necessary mocks, reference implementation to run the default version of MOSIP.
* Following are the artifacts which is being served by the service:
  * Kernel auth adapter jars.
  * Referenced IDObjectvalidator jar.
  * Sms service provider jar.
  * Transliteration ICU4J jar.
  * Registration api stub impl jar.
  * Virusscanner jar.
  * ClamAV client jar.
  * mock-sdk jar.
  * Biosdk client jar.
  * Biosdk client zip
  * Demo sdk jar and zip.
  * Childauth filter jar.
  * Hazelcast cache jar.
  * Redis cache jar.
  * Authentication wrapper jar.
  * Sunbird RC Certify plugin integration impl jar.
  * Softhsm client zip.
  * i18n bundles for multiple MOSIP UI's.
  * Masterdata templates for admin service module.
  * themes for multiple UI's.
* All these artifacts are released as a part of the Mosip Release with some of them being taken from open sourced repository as per the need.

All these artifacts are released as a part of the Mosip Release with some of them being taken from open sourced repository as per the need.

## Local build and testing

To build and test the `artifactory-server` image locally without a full K8
deployment:

```
  $ cd artifacts
  $ docker build -t artifactory-server-test:local .
  $ docker run -d --name artifactory-test -p 8080:8080 artifactory-server-test:local
```

Then verify that every artifact the image is supposed to serve actually
downloads correctly (no missing, truncated, or corrupted files) with
`artifacts/verify-artifacts.sh`:

```
  $ cd artifacts
  $ ./verify-artifacts.sh --start artifactory-server-test:local
```

This enumerates every file nginx is serving from inside the running
container (not a hardcoded list, so it can't go stale as `pom.xml` or
`configure.sh` change), downloads each one into a fresh
`/tmp/artifactory-verify-<container>-<timestamp>/` directory, and compares
size + sha256 against the copy inside the container. It prints a pass/fail
summary and exits non-zero listing every failing path if anything doesn't
match.

If you already have a container running, call it without `--start`:

```
  $ ./verify-artifacts.sh <container_name> <base_url>
```

See `artifacts/AGENTS.md` for more detail on the image build steps and the
base-image/JDK notes.

## Deployment in K8 cluster with other MOSIP services:
### Pre-requisites
* Set KUBECONFIG variable to point to existing K8 cluster kubeconfig file:
  * ```
    export KUBECONFIG=~/.kube/<my-cluster.config>
    ```
### Install
  ```
    $ cd deploy
    $ ./install.sh
   ```
### Delete
  ```
    $ cd deploy
    $ ./delete.sh
   ```
### Restart
  ```
    $ cd deploy
    $ ./restart.sh
   ```