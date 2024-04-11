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