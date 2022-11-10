#!/bin/sh

set -e

# Download the jar for auth adapter from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${kernel_jar_path}/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.kernel:kernel-auth-adapter:${version}

cd ${kernel_jar_path} && mv kernel-auth-adapter-*.jar kernel-auth-adapter.jar

echo "Downloaded and renamed auth-adapter jar"

# Download the jar for sms-msg91 gateway from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${kernel_jar_path}/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.kernel:kernel-smsserviceprovider-msg91:${version}

cd ${kernel_jar_path} && mv kernel-smsserviceprovider-msg91-*.jar kernel-smsserviceprovider-msg91.jar

echo "Downloaded and renamed msg-91 jar"

# Download the jar for ref-idobjectvalidator from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${idobject_jar_path}/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.kernel:kernel-ref-idobjectvalidator:${version}

cd ${idobject_jar_path} && mv kernel-ref-idobjectvalidator-*.jar kernel-ref-idobjectvalidator.jar

echo "Downloaded and renamed idobjectvalidator jar"

# Download the mock-sdk jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${sdk_path}/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.mock.sdk:mock-sdk:1.2.0

cd ${sdk_path} && mv mock-sdk-*.jar mock-sdk.jar

echo "Downloaded and renamed mock-sdk jar"

# Download the Clamav Jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${clamav_path}/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.kernel:kernel-virusscanner-clamav:${version}

cd ${clamav_path} && mv kernel-virusscanner-clamav-*.jar kernel-virusscanner-clamav.jar

echo "Downloaded and renamed kernel-virusscanner jar"

# Download the Clamav client Jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${clamav_path}/ -Dartifact=xyz.capybara:clamav-client:1.0.4

cd ${clamav_path} && mv clamav-client-*.jar clamav.jar

echo "Downloaded and renamed clamav client jar"

# Download the Biosdk client Jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${biosdk_client_zip_path}/biosdk-client/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.biosdk:biosdk-client:${version}:jar:jar-with-dependencies

zip -r -j ${biosdk_client_zip_path}/biosdk-client.zip ${biosdk_client_zip_path}/biosdk-client/*

echo "zip creation completed for biosdk" 

rm -rf ${biosdk_client_zip_path}/biosdk-client

echo "folder biosdk client deleted"

# Download jpeg Mock-sdk-jar from maven repository and rename to remove the version no:
mvn dependency:get -Ddest=${jpeg_sdk_path}/mock-sdk-jpeg-extractor.jar -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.mock.sdk:mock-sdk-jpeg-extractor:${version}:jar:jar-with-dependencies
echo "Downloaded mock-sdk-jpeg-extractor.jar"

# Download the jpeg extractor Jar from maven repository and rename to remove the version no:
mvn dependency:get -Ddest=${jpegsdk_lib_zip_path}/jpeg-sdk-lib/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.mock.sdk:mock-sdk:${version}
mvn dependency:get -Ddest=${jpegsdk_lib_zip_path}/jpeg-sdk-lib/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.mock.sdk:mock-sdk-jpeg-extractor:${version}:jar:jar-with-dependencies
zip -r -j ${jpegsdk_lib_zip_path}/jpeg-sdk-lib.zip ${jpegsdk_lib_zip_path}/jpeg-sdk-lib/*
echo "zip creation completed for jpegsdk"
rm -rf ${jpegsdk_lib_zip_path}/jpeg-sdk-lib
echo "folder 'jpeg-sdk-lib' client deleted"

# Download the mock-sdk jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${biosdk_lib_zip_path}/biosdk-lib/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.mock.sdk:mock-sdk:${version}
mvn dependency:get -Ddest=${biosdk_lib_zip_path}/biosdk-lib/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.mock.sdk:mock-sdk:${version}:jar:jar-with-dependencies

zip -r -j ${biosdk_lib_zip_path}/biosdk-lib.zip ${biosdk_lib_zip_path}/biosdk-lib/*

rm -rf ${biosdk_lib_zip_path}/biosdk-lib

echo "biosdk lib zip created"

# Download the Demosdk client Jar from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${demosdk_zip_path}/demosdk/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.demosdk:demosdk:${version}:jar:jar-with-dependencies

zip -r -j ${demosdk_zip_path}/demosdk.zip ${demosdk_zip_path}/demosdk/*

rm -rf ${demosdk_zip_path}/demosdk

echo "zip creation completed"

# Download the jar for child-auth-filter from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${child_auth_filter_jar_path}/ -DremoteRepositories=sonatype-nexus-snapshots::::https://oss.sonatype.org/content/repositories/snapshots -Dartifact=io.mosip.authentication:authentication-childauthfilter-impl:${version}

cd ${child_auth_filter_jar_path} && mv authentication-childauthfilter-impl*.jar authentication-childauthfilter-impl.jar

echo "Downloaded Child Auth Filter Jar"

# Download the cache jar for hazlecast from maven repository and rename to remove the version no:

mvn dependency:get -Ddest=${cache_path}/ -Dartifact=com.hazelcast:hazelcast-all:3.12.12

cd ${cache_path}/ && mv hazelcast-all-3.12.12.jar cache-provider.jar

echo "Downloaded hazlecast cache jar"
