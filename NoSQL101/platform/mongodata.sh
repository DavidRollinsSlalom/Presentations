echo "Dumping dev environment mongo..."
mongodump --host psl-devngscpdb01.lab.securustech.net:27017 --db ngscp --username ngscp --password ngscp

mongo ngscp --eval "db.dropDatabase()"

echo "Restoring mongo to local"
mongorestore

mongo ngscp --eval "db.xdr_import_cache.drop()"