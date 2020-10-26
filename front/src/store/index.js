import Vue from "vue";
import Vuex from "vuex";
import createPersistedState from "vuex-persistedstate";
import {
  SET_IS_CONNECTED,
  SET_USERNAME,
  SET_USER_EMAIL,
  SET_USER_ID
} from "./mutation-types";

Vue.use(Vuex);

export default new Vuex.Store({
  plugins: [createPersistedState()],
  state: {
    user: {
      username: "",
      email: "",
      id: ""
    },
    isConnected: false
  },
  getters: {
    userState: state => {
      return state.user;
    },
    username: state => {
      return state.user.username;
    },
    userEmail: state => {
      return state.user.email;
    },
    userId: state => {
      return state.user.id;
    },
    isConnected: state => {
      return state.isConnected;
    }
  },
  mutations: {
    [SET_USERNAME](state, username) {
      state.user.username = username;
    },
    [SET_USER_EMAIL](state, email) {
      state.user.email = email;
    },
    [SET_USER_ID](state, id) {
      state.user.id = id;
    },
    [SET_IS_CONNECTED](state, isConnected) {
      state.isConnected = isConnected;
    }
  },
  actions: {
    setUser: ({ commit }, user) => {
      commit("SET_USER_EMAIL", user.email);
      commit("SET_USERNAME", user.username);
      commit("SET_USER_ID", user.id);
    },
    setIsConnected: ({ commit }, isConnected) => {
      commit("SET_IS_CONNECTED", isConnected);
    }
  },
  modules: {}
});
