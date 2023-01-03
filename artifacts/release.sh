#!/bin/sh

set -e

# Download the jar for auth adapter from maven repository and rename for 1.2.0.1-B2:

mvn dependency:get -Ddest=${kernel_jar_path}/ -Dartifact=io.mosip.kernel:kernel-auth-adapter:${version}

cd ${kernel_jar_path} && mv kernel-auth-adapter-*.jar kernel-auth-adapter.jar

echo "Downloaded and renamed auth-adapter jar for 1.2.0.1-B2"

# Download the jar for auth adapter from maven repository and rename for 1.2.0.1-B1:

mvn dependency:get -Ddest=${kernel_jar_path}/1.2.0.1-B1 -Dartifact=io.mosip.kernel:kernel-auth-adapter:1.2.0.1-B1

cd ${kernel_jar_path}/1.2.0.1-B1 && mv kernel-auth-adapter-*.jar kernel-auth-adapter.jar

echo "Downloaded and renamed auth-adapter jar for 1.2.0.1-B1"


# Download the jar for sms-msg91 gateway from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${kernel_jar_path}/ -Dartifact=io.mosip.kernel:kernel-smsserviceprovider-msg91:${version}

cd ${kernel_jar_path} && mv kernel-smsserviceprovider-msg91-*.jar kernel-smsserviceprovider-msg91.jar

echo "Downloaded and renamed msg-91 jar"

# Download the jar for ref-idobjectvalidator from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${idobject_jar_path}/ -Dartifact=io.mosip.kernel:kernel-ref-idobjectvalidator:${version}

cd ${idobject_jar_path} && mv kernel-ref-idobjectvalidator-*.jar kernel-ref-idobjectvalidator.jar

echo "Downloaded and renamed idobjectvalidator jar"

# Download the mock-sdk jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${sdk_path}/ -Dartifact=io.mosip.mock.sdk:mock-sdk:${version}

cd ${sdk_path} && mv mock-sdk-*.jar mock-sdk.jar

echo "Downloaded and renamed mock-sdk jar"

# Download the Clamav Jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${clamav_path}/ -Dartifact=io.mosip.kernel:kernel-virusscanner-clamav:${version}

cd ${clamav_path} && mv kernel-virusscanner-clamav-*.jar kernel-virusscanner-clamav.jar

echo "Downloaded and renamed kernel-virusscanner jar"

# Download the Clamav client Jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${clamav_path} -Dartifact=xyz.capybara:clamav-client:1.0.4

cd ${clamav_path} && mv clamav-client-*.jar clamav-client.jar

echo "Downloaded and renamed clamav client jar"

# Download the Biosdk client Jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${biosdk_client_zip_path}/biosdk-client/ -Dartifact=io.mosip.biosdk:biosdk-client:${version}:jar:jar-with-dependencies

zip -r -j ${biosdk_client_zip_path}/biosdk-client.zip ${biosdk_client_zip_path}/biosdk-client/*

echo "zip creation completed for biosdk" 

rm -rf ${biosdk_client_zip_path}/biosdk-client

echo "folder biosdk client deleted"

# Download the mock-sdk jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${biosdk_lib_zip_path}/biosdk-lib/ -Dartifact=io.mosip.mock.sdk:mock-sdk:${version}
mvn dependency:get -Ddest=${biosdk_lib_zip_path}/biosdk-lib/ -Dartifact=io.mosip.mock.sdk:mock-sdk:${version}:jar:jar-with-dependencies

zip -r -j ${biosdk_lib_zip_path}/biosdk-lib.zip ${biosdk_lib_zip_path}/biosdk-lib/*

rm -rf ${biosdk_lib_zip_path}/biosdk-lib

echo "biosdk lib zip created"

# Download the Demosdk client Jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${demosdk_zip_path}/demosdk/ -Dartifact=io.mosip.demosdk:demosdk:${version}:jar:jar-with-dependencies

zip -r -j ${demosdk_zip_path}/demosdk.zip ${demosdk_zip_path}/demosdk/*

rm -rf ${demosdk_zip_path}/demosdk

echo "zip creation completed"

# Download the jar for child-auth-filter from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${child_auth_filter_jar_path}/ -Dartifact=io.mosip.authentication:authentication-childauthfilter-impl:${version}

cd ${child_auth_filter_jar_path} && mv authentication-childauthfilter-impl*.jar authentication-childauthfilter-impl.jar

echo "Downloaded Child Auth Filter Jar"

# Download the cache jar for hazlecast from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${cache_path}/ -Dartifact=com.hazelcast:hazelcast-all:3.12.12

cd ${cache_path}/ && mv hazelcast-all-3.12.12.jar cache-provider.jar

echo "Downloaded hazlecast cache jar"

# Download the jar for idp auth wrapper from maven repository

mvn dependency:get -Ddest=${idp_auth_wrapper_lib_zip_path}/ -Dartifact=io.mosip.idp:authentication-wrapper:${idp_auth_wrapper_version}

cd ${idp_auth_wrapper_lib_zip_path} && mv authentication-wrapper-*.jar authentication-wrapper.jar

echo "Downloaded idp authentication wrapper"