import Vue from "vue";
import VueRouter from "vue-router";
import mainNav from "@/components/Layout/mainNav.vue";

Vue.use(VueRouter);

const routes = [
   { path: "/", redirect: { name: "Login" } },
  {
    path: "/",
    component: mainNav,
    children: [
      {
        path: "/",
        name: "Login",
        component: () =>
          import(/* webpackChunkName: "login" */ "../views/Login.vue")
      },
      {
        path: "/home",
        name: "Home",
        component: () =>
          import(/* webpackChunkName: "home" */ "../views/Home.vue")
      },
      {
        path: "/working-times",
        name: "Workingtimes",
        component: () =>
          import(/* webpackChunkName: "workingtimes" */ "../views/Workingtimes.vue")
      },
      {
        path: "/teams",
        name: "Teams",
        component: () =>
          import(/* webpackChunkName: "team" */ "../views/Team.vue")
      },
      {
        path: "/team/:id",
        name: "TeamDetails",
        component: () =>
          import(/* webpackChunkName: "teamDetails" */ "../views/TeamDetails.vue")
      },
      {
        path: "/test",
        name: "Test",
        component: () =>
          import(/* webpackChunkName: "test" */ "../views/Test.vue")
      }
    ]
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;
