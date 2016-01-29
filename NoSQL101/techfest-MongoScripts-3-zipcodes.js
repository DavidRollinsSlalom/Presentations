/*
SELECT state, SUM(pop) AS totalPop
       FROM zipcodes
       GROUP BY state
       HAVING totalPop >= (10*1000*1000)
*/


db.zipcodes.aggregate( { $group :
                         { _id : "$state",    // Group by State
                           totalPop : { $sum : "$pop" } } },  // Return the sum of that state's population
                       { $match : {totalPop : { $gte : 10*1000*1000 } } } ) // Filter by state population > 1 million

