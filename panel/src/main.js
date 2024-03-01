import { createApp } from 'vue'
import { library, config } from '@fortawesome/fontawesome-svg-core'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { far  } from '@fortawesome/free-regular-svg-icons'
import App from './App.vue'
import router from './router'
import axios from 'axios'

config.autoAddCss = true
library.add(fas)
library.add(fab)
library.add(far)

const app = createApp(App)


axios.defaults.withCredentials = true;

app.component("font-awesome-icon", FontAwesomeIcon)
app.use(router);
app.mount('#app')

