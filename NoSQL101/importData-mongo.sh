mongoimport --db loot --collection zipcodes --file zips.json

// db.zipcodes.createIndex( { loc : "2dsphere" } )
