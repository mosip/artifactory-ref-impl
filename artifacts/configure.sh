#!/bin/bash

set -e

# This scripts performs multiple commands to set up the libraries inside the artifactory server docker.
# Activies performed are listed as below
# 1. biosdk-client zip creation
# 2. jpeg-sdk-lib zip creation
# 3. biosdk-lib zip ceation
# 4. demosdk-lib zip creation
# 5. Create resources zip for reg-client
# 6. Create i18n and entity-spec bundles zip files for all the required modules

echo biosdk client zip creation started
zip -r -j ${biosdk_client_zip_path}/biosdk-client.zip ${biosdk_client_zip_path}/biosdk-client/*
rm -rf ${biosdk_client_zip_path}/biosdk-client
echo biosdk client zip creation completed

echo jpeg-sdk-lib zip creation started
zip -r -j ${jpegsdk_lib_zip_path}/jpeg-sdk-lib.zip ${jpegsdk_lib_zip_path}/jpeg-sdk-lib/*
rm -rf ${jpegsdk_lib_zip_path}/jpeg-sdk-lib
echo jpeg-sdk-lib zip creation completed

echo biosdk-lib zip creation started
zip -r -j ${biosdk_lib_zip_path}/biosdk-lib.zip ${biosdk_lib_zip_path}/biosdk-lib/*
rm -rf ${biosdk_lib_zip_path}/biosdk-lib
echo biosdk-lib zip creation completed

echo demosdk-client zip creation started
zip -r -j ${demosdk_zip_path}/demosdk.zip ${demosdk_zip_path}/demosdk/*
rm -rf ${demosdk_zip_path}/demosdk
echo demosdk-client zip creation completed

echo esignet-wrappers zip creation started
zip -r -j ${esignet_wrapper_lib_zip_path}/esignet-wrapper.zip ${esignet_wrapper_lib_zip_path}/esignet-wrapper/*
rm -rf ${esignet_wrapper_lib_zip_path}/esignet-wrapper
echo esignet-wrapper zip creation completed

echo Creating resources.zip file for all the resources provided
zip -r -j ${base_path}/libs-release-local/reg-client/resources.zip ${work_dir}/resources
rm -rf ${work_dir}/resources
echo resources.zip creation sucessfull

echo spec-bundle zip creation started
zip -r -j ${i18n_zip_path}/admin-entity-spec-bundle.zip ${work_dir}/admin-entity-spec-bundle/*
zip -r -j ${i18n_zip_path}/pmp-entity-spec-bundle.zip ${work_dir}/pmp-entity-spec-bundle/*
rm -rf ${work_dir}/admin-entity-spec-bundle ${work_dir}/pmp-entity-spec-bundle
echo spec-bundle zip creation completed

echo i18n-bundles zip creation for all the mentioned modules started
zip -r -j ${i18n_zip_path}/admin-i18n-bundle.zip ${work_dir}/admin-i18n-bundle/* 
zip -r -j ${i18n_zip_path}/pmp-i18n-bundle.zip ${work_dir}/pmp-i18n-bundle/*
zip -r -j ${i18n_zip_path}/pre-registration-i18n-bundle.zip ${work_dir}/pre-registration-i18n-bundle/*
zip -r -j ${i18n_zip_path}/oidc-demo-i18n-bundle.zip ${work_dir}/oidc-demo-i18n-bundle/*
zip -r -j ${i18n_zip_path}/idp-i18n-bundle.zip ${work_dir}/idp-i18n-bundle/*
zip -r -j ${i18n_zip_path}/mock-relying-party-i18n-bundle.zip ${work_dir}/mock-relying-party-i18n-bundle/*
zip -r -j ${i18n_zip_path}/esignet-i18n-bundle.zip ${work_dir}/esignet-i18n-bundle/*

rm -rf ${work_dir}/admin-i18n-bundle ${work_dir}/pmp-i18n-bundle ${work_dir}/pre-registration-i18n-bundle ${work_dir}/oidc-demo-i18n-bundle ${work_dir}/idp-i18n-bundle
echo i18n-bundle zip creation completed

echo master-templates zip creation started
zip -r -j ${master_template_path}/master-templates.zip ${work_dir}/master-templates/*
echo master-templates zip creation completed
