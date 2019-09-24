//routes.js

import HomeComponent from './components/HomeComponent.vue';
import TeamComponent from './components/TeamComponent.vue';
import AdminComponent from './components/AdminComponent.vue';
import LoginComponent from './components/Login.vue';
import RegisterComponent from './components/RegisterComponent.vue';

const routes = [
    { path: '/', component: HomeComponent },
    { path: '/team', component: TeamComponent },
    { path: '/users', component: AdminComponent },
    { path: '/login', component: LoginComponent },
    { path: '/register', component: RegisterComponent }
];

export default routes;