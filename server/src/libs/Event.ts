import multer from 'multer'
import { v4 as uuidv4 } from 'uuid';
import path from 'path'


const storage = multer.diskStorage({
    destination: path.join(__dirname, '../../public/optimize/'),
    filename: (req, file, cb) => {
        cb(null, `${uuidv4()}${path.extname(file.originalname)}` )
    }
})



export default multer( {
    storage,
    dest: path.join(__dirname, '../../public/optimize/')
} ).single('image')


