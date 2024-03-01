import { Router } from 'express'
import Event from '../libs/Event';
import { create , get, remove} from '../controllers/event.controller';

const router =  Router();



router.post('/', Event, create);
router.get('/', get);
router.delete("/:id", remove)

export default router;


