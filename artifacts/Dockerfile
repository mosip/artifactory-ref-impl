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
useradd -u ${container_user_uid} -g ${container_user_group} -s /bin/sh -m ${container_user} \
&& mkdir -p /var/run/nginx /var/tmp/nginx \
&& chown -R ${container_user}:${container_user} /usr/share/nginx /var/run/nginx /var/tmp/nginx

COPY ./nginx.conf /etc/nginx/nginx.conf

# set working directory for the user
WORKDIR /home/${container_user}

# environment variable for basepath
ENV base_path=/usr/share/nginx/html/artifactory

# environment variable for Biosdk Zip path
ENV biosdk_client_zip_path=${base_path}/libs-release-local/biosdk/mock/0.9

# environment variable for Biosdk Zip path
ENV biosdk_lib_zip_path=${base_path}/libs-release-local/biosdk/

# environment variable for Cache Provider Jar path
ENV cache_path=${base_path}/libs-release-local/cache

# environment variable for ida shell scripts path
ENV ida_sh_path=${base_path}/libs-release-local/deployment/docker/id-authentication

# environment variable for hsm client path
ENV hsm_client_path=${base_path}/libs-release-local/hsm

# environment valiable for sdk jar
ENV sdk_path=${base_path}/libs-release-local/mock-sdk/1.1.5/

# environment variable for Kernel Jars
ENV kernel_jar_path=${base_path}/libs-release-local/io/mosip/kernel

# environment variable for regproc reprocessor ceylon cache jar path
ENV test_jar_path=${base_path}/libs-release-local/io/mosip/testing/

# environment variable for ref-idobjectvalidator jar
ENV idobject_jar_path=${base_path}/libs-snapshot-local/io/mosip/kernel/kernel-ref-idobjectvalidator

# environment variable for regproc auth jar
ENV regproc_jar_path=${base_path}/libs-snapshot-local/io/mosip/kernel/kernel-auth-adapter

# environment variable for prereg transliteration jar path
ENV icu4j_jar_path=${base_path}/libs-release-local/icu4j

# environment variable for i18n zip path
ENV i18n_zip_path=${base_path}/libs-release-local/i18n

# environment variable for Clamav dependency
ENV clamav_path=${base_path}/libs-release-local/clamav

# environment variable for jar version to be downloaed, this needed to be passed buildtime
ENV version=1.1.5

# environment variable for maven central mosip artifacts 
ENV release_maven_path=https://repo1.maven.org/maven2/io/mosip

# environment variable for maven central auth adapter. In case released uncomment this and comment out below duplicate one.
ENV auth_adapter_jar_url_env=${release_maven_path}/kernel/kernel-auth-adapter/${version}/kernel-auth-adapter-${version}.jar
#ENV auth_adapter_jar_url_env=https://oss.sonatype.org/service/local/repositories/snapshots/content/io/mosip/kernel/kernel-auth-adapter/1.2.0-SNAPSHOT/kernel-auth-adapter-1.2.0-20210506.100518-217.jar

# environment variable for msg91_jar url. 
ENV sms_msg91_jar_url_env=${release_maven_path}/kernel/kernel-smsserviceprovider-msg91/${version}/kernel-smsserviceprovider-msg91-${version}.jar
#ENV sms_msg91_jar_url_env=https://oss.sonatype.org/service/local/repositories/releases/content/io/mosip/kernel/kernel-smsserviceprovider-msg91/1.1.5-rc1/kernel-smsserviceprovider-msg91-1.1.5-rc1.jar

# environment variable for ref-idobjectvalidator_jar url
ENV ref_idobjectvalidator_jar_url_env=${release_maven_path}/kernel/kernel-ref-idobjectvalidator/${version}/kernel-ref-idobjectvalidator-${version}.jar
#ENV ref_idobjectvalidator_jar_url_env=https://oss.sonatype.org/service/local/repositories/snapshots/content/io/mosip/kernel/kernel-ref-idobjectvalidator/1.2.0-SNAPSHOT/kernel-ref-idobjectvalidator-1.2.0-20210506.093618-236.jar

# environment variable for clamav jar and client url
ENV clamav_jar_url_env=${release_maven_path}/kernel/kernel-virusscanner-clamav/${version}/kernel-virusscanner-clamav-${version}.jar
#ENV clamav_jar_url_env=https://oss.sonatype.org/service/local/repositories/snapshots/content/io/mosip/kernel/kernel-virusscanner-clamav/1.2.0-SNAPSHOT/kernel-virusscanner-clamav-1.2.0-20210506.093621-303.jar

