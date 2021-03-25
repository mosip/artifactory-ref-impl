FROM nginx

# can be passed during Docker build as build time environment for github branch to pickup configuration from.
ARG container_user=mosip

# can be passed during Docker build as build time environment for github branch to pickup configuration from.
ARG container_user_group=mosip

# can be passed during Docker build as build time environment for github branch to pickup configuration from.
ARG container_user_uid=1001

# can be passed during Docker build as build time environment for github branch to pickup configuration from.
ARG container_user_gid=1001

# install packages and create user
RUN apt-get -y update &&\
apt-get install -y unzip wget zip &&\
groupadd -g ${container_user_gid} ${container_user_group} &&\
useradd -u ${container_user_uid} -g ${container_user_group} -s /bin/sh -m ${container_user}

# set working directory for the user
WORKDIR /home/${container_user}

# environment variable for basepath
ENV base_path=/usr/share/nginx/html/artifactory

# environment variable for Biosdk Zip path
ENV biosdk_zip_path=${base_path}/libs-release-local/biosdk/mock/0.9

# environment variable for Cache Provider Jar path
ENV cache_path=${base_path}/libs-release-local/cache

# environment variable for ida shell scripts path
ENV ida_sh_path=${base_path}/libs-release-local/deployment/docker/id-authentication

# environment variable for hsm client path
ENV hsm_client_path=${base_path}/libs-release-local/hsm

# environment variable for Kernel Jars path
ENV kernel_jar_path=${base_path}/libs-release-local/io/mosip/kernel

# environment variable for regproc reprocessor ceylon cache jar path
ENV test_jar_path=${base_path}/libs-release-local/io/mosip/testing/

# environment variable for ref-idobjectvalidator jar path
ENV idobject_jar_path=${base_path}/libs-snapshot-local/io/mosip/kernel/kernel-ref-idobjectvalidator

# environment variable for regproc auth jar
ENV regproc_jar_path=${base_path}/libs-snapshot-local/io/mosip/kernel/kernel-auth-adapter

# environment variable for prereg transliteration jar path
ENV icu4j_jar_path=${base_path}/libs-release-local/icu4j

# environment variable for i18n zip path
ENV i18n_zip_path=${base_path}/libs-release-local/i18n

# environment variable for jar version to be downloaed, this needed to be passed buildtime
ENV version=1.1.5

# environment variable for maven central mosip artifacts 
ENV release_maven_path=https://repo1.maven.org/maven2/io/mosip

# environment variable for maven central auth adapter. In case released uncomment this and comment out below duplicate one.
#ENV auth_adapter_jar_url=${release_maven_path}/kernel/kernel-auth-adapter/${version}/kernel-auth-adapter-${version}.jar
ENV auth_adapter_jar_url=https://oss.sonatype.org/service/local/repositories/snapshots/content/io/mosip/kernel/kernel-auth-adapter/1.1.5-SNAPSHOT/kernel-auth-adapter-1.1.5-20210322.125226-19.jar

# environment variable for msg91_jar url. 
#ENV sms_msg91_url=${release_maven_path}/kernel/kernel-smsserviceprovider-msg91/${version}/kernel-smsserviceprovider-msg91-${version}.jar
ENV sms_msg91_url=https://oss.sonatype.org/service/local/repositories/snapshots/content/io/mosip/kernel/kernel-smsserviceprovider-msg91/1.2.0-SNAPSHOT/kernel-smsserviceprovider-msg91-1.2.0-20201120.073356-224.jar

# environment variable for ref-idobjectvalidator_jar url
#ENV ref_idobjectvalidator_jar_url=${release_maven_path}/kernel/kernel-ref-idobjectvalidator/${version}/kernel-ref-idobjectvalidator-${version}.jar
ENV ref_idobjectvalidator_jar_url=https://oss.sonatype.org/service/local/repositories/snapshots/content/io/mosip/kernel/kernel-ref-idobjectvalidator/1.2.0-SNAPSHOT/kernel-ref-idobjectvalidator-1.2.0-20201120.073339-158.jar

# Create all the Jar paths
RUN mkdir -p ${biosdk_zip_path} ${cache_path} ${ida_sh_path} ${hsm_client_path} ${kernel_jar_path} ${test_jar_path} ${idobject_jar_path} ${icu4j_jar_path} ${i18n_zip_path}  ${regproc_jar_path}

# Copy all the respective jars to the location

COPY /src/biosdk/biosdk.zip ${biosdk_zip_path}/

COPY /src/deployment/docker/id-authentication/* ${ida_sh_path}/

COPY /src/hsm/client.zip ${hsm_client_path}/

COPY /src/testing/regproc-reprocessor-ceylon-cache-repo.zip ${test_jar_path}/

COPY /src/testing/glowroot.zip ${test_jar_path}/

COPY /src/i18n/pre-registration-i18n-bundle.zip ${i18n_zip_path}/

COPY /src/i18n/admin-entity-spec-bundle.zip ${i18n_zip_path}/

COPY /src/i18n/admin-i18n-bundle.zip ${i18n_zip_path}/

COPY /src/icu4j/* ${icu4j_jar_path}/

COPY /src/auth/* ${regproc_jar_path}/
# Download required respective all the jars

RUN wget ${auth_adapter_jar_url} -O ${kernel_jar_path}/kernel-auth-adapter.jar  &&\ 
 wget ${sms_msg91_url} -O ${kernel_jar_path}/kernel-smsserviceprovider-msg91.jar  &&\
 wget ${ref_idobjectvalidator_jar_url} -O ${idobject_jar_path}/kernel-ref-idobjectvalidator.jar &&\
 wget https://repo1.maven.org/maven2/com/hazelcast/hazelcast-all/4.1.1/hazelcast-all-4.1.1.jar -O ${cache_path}/cache-provider.jar
