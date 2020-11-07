import * as functions from 'firebase-functions';
import { Drink } from './Entities/Drink';
import { Food } from './Entities/Food';
import { Order } from './Entities/Order';
import { Table } from './Entities/Table';
import { Repository } from './repository';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// const admin = require('firebase-admin');
// admin.initializeApp();

const express = require('express');
const cors = require('cors');
const router = express.Router();

const app = express();
app.use(express.json({
  strict: true,
  type: 'application/json'
}));

app.use(cors({ origin: true }));
  
router.post('/addDrink', (req: any, res: any) => {
  var drinks : Drink = req.body
  Repository.createDrink(drinks)
    .then(r=>res.send("created"))
})
router.post('/addDrinks', (req: any, res: any) => {
  var drinks : Drink[] = req.body
  Repository.createDrinks(drinks)
    .then(r=>res.send("created"))
})
router.post('/addFood', (req: any, res: any) => {
  var drinks : Food = req.body
  Repository.createFood(drinks)
    .then(r=>res.send(r))
})
router.post('/addFoods', (req: any, res: any) => {
  var drinks : Food[] = req.body
  Repository.createFoods(drinks)
    .then(r=>res.send(r))
})
router.post('/addTable', (req: any, res: any) => {
  var drinks : Table = req.body
  Repository.createTable(drinks)
    .then(r=>res.send(r))
})
router.post('/addTables', (req: any, res: any) => {
  var drinks : Table[] = req.body
  Repository.createTables(drinks)
    .then(r=>res.send(r))
})
router.post('/createOrder', (req: any, res: any) => {
  functions.logger.info("called create Order")
  var drinks : Order = req.body
  Repository.createOrder(drinks)
    .then(r=>res.send(r))
})

router.get('/getFoods', (req: any, res: any) => {
  Repository.getFoods()
    .then(data => res.send(data))
})
router.get('/getDrinks', (req: any, res: any) => {
  Repository.getDrinks()
    .then(data => res.send(data))
})
router.get('/getTables', (req: any, res: any) => {
  Repository.getTables()
    .then(data => res.send(data))
})
router.get('/getOrders', (req: any, res: any) => {
  Repository.getAllOrders()
    .then(data => res.send(data))
})
router.get('/test', (req: any, res: any) => {
  res.send( "hello darling")
})

app.use('/', router)

exports.rest = functions.https.onRequest(app);