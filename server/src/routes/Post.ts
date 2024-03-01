import { Router } from 'express'
import Cover from '../libs/Cover';
import { create, get, star, remove } from '../controllers/post.controller';
const router =  Router();



router.post('/', Cover, create);
router.put('/', star);
router.get('/', get)
router.delete('/:id', remove);

export default router;


