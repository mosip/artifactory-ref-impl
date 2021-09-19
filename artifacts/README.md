# artifactory-ref-impl

The build.sh script present here performs below mentioned changes in the Dockerfile:
* Checks if the changes are for release or snapshot maven repository.
* Gets the updated updated build no and jar URL for all the required jars from metadat xml.
* Replaces the correct build version for all the jars so that it can be downloaded without failure.
* Manages switch between the Release and Snapshot URL as per the version.
* Also the actions will not be triggered if the source branch is automated-updates.

Key points in the Dockerfile are:
* Rversion: is supposed to be the value of release version. (without SNAPSHOT)
* Sversion: is supposed to be the value of the Snapshot version to be used prior to release.

Key points in the build.sh script:
* version here will be used to get the latest build no and jar metadata required for updating latest snapshot URL from Metadata.xml.

Note:
	```We also have added an action for generating automated PR's once the changes are pushed or the action is rerun. This github action executes the build.sh script, commits the changes done in the URL and than creates an automated PR for the same.```

### Changes to be done for only updating the latest version:
* Update the latest version required in build.sh script as per the definations mentioned avove.
* Update the Rversion and Sversion in the Dockerfile.
* Once above changes are done commit and raise a PR for the same. At the End of Create PR action get this reviewed and merged by Repo owner.
* If required versions changes are already done just rerun the last sucessfull action.

