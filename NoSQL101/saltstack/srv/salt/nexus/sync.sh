#!/bin/sh

rsync -avz --progress -e ssh es-compile01.emcent.scn.securustech.net:/opt/sonatype-work/nexus/ /opt/nexus/sonatype-work/nexus/

