import * as functions from 'firebase-functions';
import { Drink } from './Entities/Drink';
import { Food } from './Entities/Food';
import { Order } from './Entities/Order';
import { Restaurant } from './Entities/Restaurant';
import { Table } from './Entities/Table';
import { Repository } from './repository';

const express = require('express');
const cors = require('cors');
const router = express.Router();

const app = express();
app.use(express.json({
  strict: true,
  type: 'application/json'
}));

app.use(cors({ origin: true }));
router.post('/:restaurant/setOrderDone', (req: any, res: any) => {
  var drinks : Order = req.body
  Repository.setOrderDone(drinks, req.params.restaurant)
    .then(r=>res.send(r))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.post('/:restaurant/addDrink', (req: any, res: any) => {
  var drinks : Drink = req.body
  Repository.createDrink(drinks, req.params.restaurant)
    .then(r=>res.send("created"))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.post('/addRestaurant', (req: any, res: any) => {
  var rest : Restaurant = req.body
  Repository.createRestaurant(rest)
    .then(r=>res.send(r))
})
router.post('/:restaurant/addDrinks', (req: any, res: any) => {
  var drinks : Drink[] = req.body
  Repository.createDrinks(drinks, req.params.restaurant)
    .then(r=>res.send("created"))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.post('/:restaurant/addFood', (req: any, res: any) => {
  var drinks : Food = req.body
  Repository.createFood(drinks, req.params.restaurant)
    .then(r=>res.send(r))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.post('/:restaurant/addFoods', (req: any, res: any) => {
  var drinks : Food[] = req.body
  Repository.createFoods(drinks, req.params.restaurant)
    .then(r=>res.send(r))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.post('/:restaurant/addTable', (req: any, res: any) => {
  var drinks : Table = req.body
  Repository.createTable(drinks, req.params.restaurant)
    .then(r=>res.send(r))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.post('/:restaurant/addTables', (req: any, res: any) => {
  var drinks : Table[] = req.body
  Repository.createTables(drinks, req.params.restaurant)
    .then(r=>res.send(r))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.post('/:restaurant/createOrder', (req: any, res: any) => {
  var orders : Order = req.body
  Repository.createOrder(orders, req.params.restaurant)
    .then(r=>res.send(r))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})

router.get('/:restaurant/getFoods', (req: any, res: any) => {
  functions.logger.info("called getRestaurant" +req.params.restaurant)
  Repository.getFoods( req.params.restaurant)
    .then(data => res.send(data))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.get('/:restaurant/getDrinks', (req: any, res: any) => {
  Repository.getDrinks( req.params.restaurant)
    .then(data => res.send(data))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.get('/:restaurant/getTables', (req: any, res: any) => {
  Repository.getTables( req.params.restaurant)
    .then(data => res.send(data))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.get('/:restaurant/getOrders', (req: any, res: any) => {
  Repository.getAllOrders(req.params.restaurant)
    .then(data => res.send(data))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.get('/:restaurant', (req: any, res: any) => {
  Repository.restaurantExists(req.params.restaurant)
    .then(data => res.send(data))
    .catch(error => {
      res.status(500)
      res.send(error.message)
    })
})
router.get('/test', (req: any, res: any) => {
  res.send( "hello darling")
})

app.use('/', router)

exports.rest = functions.https.onRequest(app);