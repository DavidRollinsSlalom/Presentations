db.products.drop();


//-----------------------------


db.products.insert( { item: "card", qty: 15 } );

db.products.findOne({ item: "card", });

//-----------------------------

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