ENV clamav_client_url_env=https://oss.sonatype.org/service/local/repositories/releases/content/xyz/capybara/clamav-client/1.0.4/clamav-client-1.0.4.jar

# environment variable for sdk url
ENV sdk_jar_url_env=${release_maven_path}/mock/sdk/mock-sdk/${version}/mock-sdk-${version}.jar

# environment variable for cache URL 
ENV cache_url_env=https://repo1.maven.org/maven2/com/hazelcast/hazelcast-all/3.12.12/hazelcast-all-3.12.12.jar

# environment variable for cache URL
ENV biosdk_client_url_env=https://oss.sonatype.org/service/local/repositories/snapshots/content/io/mosip/biosdk/biosdk-client/1.2.0-SNAPSHOT/biosdk-client-1.2.0-20210709.080850-194-jar-with-dependencies.jar

# Create all the Jar paths
RUN mkdir -p ${biosdk_client_zip_path}/biosdk-client ${biosdk_lib_zip_path}/biosdk-lib ${cache_path} ${ida_sh_path} ${hsm_client_path} ${kernel_jar_path} ${test_jar_path} ${idobject_jar_path} ${regproc_jar_path} ${sdk_path} ${icu4j_jar_path} ${clamav_path}

# Copy all the respective jars to the location

COPY /src/biosdk/install.sh ${biosdk_client_zip_path}/biosdk-client/

COPY /src/deployment/docker/id-authentication/* ${ida_sh_path}/

COPY /src/hsm/client.zip ${hsm_client_path}/

COPY /src/testing/regproc-reprocessor-ceylon-cache-repo.zip ${test_jar_path}/

COPY /src/testing/glowroot.zip ${test_jar_path}/

COPY /src/i18n/pre-registration-i18n-bundle.zip ${i18n_zip_path}/

COPY /src/i18n/admin-entity-spec-bundle.zip ${i18n_zip_path}/

COPY /src/i18n/admin-i18n-bundle.zip ${i18n_zip_path}/

COPY /src/icu4j/* ${icu4j_jar_path}/

COPY /src/auth/* ${regproc_jar_path}/

# Download required respective all the jars and create biosdk zip

RUN wget ${auth_adapter_jar_url_env} -O ${kernel_jar_path}/kernel-auth-adapter.jar  &&\

echo "Downloaded auth adapter jar" &&\

wget ${sms_msg91_jar_url_env} -O ${kernel_jar_path}/kernel-smsserviceprovider-msg91.jar  &&\

echo "Downloaded msg91 jar" &&\

wget ${ref_idobjectvalidator_jar_url_env} -O ${idobject_jar_path}/kernel-ref-idobjectvalidator.jar &&\

echo "Downloaded idobjectvalidator jar" &&\

wget ${cache_url_env} -O ${cache_path}/cache-provider.jar &&\

echo "Downloaded hazlecast cache jar" &&\

wget ${sdk_jar_url_env} -O ${sdk_path}/mock-sdk.jar &&\

echo "Downloaded Mock-sdk-jar" &&\

wget ${clamav_jar_url_env} -O ${clamav_path}/kernel-virusscanner-clamav.jar &&\

echo "Downloaded ClamAV jar" &&\

wget ${clamav_client_url_env} -O ${clamav_path}/clamav.jar &&\

echo "Downloaded ClamAV client" &&\

wget ${biosdk_client_url_env} -P ${biosdk_client_zip_path}/biosdk-client/ &&\

echo "Downloaded biosdk client creating the zip" &&\

zip -r -j ${biosdk_client_zip_path}/biosdk-client.zip ${biosdk_client_zip_path}/biosdk-client/* &&\

echo "zip creation completed" &&\

rm -rf ${biosdk_client_zip_path}/biosdk-client &&\

echo "folder biosdk client deleted" &&\

wget ${sdk_jar_url_env} -P ${biosdk_lib_zip_path}/biosdk-lib/ &&\

zip -r -j ${biosdk_lib_zip_path}/biosdk-lib.zip ${biosdk_lib_zip_path}/biosdk-lib/* &&\

rm -rf ${biosdk_lib_zip_path}/biosdk-lib &&\

echo "biosdk lib zip created"

RUN sed -i -e '/listen/!b' -e '/80;/!b' -e 's/80;/8080;/' /etc/nginx/conf.d/default.conf

# select container user for all tasks
USER ${container_user_uid}:${container_user_gid}

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
