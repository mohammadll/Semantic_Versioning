# Semantic_Versioning of artifacts built with maven (CI goals of Jenkins pipeline)
This is a great guide to automate the versioning process of artifacts built with maven for CI Goals of jenkins pipeline . Imagine that we want to replace the question mark with a version number without any manual change from us like this: mvn clean deploy -Drevision=?

Semantic Versioning Works like this: 
(example: 1.0.0)

Given a version number MAJOR.MINOR.PATCH, increment the:

MAJOR version when you make incompatible API changes,

MINOR version when you add functionality in a backwards compatible manner,

PATCH version when you make backwards compatible bug fixes.


...................... This bash script reads the last commit message and the last Tag , then:
 
1. If the last commit message contains the word "CHANGE:" it adds a number to the MAJOR and resets MINOR and PATCH to zero like this: 1.2.1 ...> 2.0.0

2.  If the last commit message contains the word "feat:" it adds a number to the MINOR and resets PATCH to zero like this: 1.2.1 ...> 1.3.0

3.  If the last commit message contains the word "fix:" it adds a number to the PATCH like this: 1.2.1 ...> 1.2.2


Finally, based on your policies, the artifact can be deployed to a repo manager like nexus and the new revision number can be released as a new tag with maven-scm-plugin:tag
