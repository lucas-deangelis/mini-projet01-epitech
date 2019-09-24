//routes.js

import HomeComponent from './components/HomeComponent.vue';
import TeamComponent from './components/TeamComponent.vue';
import AdminComponent from './components/AdminComponent.vue';

const routes = [
    { path: '/', component: HomeComponent },
    { path: '/team', component: TeamComponent },
    { path: '/users', component: AdminComponent }
];

export default routes;