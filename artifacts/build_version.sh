#!/bin/sh

version=1.2.0.1-SNAPSHOT
idp_auth_wrapper_version=0.9.0-SNAPSHOT

echo Script to fetch the timestamp for each required snapshot artifactory

echo timestamp for auth adapter.

curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/kernel/kernel-auth-adapter/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p'

echo timestamp for msg91 sms jar

curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/kernel/kernel-smsserviceprovider-msg91/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p'

echo timestamp for ref-idobjectvalidator jar

curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/kernel/kernel-ref-idobjectvalidator/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p'

echo timestamp for virus scanner jar 

curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/kernel/kernel-virusscanner-clamav/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p'

echo timestamp for mock-sdk jar

curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/mock/sdk/mock-sdk/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p'

echo timestamp for  biosdk client jar

curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/biosdk/biosdk-client/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p'

echo timestamp for  demosdk client jar

curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/demosdk/demosdk/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p'

echo timestamp for  child auth filter jar

curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/authentication/authentication-childauthfilter-impl/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p'

echo timestamp for IDP auth wrapper jar

curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/idp/authentication-wrapper/${idp_auth_wrapper_version}/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p'