#!/usr/bin/env python
import os, argparse, subprocess, tarfile, shutil, urllib2, sys

INDICES = []

ENVIRONMENTS = {"dev": "psl-devngscpdb01.lab.securustech.net",
                "qa-load": "qacdrsearch.lab.securustech.net",
                "qa": "psl-qangscpdb01.lab.securustech.net",
                "ci": "psl-devintcdr02.lab.securustech.net",
                "local":"localhost"}

PORT = "9200"

def composeURL(env, template):
    hostname = ENVIRONMENTS[env]
    uri = "http://" + hostname + ":" + PORT + "/" + template
    print "Elasticsearch URI : " + uri
    return uri

def composeURLWithoutTemplate(env):
    hostname = ENVIRONMENTS[env]
    uri = "http://" + hostname + ":" + PORT
    print "Elasticsearch URI : " + uri
    return uri

def printError():
    print("It appears you don't have ElasticDump installed on your computer.  This script requires ElasticDump.")
    print("You can get ElasticDump by running \"npm install elasticdump\".")


def extract(env):
    os.mkdir("dumps")
    for index in INDICES:
        url = composeURL(env, index)
        commandString = "elasticdump --maxSockets=1 --limit=" + speed + " --bulk=true --type=data --input=" + url + " --output=dumps/" + index + ".json"
        try:
            subprocess.call(commandString, shell=True)
        except OSError:
            printError()
    tar = tarfile.open(env + ".tar.gz", "w:gz")
    tar.add("dumps")
    tar.close()
    shutil.rmtree("dumps") 

def restore(env):
    data.extractall()
    for index in INDICES:
        url = composeURL(env, index)
        commandString =  "elasticdump --maxSockets=1 --limit=" + speed + " --bulk=true --type=data --output=" + url + " --input=dumps/" + index + ".json"
        try:
            subprocess.call(commandString, shell=True)
        except OSError:
            printError()
    shutil.rmtree("dumps")

def getindices(env):
    targetUrl = composeURLWithoutTemplate(env)
    indices = urllib2.urlopen(targetUrl + "/_cat/indices?v")
    lines = indices.readlines()
    for line in lines:
        linechunks = line.split( )
        if linechunks[2] != "index":
            INDICES.append(linechunks[2])

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Get a dump of the ElasticSearch environments for DEV, CI, QA, and QA-Load.")
    parser.add_argument("operation", metavar="operation", type=str, help="Backup or restore")
    parser.add_argument("environment", metavar="environment", type=str, help="The target environment")
    parser.add_argument("speed", metavar="speed", type=str, help="The speed of the elasticsearch dump between 100-9999", nargs="?", default="1000")
    parser.add_argument("data", metavar="data", type=str, help="The file containing backup data, must be in .tar.gz format.", nargs="?")
    args = parser.parse_args()
    environment = args.environment
    speed = args.speed

    if args.operation == "backup":
        getindices(environment)
        extract(environment)
    elif args.operation == "restore":
        if environment == "dev" or environment == "qa" or environment == "qa-load":
            print environment + " cannot be restored using this method."
            sys.exit()
        source = args.data.split(".")[0]
        getindices(source)
        data = tarfile.open(args.data, "r:gz")
        restore(environment)