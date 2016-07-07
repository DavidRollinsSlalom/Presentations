db.zipcodes.findOne()


-----------------------------


/*
Giley's Dallas
32.768777   ,    -96.79798699999998
*/

db.zipcodes.find()

db.zipcodes.find(
   {
     loc:
       { $near :
          {
            $geometry: { type: "Point",  coordinates: [ -96.7979, 32.768 ] },
            $maxDistance: 25 * 1609.3  // miles to meters
          }
       }
   }
)

//.sort( { pop: -1 } )
//.size()
