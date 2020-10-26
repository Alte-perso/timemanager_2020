import Vue from "vue";
import VueRouter from "vue-router";
import mainNav from "@/components/Layout/mainNav.vue";

Vue.use(VueRouter);

const routes = [
  { path: "/", redirect: { name: "Home" } },
  {
    path: "/",
    component: mainNav,
    children: [
      {
        path: "/home",
        name: "Home",
        component: () =>
          import(/* webpackChunkName: "home" */ "../views/Home.vue")
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
