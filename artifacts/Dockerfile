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

# environment variable for Biosdk Zip.
ENV biosdk_zip_path=${base_path}/libs-release-local/biosdk/mock/0.9

# environment variable for Cache Provider Jar
ENV cache_path=${base_path}/libs-release-local/cache

# environment variable for ida shell scripts.
ENV ida_sh_path=${base_path}/libs-release-local/deployment/docker/id-authentication

# environment variable for hsm client
ENV hsm_client_path=${base_path}/libs-release-local/hsm

# environment valiable for sdk jar
ENV sdk_path=${base_path}/libs-release-local/mock-sdk/1.1.5/

# environment variable for Kernel Jars
ENV kernel_jar_path=${base_path}/libs-release-local/io/mosip/kernel

# environment variable for regproc reprocessor ceylon cache jar
ENV test_jar_path=${base_path}/libs-release-local/io/mosip/testing/

# environment variable for ref-idobjectvalidator jar
ENV idobject_jar_path=${base_path}/libs-snapshot-local/io/mosip/kernel/kernel-ref-idobjectvalidator

# environment variable for regproc auth jar
ENV regproc_jar_path=${base_path}/libs-snapshot-local/io/mosip/kernel/kernel-auth-adapter

# environment variable for jar version to be downloaed, this needed to be passed buildtime
ENV version=1.1.5

# environment variable for maven central mosip artifacts 
ENV release_maven_path=https://repo1.maven.org/maven2/io/mosip

# environment variable for maven central auth adapter. In case released uncomment this and comment out below duplicate one.
#ENV auth_adapter_jar_url=${release_maven_path}/kernel/kernel-auth-adapter/${version}/kernel-auth-adapter-${version}.jar
ENV auth_adapter_jar_url=https://oss.sonatype.org/service/local/repositories/snapshots/content/io/mosip/kernel/kernel-auth-adapter/1.1.5-SNAPSHOT/kernel-auth-adapter-1.1.5-20210402.053751-26.jar

# environment variable for msg91_jar url. 
#ENV sms_msg91_url=${release_maven_path}/kernel/kernel-smsserviceprovider-msg91/${version}/kernel-smsserviceprovider-msg91-${version}.jar
ENV sms_msg91_url=https://oss.sonatype.org/service/local/repositories/snapshots/content/io/mosip/kernel/kernel-smsserviceprovider-msg91/1.2.0-SNAPSHOT/kernel-smsserviceprovider-msg91-1.2.0-20201120.073356-224.jar

# environment variable for ref-idobjectvalidator_jar url
#ENV ref_idobjectvalidator_jar_url=${release_maven_path}/kernel/kernel-ref-idobjectvalidator/${version}/kernel-ref-idobjectvalidator-${version}.jar
ENV ref_idobjectvalidator_jar_url=https://oss.sonatype.org/service/local/repositories/snapshots/content/io/mosip/kernel/kernel-auth-adapter/1.1.5-SNAPSHOT/kernel-auth-adapter-1.1.5-20210322.125226-19.jar

# environment variable for sdk url
ENV sdk_jar_url=https://oss.sonatype.org/content/repositories/snapshots/io/mosip/mock/sdk/mock-sdk/1.1.5-SNAPSHOT/mock-sdk-1.1.5-20210329.042625-10.jar

# environment variable for cache URL 
ENV cache_url=https://repo1.maven.org/maven2/com/hazelcast/hazelcast-all/4.1.1/hazelcast-all-4.1.1.jar

# Create all the Jar paths
RUN mkdir -p ${biosdk_zip_path} ${cache_path} ${ida_sh_path} ${hsm_client_path} ${kernel_jar_path} ${test_jar_path} ${idobject_jar_path} ${regproc_jar_path} ${sdk_path}

# Copy all the respective jars to the location

COPY /src/biosdk/biosdk.zip ${biosdk_zip_path}/

COPY /src/deployment/docker/id-authentication/* ${ida_sh_path}/

COPY /src/hsm/client.zip ${hsm_client_path}/

COPY /src/testing/regproc-reprocessor-ceylon-cache-repo.zip ${test_jar_path}/

COPY /src/testing/glowroot.zip ${test_jar_path}/

COPY /src/auth/* ${regproc_jar_path}/

# Download required respective all the jars

RUN wget ${auth_adapter_jar_url} -O ${kernel_jar_path}/kernel-auth-adapter.jar  &&\ 
 wget ${sms_msg91_url} -O ${kernel_jar_path}/kernel-smsserviceprovider-msg91.jar  &&\
 wget ${ref_idobjectvalidator_jar_url} -O ${idobject_jar_path}/kernel-ref-idobjectvalidator.jar &&\
 wget ${cache_url} -O ${cache_path}/cache-provider.jar &&\
 wget ${sdk_jar_url} -O ${sdk_path}/mock-sdk.jar
