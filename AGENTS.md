# AGENTS.md

This file provides guidance to AI agents when working with code in this repository.

## What This Repository Is

`artifactory-ref-impl` is a **static artifact server** for the MOSIP platform. It packages and serves dynamically-loaded libraries, i18n bundles, themes, images, and configuration resources consumed by MOSIP services at runtime. The server itself is an nginx container — there is no application source code; all build logic lives in Docker and Maven.

## Build and Deployment

### Building the Docker Image

The entire build happens inside Docker:

```sh
cd artifacts
docker build -t artifactory-server .
```

The `Dockerfile` does the following in sequence:
1. Installs OpenJDK 11 and Maven 3.9.16 into an nginx base image.
2. Copies static source files from `artifacts/src/` into the container.
3. Runs `mvn clean install` (via `pom.xml`) to download all jar dependencies from Maven Central / Sonatype OSSRH and place them under `/usr/share/nginx/html/artifactory/libs-release-local/`.
4. Runs `configure.sh` to zip up SDK clients, i18n bundles, themes, images, and other directories into their final `.zip` form.
5. Serves everything on port 8080 via nginx.

### Kubernetes Deployment (requires KUBECONFIG set)

```sh
# Install
cd deploy && ./install.sh

# Delete
cd deploy && ./delete.sh

# Restart
cd deploy && ./restart.sh
```

The `install.sh` script creates the `artifactory` namespace with Istio injection enabled and deploys via `helm install artifactory mosip/artifactory --version x.x.x-develop`.

## Artifact Organization (`artifacts/src/`)

| Directory | Purpose |
|---|---|
| `auth/` | kernel-auth-adapter jar(s) served to regproc, admin, and other services |
| `deployment/docker/id-authentication/` | Shell scripts for IDA container startup |
| `hsm/` | SoftHSM client zip |
| `i18n/` | Locale JSON bundles for each UI module (see below) |
| `icu4j/` | ICU4J transliteration jar for pre-registration |
| `image/` | Image assets for eSignet and eSignet-signup UIs |
| `jre/` | JRE distributed to registration client |
| `master-templates/` | Master data templates for admin service |
| `mosip-plugins/sign-in-with-esignet/` | OIDC plugin zip |
| `pdf-generator/` | PDF generation resources |
| `sdk/biosdk/` / `sdk/demosdk/` | BioSDK and DemoSDK install scripts |
| `testing/` | glowroot and regproc reprocessor test zips |
| `theme/` | UI themes for eSignet and eSignet-signup |

## i18n Bundles

The most frequently updated part of this repo. Each UI module has a subdirectory under `artifacts/src/i18n/`:

- `admin-i18n-bundle/` — Admin UI
- `admin-entity-spec-bundle/` — Admin entity spec JSONs (form field definitions)
- `esignet-i18n-bundle/` — eSignet UI
- `esignet-signup-i18n-bundle/` — eSignet Signup UI
- `mock-relying-party-i18n-bundle/` — OIDC demo/mock relying party
- `oidc-demo-i18n-bundle/` — OIDC demo app
- `pmp-i18n-bundle/` / `pmp-entity-spec-bundle/` — Partner Management Portal
- `pre-registration-i18n-bundle/` — Pre-registration UI
- `regclient-i18n-bundle/` — Registration Client resources

Language files follow the pattern `<lang-code>.json` (e.g., `en.json`, `ar.json`, `hi.json`, `km.json`, `kn.json`, `ta.json`, `default.json`). `default.json` is the fallback locale.

`configure.sh` zips each bundle directory into `<bundle-name>.zip` during the Docker build. Edits to JSON files take effect only after rebuilding the Docker image.

## Jar Version Management

All jar artifact versions and their nginx destination paths are defined as Maven properties in `artifacts/pom.xml`. To update a jar version, change the corresponding `<version>` property (e.g., `<auth-adapter.version>`).

To check available snapshot timestamps on Sonatype:

```sh
bash artifacts/build_version.sh
```

## CI/CD (GitHub Actions)

All workflows delegate to shared reusable workflows from `mosip/kattu`:

| Workflow | Trigger | Action |
|---|---|---|
| `push-trigger.yml` | Push to `master`, `develop`, `1.*`, `MOSIP*`, `release*`; PR; release | Builds and pushes Docker image to Docker Hub as `mosipqa/artifactory-server` |
| `chart-lint-publish.yml` | Push/PR touching `helm/**`; release | Lints and publishes Helm chart to `mosip-helm` gh-pages |
| `tag.yml` | Manual (`workflow_dispatch`) | Creates a GitHub release tag |

Docker Hub push requires secrets: `DEV_NAMESPACE_DOCKER_HUB`, `ACTOR_DOCKER_HUB`, `RELEASE_DOCKER_HUB`, `SLACK_WEBHOOK`.

## MOSIP Platform Context

This server is part of the MOSIP 1.2.x ID lifecycle management platform. Its artifacts support these subsystems:

- **Registration Client** — biometric/demographic data capture at registration centers; consumes biosdk-client, demosdk, JRE, reg-client resources, and i18n bundles.
- **Registration Processor** — server-side packet processing; consumes virus scanner (ClamAV), auth adapter, cache provider (Hazelcast/Redis).
- **ID Authentication (IDA)** — identity verification service; uses kernel-auth-adapter, child-auth-filter, esignet wrappers.
- **eSignet** — OIDC/OAuth2 identity provider; uses authentication wrappers (`esignet-mock-wrapper.jar`, `esignet-ida-wrapper.jar`, `sunbird-rc-esignet-integration-impl.jar`), i18n bundles, themes, and images.
- **Pre-registration** — citizen self-service portal; uses ICU4J transliteration and i18n.
- **Admin UI / PMP** — operator and partner management; uses entity spec bundles and i18n bundles.
- **Certify** — verifiable credential issuance; uses certify plugin jars (`certify-sunbird-plugin.jar`, `certify-mosip-identity-plugin.jar`, `certify-mock-identity-plugin.jar`).

All artifacts are served as plain HTTP files from nginx at paths matching `http://<host>/artifactory/libs-release-local/<path>`. The `helm/artifactory/values.yaml` `artifacts:` section lists the canonical paths consumed by other MOSIP Helm charts.
