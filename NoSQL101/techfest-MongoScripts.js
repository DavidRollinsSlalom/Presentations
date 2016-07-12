
db.products.drop();


-----------------------------


db.products.insert( { item: "card", qty: 15 } );

db.products.findOne();

-----------------------------

db.products.update(
   { item: "card", },
   {
      item: "card",
      qty: 14,
      ranking: 1
   },
   { upsert: true }
   );

db.products.find();

-----------------------------



db.zipcodes.findOne()


-----------------------------

db.zipcodes.createIndex( { loc : "2dsphere" } )


-----------------------------


/*
Giley's Dallas
32.768777   ,    -96.79798699999998
*/

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

/*
This to aggregation -->

SELECT state, SUM(pop) AS totalPop
       FROM zipcodes
       GROUP BY state
       HAVING totalPop >= (10*1000*1000)
*/



---------------------------------


db.zipcodes.aggregate( { $group :
                         { _id : "$state",
                           totalPop : { $sum : "$pop" } } },
                       { $match : {totalPop : { $gte : 10*1000*1000 } } } )

-----------------


db.zipcodes.aggregate( { $group:
                         { _id: { state: "$state", city: "$city" },
                           pop: { $sum: "$pop" } } },
                       { $sort: { pop: 1 } },
                       { $group:
                         { _id : "$_id.state",
                           biggestCity:  { $last: "$_id.city" },
                           biggestPop:   { $last: "$pop" },
                           smallestCity: { $first: "$_id.city" },
                           smallestPop:  { $first: "$pop" } } } )


-----------------


db.zipcodes.aggregate( { $group:
                         { _id: { state: "$state", city: "$city" },
                           pop: { $sum: "$pop" } } },
                       { $sort: { pop: 1 } },
                       { $group:
                         { _id : "$_id.state",
                           biggestCity:  { $last: "$_id.city" },
                           biggestPop:   { $last: "$pop" },
                           smallestCity: { $first: "$_id.city" },
                           smallestPop:  { $first: "$pop" } } },

                       // the following $project is optional, and
                       // modifies the output format.

                       { $project:
                         { _id: 0,
                           state: "$_id",
                           biggestCity:  { name: "$biggestCity",  pop: "$biggestPop" },
                           smallestCity: { name: "$smallestCity", pop: "$smallestPop" } } } )

-----------------
