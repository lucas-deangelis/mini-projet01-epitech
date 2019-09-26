//routes.js

import HomeComponent from './components/HomeComponent.vue';
import TeamComponent from './components/TeamComponent.vue';
import AdminComponent from './components/AdminComponent.vue';
import LoginComponent from './components/LoginComponent.vue';
import RegisterComponent from './components/RegisterComponent.vue';

const routes = [
    { path: '/', name: 'home', component: HomeComponent },
    { path: '/team', name: 'teams', component: TeamComponent },
    { path: '/users', name: 'users', component: AdminComponent },
    { path: '/login', name: 'login', component: LoginComponent },
    { path: '/register', name: 'register', component: RegisterComponent }
];

export default routes;