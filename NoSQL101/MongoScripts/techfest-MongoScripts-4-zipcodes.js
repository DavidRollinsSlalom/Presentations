
db.zipcodes.aggregate( { $group:
                         { _id: { state: "$state", city: "$city" }, // Group by City and State
                           pop: { $sum: "$pop" } } }, // Sum the population of the city
                       { $sort: { pop: 1 } },  // sort ascenging
                       { $group:
                         { _id : "$_id.state",  // Group our new City State Grouping by State
                           biggestCity:  { $last: "$_id.city" }, // Last records will be largest city
                           biggestPop:   { $last: "$pop" },
                           smallestCity: { $first: "$_id.city" }, // First Record will be smallest city
                           smallestPop:  { $first: "$pop" } } } )

