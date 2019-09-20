//routes.js

import HomeComponent from './components/HomeComponent.vue';
import TeamComponent from './components/TeamComponent.vue';

const routes = [
    { path: '/', component: HomeComponent },
    { path: '/team', component: TeamComponent }
];

export default routes;