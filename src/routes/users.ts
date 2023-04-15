import express from 'express';
const router = express.Router();

/* GET users listing. */
router.get('/', function (req: any, res: any, next: any) {
  res.send('user route calling!!');
});

export default router;
