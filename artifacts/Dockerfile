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

# environment variable for ida shell scripts
ENV ida_sh_path=${base_path}/libs-release-local/deployment/docker/id-authentication

# environment variable for hsm client
ENV hsm_client_path=${base_path}/libs-release-local/hsm

# environment variable for Kernel Jars
ENV kernel_jar_path=${base_path}/libs-release-local/io/mosip/kernel

# environment variable for regproc reprocessor ceylon cache jar
ENV test_jar_path=${base_path}/libs-release-local/io/mosip/testing/

# environment variable for ref-idobjectvalidator jar
ENV idobject_jar_path=${base_path}/libs-snapshot-local/io/mosip/kernel

# environment variable for jar version to be downloaed, this needed to be passed runtime
ENV version=1.1.4

# environment variable for maven central mosip artifacts 
ENV maven_path=https://repo1.maven.org/maven2/io/mosip

# environment variable for maven central auth adapter 
ENV auth_adapter_jar_url=${maven_path}/kernel/kernel-auth-adapter/${version}/kernel-auth-adapter-${version}.jar

# environment variable for msg91_jar url
ENV sms_msg91_url=${maven_path}/kernel/kernel-smsserviceprovider-msg91/${version}/kernel-smsserviceprovider-msg91-${version}.jar

# environment variable for ref-idobjectvalidator_jar url
ENV ref_idobjectvalidator_jar_url=${maven_path}/kernel/kernel-ref-idobjectvalidator/${version}/kernel-ref-idobjectvalidator-${version}.jar

# Create all the Jar paths
RUN mkdir -p ${biosdk_zip_path} ${cache_path} ${ida_sh_path} ${hsm_client_path} ${kernel_jar_path} ${test_jar_path} ${idobject_jar_path}

# Copy all the respective jars to the location

COPY /src/biosdk/biosdk.zip ${biosdk_zip_path}/

COPY /src/deployment/docker/id-authentication/* ${ida_sh_path}/

COPY /src/cache/cache-provider.jar ${cache_path}/

COPY /src/hsm/client.zip ${hsm_client_path}/

COPY /src/testing/regproc-reprocessor-ceylon-cache-repo.zip ${test_jar_path}/

COPY /src/testing/glowroot.zip ${test_jar_path}/

# Download required respective all the jars

RUN wget ${auth_adapter_jar_url} -O ${kernel_jar_path}/kernel-auth-adapter.jar  &&\ 
 wget ${sms_msg91_url} -O ${kernel_jar_path}/kernel-smsserviceprovider-msg91.jar  &&\
 wget ${ref_idobjectvalidator_jar_url} -O ${idobject_jar_path}/kernel-ref-idobjectvalidator.jar
