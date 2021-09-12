#!/bin/sh

version=1.2.0-SNAPSHOT

echo Script to fetch the timestamp for each required snapshot artifactory

echo timestamp for auth adapter.

a=$(curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/kernel/kernel-auth-adapter/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p')

sed -i "s/kernel-auth-adapter-.*.jar/kernel-auth-adapter-$a.jar/g" Dockerfile

echo $a

echo timestamp for msg91 sms jar

a=$(curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/kernel/kernel-smsserviceprovider-msg91/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p')

sed -i "s/kernel-smsserviceprovider-msg91-.*.jar/kernel-smsserviceprovider-msg91-$a.jar/g" Dockerfile

echo $a

echo timestamp for ref-idobjectvalidator jar

a=$(curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/kernel/kernel-ref-idobjectvalidator/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p')

echo $a

sed -i "s/kernel-ref-idobjectvalidator-.*.jar/kernel-ref-idobjectvalidator-$a.jar/g" Dockerfile

echo timestamp for virus scanner jar 

a=$(curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/kernel/kernel-virusscanner-clamav/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p')

echo $a

sed -i "s/kernel-virusscanner-clamav-.*.jar/kernel-virusscanner-clamav-$a.jar/g" Dockerfile

echo timestamp for mock-sdk jar

a=$(curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/mock/sdk/mock-sdk/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p')

echo $a

sed -i "s/mock-sdk-.*.jar/mock-sdk-$a.jar/g" Dockerfile

echo timestamp for  biosdk client jar

a=$(curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/biosdk/biosdk-client/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p')

echo $a

sed -i "s/biosdk-client-.*-jar-with/biosdk-client-$a-jar-with/g" Dockerfile

echo timestamp for  demosdk client jar

a=$(curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/demosdk/demosdk-client/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p')

echo $a

sed -i "s/demosdk-client-.*-jar-with/demosdk-client-$a-jar-with/g" Dockerfile

echo timestamp for  child auth filter jar

a=$(curl -s https://oss.sonatype.org/content/repositories/snapshots/io/mosip/authentication/authentication-childauthfilter-impl/$version/maven-metadata.xml | grep value | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/" | sed -n '1p')

echo $a

sed -i "s/childauthfilter-impl-.*.jar/childauthfilter-impl-$a.jar/g" Dockerfile
