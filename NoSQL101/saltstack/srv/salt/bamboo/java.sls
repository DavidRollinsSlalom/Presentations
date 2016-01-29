# NB. we install maven via salt instead of EPEL to avoid an incompatibility between EPEL maven version output and what Bamboo agent expects

# For ant, we use salt formulas so that we can make sure mail.jar and activation.jar are installed properly

include:
   - java.oracle-jdk-8
   - java.oracle-jdk-7
   - java.oracle-jdk-6
   - bamboo.maven
   - bamboo.ant
   - bamboo.gradle

